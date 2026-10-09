# =====================================================
# CONFIGURACIÓN DEL BACKEND REMOTO
# Almacena el estado de Terraform en S3 con locking
# mediante DynamoDB para entornos colaborativos
# =====================================================

terraform {
  backend "s3" {
    bucket         = "terraform-state-${var.backend_bucket_suffix}"
    key            = "${var.environment}/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "terraform-state-lock"

    # Configuración de acceso consistente
    http = {
      retry = {
        max_attempts     = 4
        min_delay_ms     = 100
        max_delay_ms     = 1000
        jitter_percent   = 0.1
      }
    }
  }
}

# =====================================================
# RECURSOS PARA SOPORTE DEL BACKEND
# Estos recursos deben existir antes de usar el backend
# Se crean aquí para facilitar la primera ejecución
# =====================================================

# Bucket S3 para almacenar el estado de Terraform
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-${var.backend_bucket_suffix}"

  tags = merge(
    var.common_tags,
    {
      Name        = "terraform-state-${var.backend_bucket_suffix}"
      Description = "Bucket para almacenamiento del estado de Terraform"
      Purpose     = "terraform-remote-state"
    }
  )
}

# Versionado del bucket de estado
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Cifrado del bucket de estado
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bloqueo público del bucket
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Tabla DynamoDB para locking del estado
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = "ExpiresAt"
    enabled        = true
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "terraform-state-lock"
      Description = "Tabla de locking para estado de Terraform"
      Purpose     = "terraform-state-lock"
    }
  )
}

# Política de acceso al bucket de estado
resource "aws_s3_bucket_policy" "terraform_state_policy" {
  bucket = aws_s3_bucket.terraform_state.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "DenyUnEncryptedObjectUploads"
        Effect = "Deny"
        Principal = "*"
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.terraform_state.arn}/*"
        Condition = {
          StringNotEquals = {
            "s3:x-amz-server-side-encryption" = "AES256"
          }
        }
      },
      {
        Sid = "DenyInsecureTransport"
        Effect = "Deny"
        Principal = "*"
        Action = "s3:*"
        Resource = [
          "${aws_s3_bucket.terraform_state.arn}",
          "${aws_s3_bucket.terraform_state.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

# Política de acceso a la tabla de locking
resource "aws_dynamodb_table_policy" "terraform_state_lock_policy" {
  name         = aws_dynamodb_table.terraform_state_lock.name
  policy       = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable"
        ]
        Resource = aws_dynamodb_table.terraform_state_lock.arn
        Condition = {
          Bool = {
            "aws:SecureTransport" = "true"
          }
        }
      }
    ]
  })
}