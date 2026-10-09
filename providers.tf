terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(
      var.tags,
      {
        Environment = var.environment
        ManagedBy   = "Terraform"
      }
    )
  }
}

# Configuración adicional para manejo de errores en la inicialización del provider
# y validación de credenciales antes de proceder con la creación de recursos
locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}

# Validación de región soportada
data "aws_regions" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  valid_regions = data.aws_regions.available.names
}

# Verificación de que la región especificada es válida
resource "null_resource" "validate_region" {
  triggers = {
    region = var.aws_region
  }

  provisioner "local-exec" {
    command = <<EOT
      if [[ ! " ${local.valid_regions[@]} " =~ " ${var.aws_region} " ]]; then
        echo "Error: La región '${var.aws_region}' no es válida o no está disponible."
        exit 1
      fi
    EOT
    interpreter = ["bash", "-c"]
  }
}

# Configuración de proveedor alternativo para operaciones en otras regiones si es necesario
provider "aws" {
  alias  = "secondary"
  region = "us-east-1" # Región secundaria para servicios globales como IAM
}