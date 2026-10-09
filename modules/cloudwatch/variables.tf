variable "alarm_name" {
  description = "El nombre de la alarma de CloudWatch"
  type        = string
}

variable "metric_name" {
  description = "El nombre de la métrica de CloudWatch"
  type        = string
}

variable "namespace" {
  description = "El namespace de la métrica de CloudWatch"
  type        = string
}

variable "comparison_operator" {
  description = "El operador de comparación para la alarma de CloudWatch"
  type        = string
  default     = "GreaterThanThreshold"
  validation {
    condition     = contains(["GreaterThanOrEqualToThreshold", "GreaterThanThreshold", "LessThanThreshold", "LessThanOrEqualToThreshold"], var.comparison_operator)
    error_message = "El operador de comparación debe ser uno de: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
  }
}

variable "evaluation_periods" {
  description = "El número de periodos de evaluación para la alarma de CloudWatch"
  type        = number
  default     = 2
}

variable "period" {
  description = "La duración en segundos de cada periodo de evaluación para la alarma de CloudWatch"
  type        = number
  default     = 300
}

variable "statistic" {
  description = "La estadística a aplicar a la métrica para la alarma de CloudWatch"
  type        = string
  default     = "Average"
  validation {
    condition     = contains(["SampleCount", "Average", "Sum", "Minimum", "Maximum"], var.statistic)
    error_message = "La estadística debe ser una de: SampleCount, Average, Sum, Minimum, Maximum."
  }
}

variable "threshold" {
  description = "El valor umbral para la alarma de CloudWatch"
  type        = number
  default     = 80
}

variable "alarm_description" {
  description = "La descripción de la alarma de CloudWatch"
  type        = string
  default     = ""
}

variable "alarm_actions" {
  description = "Lista de acciones a realizar cuando la alarma se dispara"
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "Lista de acciones a realizar cuando la alarma vuelve a OK"
  type        = list(string)
  default     = []
}

variable "insufficient_data_actions" {
  description = "Lista de acciones a realizar cuando la alarma tiene datos insuficientes"
  type        = list(string)
  default     = []
}

variable "dimensions" {
  description = "Dimensiones para la métrica de CloudWatch"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Etiquetas para la alarma de CloudWatch"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "El ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "treat_missing_data" {
  description = "Cómo tratar los datos faltantes para la alarma"
  type        = string
  default     = "missing"
  validation {
    condition     = contains(["missing", "ignore", "breaching", "notBreaching"], var.treat_missing_data)
    error_message = "El valor debe ser uno de: missing, ignore, breaching, notBreaching."
  }
}