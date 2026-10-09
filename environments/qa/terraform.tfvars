# Configuración de variables para el ambiente de QA
# Este archivo define los valores específicos del entorno QA
# Incluye configuraciones más cercanas a producción para pruebas realistas

environment_name = "qa"

# Configuración de la VPC - QA usa subredes más pequeñas pero múltiples AZ
vpc_cidr_block           = "10.1.0.0/16"
public_subnet_cidr_1    = "10.1.1.0/24"
public_subnet_cidr_2    = "10.1.2.0/24"
private_subnet_cidr_1   = "10.1.10.0/24"
private_subnet_cidr_2   = "10.1.11.0/24"
availability_zones      = ["us-east-1a", "us-east-1b"]

# Configuración de EC2 para QA - mayor capacidad que DEV
instance_type           = "t3.small"
instance_ami            = "ami-0c55b159cbfafe1f0"
instance_volume_size    = 30
instance_volume_type    = "gp3"
environment             = "qa"

# Configuración de S3 para QA
s3_bucket_name          = "qa-infra-storage-assets"
s3_enable_versioning   = true
s3_enable_encryption    = true
s3_lifecycle_days       = 60

# Configuración de CloudWatch para QA
enable_detailed_monitoring = true
log_retention_days         = 14
alarm_email                = "devops-qa@empresa.com"
cpu_threshold_alarm        = 75
memory_threshold_alarm     = 80

# Etiquetas para optimización de costos
tags = {
  Environment = "qa"
  Project     = "infra-gestion"
  CostCenter  = "qa-team"
  ManagedBy   = "terraform"
  Owner       = "cloud-team"
}

# Configuración de alta disponibilidad para QA
enable_multi_az         = true
create_nat_gateway      = true
single_az_instance      = false

# Configuración de redundancia y recuperación
enable_deletion_protection = true
backup_retention_days      = 7