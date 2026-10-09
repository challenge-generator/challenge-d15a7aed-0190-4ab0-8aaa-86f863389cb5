terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# =====================================================
# ORQUESTADOR DE INFRAESTRUCTURA AWS
# Este archivo coordina la creación de recursos usando
# módulos reutilizables para crear una landing zone básica
# =====================================================

# Módulo de VPC - Red virtual con subredes públicas y privadas
module "vpc" {
  source = "./modules/vpc"

  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  tags                  = var.common_tags
}

# Módulo de EC2 - Instancias de máquina virtual
module "ec2" {
  source = "./modules/ec2"

  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  instance_type         = var.instance_type
  key_name              = var.key_name
  instance_ami          = var.instance_ami
  user_data             = var.user_data
  security_group_ids    = var.security_group_ids
  tags                  = var.common_tags
  depends_on = [
    module.vpc
  ]
}

# Módulo de S3 - Almacenamiento de objetos
module "s3" {
  source = "./modules/s3"

  environment        = var.environment
  bucket_prefix      = var.bucket_prefix
  enable_versioning  = var.enable_s3_versioning
  enable_encryption  = var.enable_s3_encryption
  lifecycle_rules    = var.s3_lifecycle_rules
  tags               = var.common_tags
}

# Módulo de CloudWatch - Monitoreo y logs
module "cloudwatch" {
  source = "./modules/cloudwatch"

  environment           = var.environment
  log_retention_days    = var.log_retention_days
  alarm_email           = var.alarm_email
  instance_id           = module.ec2.instance_id
  vpc_id                = module.vpc.vpc_id
  tags                  = var.common_tags
  depends_on = [
    module.ec2,
    module.vpc
  ]
}

# =====================================================
# RECURSOS ADICIONALES A NIVEL DE CUENTA
# =====================================================

# Grupo de seguridad adicional para acceso admin
resource "aws_security_group" "admin_access" {
  name        = "${var.environment}-admin-access-sg"
  description = "Grupo de seguridad para acceso administrativo"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH desde IP administrativa"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip_range]
  }

  egress {
    description = "Salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-admin-access"
    }
  )
}

# Policy de etiquetado para optimización de costos
resource "aws_iam_policy" "cost_optimization_tag" {
  name        = "${var.environment}-cost-optimization-policy"
  description = "Política para aplicar etiquetas de costo a recursos"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateTags",
          "ec2:DeleteTags",
          "s3:PutBucketTagging",
          "s3:GetBucketTagging"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:RequestTag/Environment" = [var.environment]
          }
        }
      }
    ]
  })

  tags = var.common_tags
}

# Log group para auditoría de operaciones
resource "aws_cloudwatch_log_group" "audit" {
  name              = "/aws/${var.environment}/audit"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.cloudwatch_kms_key_arn

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-audit-logs"
    }
  )
}

# Alarma de costo estimado
resource "aws_cloudwatch_metric_alarm" "estimated_charges" {
  alarm_name          = "${var.environment}-estimated-charges-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "21600"
  statistic           = "Maximum"
  threshold           = var.cost_alert_threshold
  alarm_description   = "Alarma cuando los cargos estimados excedan el umbral"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ServiceName = "AmazonEC2"
  }

  tags = var.common_tags
}