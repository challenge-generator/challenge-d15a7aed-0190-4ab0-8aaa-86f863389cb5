variable "bucket_name" {
  description = "El nombre del bucket S3"
  type        = string
  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 && can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket_name))
    error_message = "El nombre del bucket debe tener entre 3 y 63 caracteres, comenzar y terminar con una letra minúscula o número, y solo contener letras minúsculas, números, puntos y guiones."
  }
}

variable "tags" {
  description = "Etiquetas para el bucket S3"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "El ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "force_destroy" {
  description = "Permitir la destrucción del bucket S3 incluso si contiene objetos"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Habilitar versionamiento en el bucket S3"
  type        = bool
  default     = true
}

variable "server_side_encryption_enabled" {
  description = "Habilitar cifrado del lado del servidor en el bucket S3"
  type        = bool
  default     = true
}

variable "block_public_acls" {
  description = "Bloquear ACLs públicas en el bucket S3"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Bloquear políticas públicas en el bucket S3"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignorar ACLs públicas en el bucket S3"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restringir buckets públicos en el bucket S3"
  type        = bool
  default     = true
}

variable "lifecycle_rules" {
  description = "Reglas de ciclo de vida para el bucket S3"
  type = list(object({
    id                                     = string
    enabled                                = bool
    prefix                                 = string
    tags                                   = map(string)
    transition                             = list(object({
      days          = number
      storage_class = string
    }))
    expiration = object({
      days = number
    })
    noncurrent_version_transition = list(object({
      days          = number
      storage_class = string
    }))
    noncurrent_version_expiration = object({
      days = number
    })
  }))
  default = []
}