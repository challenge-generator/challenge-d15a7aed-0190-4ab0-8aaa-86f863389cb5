terraform {
  required_version = ">= 1.5"
}

# =============================================================================
# Instancia EC2 - Máquina virtual en la nube
# =============================================================================
resource "aws_instance" "main" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  # Configuración de red
  vpc_security_group_ids = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip

  # Configuración de almacenamiento
  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
    encrypted   = var.encrypt_root_volume
    delete_on_termination = true
  }

  # Metadata de instancia
  lifecycle {
    create_before_destroy = true
  }

  # User data para inicialización básica
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Instance $(hostname -f) - ${var.environment}</h1>" > /var/www/html/index.html
              EOF

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-ec2-${count.index + 1}"
      Description = "Instancia EC2 para ${var.project} entorno ${var.environment}"
      Environment = var.environment
      Project     = var.project
    }
  )

  # Dependencia explícita de la VPC para asegurar orden de creación
  depends_on = [var.vpc_id]
}

# =============================================================================
# Security Group para EC2 - Reglas de acceso a la instancia
# =============================================================================
resource "aws_security_group" "ec2" {
  name        = "${var.project}-${var.environment}-ec2-sg"
  description = "Security group para instancias EC2"
  vpc_id      = var.vpc_id

  # SSH desde IP administrativa
  ingress {
    description     = "SSH from admin network"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = var.admin_cidr_blocks
    ipv6_cidr_blocks = []
  }

  # HTTP desde cualquier lugar
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS desde cualquier lugar
  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tráfico entre instancias en el mismo security group
  ingress {
    description     = "Self traffic"
    from_port       = -1
    to_port         = -1
    protocol        = "-1"
    self            = true
  }

  # Tráfico hacia internet (salida)
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
      Name        = "${var.project}-${var.environment}-ec2-sg"
      Description = "Security group para EC2"
    }
  )
}

# =============================================================================
# Elastic IP - IP pública estática para la instancia
# =============================================================================
resource "aws_eip" "ec2" {
  instance = aws_instance.main.id
  domain   = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-ec2-eip"
      Description = "Elastic IP para instancia EC2"
    }
  )

  depends_on = [aws_instance.main]
}

# =============================================================================
# Volume adicional para datos - Almacenamiento persistente
# =============================================================================
resource "aws_ebs_volume" "data" {
  availability_zone = var.availability_zone
  size              = var.data_volume_size
  type              = var.data_volume_type
  encrypted         = var.encrypt_data_volume

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-ec2-data"
      Description = "Volumen de datos para EC2"
    }
  )
}

# =============================================================================
# Attach del volumen de datos a la instancia
# =============================================================================
resource "aws_volume_attachment" "data_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.main.id

  depends_on = [aws_instance.main]
}