variable "aws_region" {
  description = "La región de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "environment" {
  description = "El ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "El bloque CIDR para la VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
}

variable "instance_type" {
  description = "El tipo de instancia EC2"
  type        = string
}

variable "ami_id" {
  description = "El ID de la AMI para las instancias EC2"
  type        = string
}

variable "key_name" {
  description = "El nombre de la clave SSH para acceder a las instancias EC2"
  type        = string
}

variable "bucket_name" {
  description = "El nombre del bucket S3"
  type        = string
}

variable "cloudwatch_alarm_name" {
  description = "El nombre de la alarma de CloudWatch"
  type        = string
}

variable "cloudwatch_metric_name" {
  description = "El nombre de la métrica de CloudWatch"
  type        = string
}

variable "cloudwatch_namespace" {
  description = "El namespace de la métrica de CloudWatch"
  type        = string
}

variable "cloudwatch_comparison_operator" {
  description = "El operador de comparación para la alarma de CloudWatch"
  type        = string
  default     = "GreaterThanThreshold"
}

variable "cloudwatch_evaluation_periods" {
  description = "El número de periodos de evaluación para la alarma de CloudWatch"
  type        = number
  default     = 2
}

variable "cloudwatch_period" {
  description = "La duración en segundos de cada periodo de evaluación para la alarma de CloudWatch"
  type        = number
  default     = 300
}

variable "cloudwatch_statistic" {
  description = "La estadística a aplicar a la métrica para la alarma de CloudWatch"
  type        = string
  default     = "Average"
}

variable "cloudwatch_threshold" {
  description = "El valor umbral para la alarma de CloudWatch"
  type        = number
  default     = 80
}

variable "tags" {
  description = "Etiquetas para los recursos de AWS"
  type        = map(string)
  default     = {}
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar nombres de host DNS en la VPC"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Asignar IP pública automáticamente al lanzar instancias en subredes públicas"
  type        = bool
  default     = true
}

variable "s3_force_destroy" {
  description = "Permitir la destrucción del bucket S3 incluso si contiene objetos"
  type        = bool
  default     = false
}

variable "s3_versioning_enabled" {
  description = "Habilitar versionamiento en el bucket S3"
  type        = bool
  default     = true
}