# Configuración de variables para el ambiente de desarrollo
# Este archivo define los valores específicos del entorno DEV

environment_name = "dev"

# Configuración de la VPC
vpc_cidr_block           = "10.0.0.0/16"
public_subnet_cidr_1    = "10.0.1.0/24"
public_subnet_cidr_2    = "10.0.2.0/24"
private_subnet_cidr_1   = "10.0.10.0/24"
private_subnet_cidr_2   = "10.0.11.0/24"
availability_zones      = ["us-east-1a", "us-east-1b"]

# Configuración de EC2 para desarrollo
instance_type           = "t3.micro"
instance_ami            = "ami-0c55b159cbfafe1f0"
instance_volume_size    = 20
instance_volume_type    = "gp3"
environment             = "development"

# Configuración de S3 para desarrollo
s3_bucket_name          = "dev-infra-storage-assets"
s3_enable_versioning   = false
s3_enable_encryption    = true
s3_lifecycle_days       = 30

# Configuración de CloudWatch para desarrollo
enable_detailed_monitoring = false
log_retention_days         = 7
alarm_email                = "devops-dev@empresa.com"
cpu_threshold_alarm        = 80
memory_threshold_alarm     = 85

# Etiquetas para optimización de costos
tags = {
  Environment = "development"
  Project     = "infra-gestion"
  CostCenter  = "dev-team"
  ManagedBy   = "terraform"
  Owner       = "cloud-team"
}

# Configuración de alta disponibilidad (desarrollo: menor costo)
enable_multi_az         = false
create_nat_gateway      = true
single_az_instance      = true