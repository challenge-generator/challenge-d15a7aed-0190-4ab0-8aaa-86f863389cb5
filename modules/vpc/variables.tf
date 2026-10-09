variable "vpc_cidr" {
  description = "El bloque CIDR para la VPC"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "El CIDR de la VPC debe ser una dirección CIDR válida (ejemplo: 10.0.0.0/16)."
  }
}

variable "public_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
  validation {
    condition = alltrue([
      for cidr in var.public_subnet_cidrs : can(cidrhost(cidr, 0))
    ])
    error_message = "Todos los CIDRs de subredes públicas deben ser válidos."
  }
}

variable "private_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
  validation {
    condition = alltrue([
      for cidr in var.private_subnet_cidrs : can(cidrhost(cidr, 0))
    ])
    error_message = "Todos los CIDRs de subredes privadas deben ser válidos."
  }
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

variable "tags" {
  description = "Etiquetas para los recursos de la VPC"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "El ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad para crear subredes"
  type        = list(string)
  default     = []
}

variable "create_nat_gateway" {
  description = "Indica si se debe crear un NAT Gateway para las subredes privadas"
  type        = bool
  default     = true
}

variable "nat_gateway_single" {
  description = "Indica si se debe crear un solo NAT Gateway para todas las subredes privadas"
  type        = bool
  default     = false
}