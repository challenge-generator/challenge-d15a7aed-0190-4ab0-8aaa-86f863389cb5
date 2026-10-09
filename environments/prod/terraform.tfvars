# Configuración de variables para el ambiente de producción
# Este archivo define los valores específicos del entorno PROD
# Máxima disponibilidad, seguridad y optimización de costos corporativa

environment_name = "prod"

# Configuración de la VPC - Producción usa CIDR completo con múltiples AZ
vpc_cidr_block           = "10.2.0.0/16"
public_subnet_cidr_1    = "10.2.1.0/24"
public_subnet_cidr_2    = "10.2.2.0/24"
public_subnet_cidr_3    = "10.2.3.0/24"
private_subnet_cidr_1   = "10.2.10.0/24"
private_subnet_cidr_2   = "10.2.11.0/24"
private_subnet_cidr_3   = "10.2.12.0/24"
availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Configuración de EC2 para producción - alta disponibilidad
instance_type           = "t3.medium"
instance_ami            = "ami-0c55b159cbfafe1f0"
instance_volume_size    = 50
instance_volume_type    = "gp3"
environment             = "production"

# Configuración de S3 para producción - máxima redundancia
s3_bucket_name          = "prod-infra-storage-assets"
s3_enable_versioning   = true
s3_enable_encryption    = true
s3_lifecycle_days       = 90
s3_replication_enabled  = true
s3_access_logging       = true

# Configuración de CloudWatch para producción - monitoreo completo
enable_detailed_monitoring = true
log_retention_days         = 30
alarm_email                = "devops-prod@empresa.com"
cpu_threshold_alarm        = 70
memory_threshold_alarm     = 75
disk_threshold_alarm       = 80
network_in_threshold       = 100000000
network_out_threshold      = 50000000

# Etiquetas para optimización de costos y gobierno
tags = {
  Environment = "production"
  Project     = "infra-gestion"
  CostCenter  = "prod-operations"
  ManagedBy   = "terraform"
  Owner       = "cloud-team"
  Compliance  = "HIPAA-ready"
  Backup      = "required"
  Criticality = "high"
}

# Configuración de alta disponibilidad para producción
enable_multi_az           = true
create_nat_gateway        = true
single_az_instance        = false
enable_flow_logs          = true
enable_vpn_connection     = true

# Configuración de recuperación ante desastres
enable_deletion_protection = true
backup_retention_days      = 30
rto_minutes               = 30
rpo_minutes               = 15

# Configuración de seguridad avanzada
enable_security_groups    = true
enable_nacls              = true
enable_dhcp_options       = true
enable_vpc_endpoints      = true

# Límites y cuotas específicas del ambiente
max_instance_count        = 10
autoscale_min             = 2
autoscale_max             = 8