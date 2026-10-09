# =====================================================
# VALORES EXPUESTOS DE LA INFRAESTRUCTURA
# Estos outputs permiten consumir los recursos creados
# desde otros módulos o desde la línea de comandos
# =====================================================

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = module.vpc.vpc_cidr
}

output "vpc_name" {
  description = "Nombre de la VPC"
  value       = module.vpc.vpc_name
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_availability_zones" {
  description = "Zonas de disponibilidad de subredes públicas"
  value       = module.vpc.public_subnet_availability_zones
}

output "nat_gateway_ips" {
  description = "IPs elásticas de los NAT Gateways"
  value       = module.vpc.nat_gateway_ips
  sensitive   = true
}

output "instance_id" {
  description = "ID de la instancia EC2 principal"
  value       = module.ec2.instance_id
}

output "instance_private_ip" {
  description = "IP privada de la instancia EC2"
  value       = module.ec2.instance_private_ip
}

output "instance_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = module.ec2.instance_public_ip
}

output "instance_availability_zone" {
  description = "Zona de disponibilidad de la instancia"
  value       = module.ec2.instance_availability_zone
}

output "instance_state" {
  description = "Estado actual de la instancia"
  value       = module.ec2.instance_state
}

output "ec2_security_group_id" {
  description = "ID del grupo de seguridad de EC2"
  value       = module.ec2.security_group_id
}

output "ec2_security_group_name" {
  description = "Nombre del grupo de seguridad de EC2"
  value       = module.ec2.security_group_name
}

output "s3_bucket_names" {
  description = "Nombres de los buckets S3 creados"
  value       = module.s3.bucket_names
}

output "s3_bucket_arns" {
  description = "ARNs de los buckets S3 creados"
  value       = module.s3.bucket_arns
}

output "s3_bucket_domain_names" {
  description = "Nombres de dominio de los buckets S3"
  value       = module.s3.bucket_domain_names
}

output "s3_logs_bucket_name" {
  description = "Nombre del bucket de logs"
  value       = module.s3.logs_bucket_name
}

output "cloudwatch_log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = module.cloudwatch.log_group_name
}

output "cloudwatch_dashboard_name" {
  description = "Nombre del dashboard de CloudWatch"
  value       = module.cloudwatch.dashboard_name
}

output "cloudwatch_alarm_arns" {
  description = "ARNs de las alarmas de CloudWatch"
  value       = module.cloudwatch.alarm_arns
}

output "admin_security_group_id" {
  description = "ID del grupo de seguridad administrativo"
  value       = aws_security_group.admin_access.id
}

output "cost_optimization_policy_arn" {
  description = "ARN de la política de optimización de costos"
  value       = aws_iam_policy.cost_optimization_tag.arn
}

output "audit_log_group_name" {
  description = "Nombre del grupo de logs de auditoría"
  value       = aws_cloudwatch_log_group.audit.name
}

output "estimated_charges_alarm_arn" {
  description = "ARN de la alarma de cargos estimados"
  value       = aws_cloudwatch_metric_alarm.estimated_charges.arn
}

output "region" {
  description = "Región de AWS donde se despliega la infraestructura"
  value       = var.aws_region
}

output "environment" {
  description = "Ambiente de despliegue"
  value       = var.environment
}

output "all_resources_created" {
  description = "Confirmation de que todos los recursos fueron creados"
  value       = "Infraestructura completa desplegada en ${var.environment} para la región ${var.aws_region}"
}