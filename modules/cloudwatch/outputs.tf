output "log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = aws_cloudwatch_log_group.main.name
}

output "log_group_arn" {
  description = "ARN del grupo de logs de CloudWatch"
  value       = aws_cloudwatch_log_group.main.arn
}

output "sns_topic_arn" {
  description = "ARN del topic SNS para alertas"
  value       = aws_sns_topic.alerts.arn
}

output "sns_topic_name" {
  description = "Nombre del topic SNS para alertas"
  value       = aws_sns_topic.alerts.name
}

output "cpu_alarm_arn" {
  description = "ARN de la alarma de CPU alto"
  value       = aws_cloudwatch_metric_alarm.cpu_high.arn
}

output "memory_alarm_arn" {
  description = "ARN de la alarma de memoria alta"
  value       = aws_cloudwatch_metric_alarm.memory_high.arn
}

output "disk_alarm_arn" {
  description = "ARN de la alarma de disco alto"
  value       = aws_cloudwatch_metric_alarm.disk_high.arn
}

output "network_in_alarm_arn" {
  description = "ARN de la alarma de tráfico de entrada alto"
  value       = aws_cloudwatch_metric_alarm.network_in_high.arn
}

output "network_out_alarm_arn" {
  description = "ARN de la alarma de tráfico de salida alto"
  value       = aws_cloudwatch_metric_alarm.network_out_high.arn
}

output "status_check_alarm_arn" {
  description = "ARN de la alarma de status check fallido"
  value       = aws_cloudwatch_metric_alarm.status_check_failed.arn
}

output "error_alarm_arn" {
  description = "ARN de la alarma de conteo de errores"
  value       = aws_cloudwatch_metric_alarm.error_count.arn
}

output "warning_alarm_arn" {
  description = "ARN de la alarma de conteo de warnings"
  value       = aws_cloudwatch_metric_alarm.warning_count.arn
}

output "dashboard_name" {
  description = "Nombre del dashboard de CloudWatch"
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}

output "dashboard_url" {
  description = "URL del dashboard de CloudWatch"
  value       = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#dashboards:name=${aws_cloudwatch_dashboard.main.dashboard_name}"
}

output "all_alarm_arns" {
  description = "Lista de ARNs de todas las alarmas creadas"
  value = [
    aws_cloudwatch_metric_alarm.cpu_high.arn,
    aws_cloudwatch_metric_alarm.memory_high.arn,
    aws_cloudwatch_metric_alarm.disk_high.arn,
    aws_cloudwatch_metric_alarm.network_in_high.arn,
    aws_cloudwatch_metric_alarm.network_out_high.arn,
    aws_cloudwatch_metric_alarm.status_check_failed.arn,
    aws_cloudwatch_metric_alarm.error_count.arn,
    aws_cloudwatch_metric_alarm.warning_count.arn
  ]
}

output "alarm_names" {
  description = "Lista de nombres de todas las alarmas creadas"
  value = [
    aws_cloudwatch_metric_alarm.cpu_high.alarm_name,
    aws_cloudwatch_metric_alarm.memory_high.alarm_name,
    aws_cloudwatch_metric_alarm.disk_high.alarm_name,
    aws_cloudwatch_metric_alarm.network_in_high.alarm_name,
    aws_cloudwatch_metric_alarm.network_out_high.alarm_name,
    aws_cloudwatch_metric_alarm.status_check_failed.alarm_name,
    aws_cloudwatch_metric_alarm.error_count.alarm_name,
    aws_cloudwatch_metric_alarm.warning_count.alarm_name
  ]
}