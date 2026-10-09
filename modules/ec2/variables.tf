variable "instance_type" {
  description = "El tipo de instancia EC2"
  type        = string
  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium", "m5.large", "m5.xlarge"], var.instance_type)
    error_message = "El tipo de instancia debe ser uno de: t3.micro, t3.small, t3.medium, m5.large, m5.xlarge."
  }
}

variable "ami_id" {
  description = "El ID de la AMI para las instancias EC2"
  type        = string
  validation {
    condition     = length(var.ami_id) > 4 && substr(var.ami_id, 0, 4) == "ami-"
    error_message = "El AMI ID debe comenzar con 'ami-'."
  }
}

variable "key_name" {
  description = "El nombre de la clave SSH para acceder a las instancias EC2"
  type        = string
}

variable "subnet_id" {
  description = "El ID de la subred donde se lanzará la instancia EC2"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Lista de IDs de grupos de seguridad para la instancia EC2"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Etiquetas para la instancia EC2"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "El ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "instance_count" {
  description = "Número de instancias EC2 a crear"
  type        = number
  default     = 1
}

variable "user_data" {
  description = "Script de user data para la instancia EC2"
  type        = string
  default     = ""
}

variable "root_block_device" {
  description = "Configuración del bloque de dispositivo raíz"
  type = object({
    volume_size = number
    volume_type = string
    encrypted   = bool
  })
  default = {
    volume_size = 8
    volume_type = "gp2"
    encrypted   = false
  }
}

variable "ebs_optimized" {
  description = "Indica si la instancia debe estar optimizada para EBS"
  type        = bool
  default     = false
}