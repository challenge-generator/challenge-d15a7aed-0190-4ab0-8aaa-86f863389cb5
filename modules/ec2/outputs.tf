output "instance_id" {
  description = "ID de la instancia EC2 creada"
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value       = aws_instance.this.public_ip
}

output "instance_private_ip" {
  description = "Dirección IP privada de la instancia EC2"
  value       = aws_instance.this.private_ip
}

output "instance_arn" {
  description = "ARN de la instancia EC2"
  value       = aws_instance.this.arn
}

output "instance_primary_network_interface_id" {
  description = "ID de la interfaz de red primaria"
  value       = aws_instance.this.primary_network_interface_id
}

output "instance_security_group" {
  description = "ID del security group asociado a la instancia"
  value       = aws_instance.this.security_groups
}

output "instance_tags" {
  description = "Etiquetas aplicadas a la instancia"
  value       = aws_instance.this.tags
}

output "instance_availability_zone" {
  description = "Zona de disponibilidad donde se aprovisionó la instancia"
  value       = aws_instance.this.availability_zone
}

output "instance_state" {
  description = "Estado actual de la instancia"
  value       = aws_instance.this.instance_state
}

output "ebs_device_name" {
  description = "Nombre del dispositivo EBS attached a la instancia"
  value       = aws_instance.this.root_block_device[0].device_name
}

output "ebs_volume_id" {
  description = "ID del volumen EBS raíz"
  value       = aws_instance.this.root_block_device[0].volume_id
}

output "private_dns" {
  description = "Nombre DNS privado de la instancia"
  value       = aws_instance.this.private_dns
}

output "public_dns" {
  description = "Nombre DNS público de la instancia"
  value       = aws_instance.this.public_dns
}