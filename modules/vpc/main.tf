terraform {
  required_version = ">= 1.5"
}

# =============================================================================
# VPC Principal - Red virtual donde se aprovisionan los recursos
# =============================================================================
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-vpc"
      Description = "VPC principal para ${var.project} entorno ${var.environment}"
    }
  )
}

# =============================================================================
# Internet Gateway - Permite conectividad outbound a internet
# =============================================================================
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-igw"
      Description = "Internet Gateway para conectividad pública"
    }
  )
}

# =============================================================================
# Subredes Públicas - Para recursos que requieren acceso a internet
# =============================================================================
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-public-subnet-a"
      Type        = "public"
      Description = "Subred pública en zona a"
    }
  )
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-public-subnet-b"
      Type        = "public"
      Description = "Subred pública en zona b"
    }
  )
}

# =============================================================================
# Subredes Privadas - Para recursos internos sin exposición directa
# =============================================================================
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = "${var.region}a"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-private-subnet-a"
      Type        = "private"
      Description = "Subred privada en zona a"
    }
  )
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = "${var.region}b"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-private-subnet-b"
      Type        = "private"
      Description = "Subred privada en zona b"
    }
  )
}

# =============================================================================
# Elastic IPs - IPs elásticas para NAT Gateway en subredes privadas
# =============================================================================
resource "aws_eip" "nat_a" {
  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-eip-nat-a"
      Description = "EIP para NAT Gateway zona a"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# =============================================================================
# NAT Gateways - Permiten conectividad outbound desde subredes privadas
# =============================================================================
resource "aws_nat_gateway" "main_a" {
  allocation_id = aws_eip.nat_a.id
  subnet_id     = aws_subnet.public_a.id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-nat-a"
      Description = "NAT Gateway para subredes privadas zona a"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# =============================================================================
# Tabla de Rutas Pública - Ruta por defecto hacia Internet Gateway
# =============================================================================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-public-rt"
      Description = "Tabla de rutas pública"
    }
  )
}

# =============================================================================
# Tabla de Rutas Privada - Ruta por defecto hacia NAT Gateway
# =============================================================================
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_a.id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-private-rt"
      Description = "Tabla de rutas privada"
    }
  )
}

# =============================================================================
# Asociaciones de Subredes a Tablas de Rutas
# =============================================================================
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

# =============================================================================
# Security Group Principal - Reglas de seguridad para la VPC
# =============================================================================
resource "aws_security_group" "main" {
  name        = "${var.project}-${var.environment}-main-sg"
  description = "Security group principal con reglas básicas de acceso"
  vpc_id      = aws_vpc.main.id

  # Reglas de entrada
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Reglas de salida - permitir todo el tráfico saliente
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-main-sg"
      Description = "Security group principal"
    }
  )
}

# =============================================================================
# Security Group para ALB - Permite tráfico HTTP/HTTPS desde internet
# =============================================================================
resource "aws_security_group" "alb" {
  name        = "${var.project}-${var.environment}-alb-sg"
  description = "Security group para Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-alb-sg"
      Description = "Security group para ALB"
    }
  )
}