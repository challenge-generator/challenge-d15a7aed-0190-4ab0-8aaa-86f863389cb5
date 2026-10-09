# =============================================================================
# Outputs del Módulo VPC - Información expuesta para otros módulos
# =============================================================================

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_default_security_group_id" {
  description = "ID del security group por defecto de la VPC"
  value       = aws_vpc.main.default_security_group_id
}

output "igw_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "public_subnet_cidrs" {
  description = "Bloques CIDR de las subredes públicas"
  value       = [aws_subnet.public_a.cidr_block, aws_subnet.public_b.cidr_block]
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "private_subnet_cidrs" {
  description = "Bloques CIDR de las subredes privadas"
  value       = [aws_subnet.private_a.cidr_block, aws_subnet.private_b.cidr_block]
}

output "main_security_group_id" {
  description = "ID del security group principal"
  value       = aws_security_group.main.id
}

output "alb_security_group_id" {
  description = "ID del security group del ALB"
  value       = aws_security_group.alb.id
}

output "nat_gateway_id" {
  description = "ID del NAT Gateway"
  value       = aws_nat_gateway.main_a.id
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID de la tabla de rutas privada"
  value       = aws_route_table.private.id
}

output "availability_zones" {
  description = "Zonas de disponibilidad utilizadas"
  value       = ["${var.region}a", "${var.region}b"]
}