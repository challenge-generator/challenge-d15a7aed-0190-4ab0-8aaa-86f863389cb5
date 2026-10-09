output "bucket_id" {
  description = "ID único del bucket S3"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.this.arn
}

output "bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_domain_name" {
  description = "Nombre de dominio del bucket S3"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Nombre de dominio regional del bucket S3"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

output "bucket_endpoint" {
  description = "Endpoint del bucket S3"
  value       = "https://${aws_s3_bucket.this.bucket_domain_name}"
}

output "bucket_region" {
  description = "Región donde está creado el bucket S3"
  value       = aws_s3_bucket.this.region
}

output "versioning_enabled" {
  description = "Indica si el versionado está habilitado"
  value       = var.enable_versioning
}

output "sse_algorithm" {
  description = "Algoritmo de cifrado usado"
  value       = var.sse_algorithm
}

output "tags" {
  description = "Etiquetas aplicadas al bucket"
  value       = aws_s3_bucket.this.tags
}

output "creation_date" {
  description = "Fecha de creación del bucket"
  value       = aws_s3_bucket.this.creation_date
}