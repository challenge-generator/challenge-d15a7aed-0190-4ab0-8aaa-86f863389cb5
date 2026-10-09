resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/${var.environment}/${var.project_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kms_key_arn
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-log-group"
      Environment = var.environment
      Module      = "cloudwatch"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.project_name}-cpu-utilization-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "This metric monitors EC2 CPU utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-cpu-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  alarm_name          = "${var.project_name}-memory-utilization-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.memory_threshold
  alarm_description   = "This metric monitors memory utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-memory-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "disk_high" {
  alarm_name          = "${var.project_name}-disk-utilization-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "DiskSpaceUtilization"
  namespace           = "System/Linux"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.disk_threshold
  alarm_description   = "This metric monitors disk space utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-disk-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "network_in_high" {
  alarm_name          = "${var.project_name}-network-in-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Sum"
  threshold           = var.network_threshold
  alarm_description   = "This metric monitors network ingress traffic"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-network-in-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "network_out_high" {
  alarm_name          = "${var.project_name}-network-out-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Sum"
  threshold           = var.network_threshold
  alarm_description   = "This metric monitors network egress traffic"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-network-out-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  alarm_name          = "${var.project_name}-status-check-failed-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "This metric monitors EC2 status check failures"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-status-check-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
      Severity    = "critical"
    }
  )
}

resource "aws_sns_topic" "alerts" {
  name              = "${var.project_name}-alerts-${var.environment}"
  display_name     = "${var.project_name} CloudWatch Alerts"
  kms_master_key_id = var.kms_key_arn
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-alerts-topic"
      Environment = var.environment
      Module      = "cloudwatch"
    }
  )
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard-${var.environment}"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", var.instance_id],
            [".", "Average"]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "CPU Utilization"
          annotations = {
            horizontal = [
              {
                value  = var.cpu_threshold
                label  = "CPU Threshold"
                color  = "#ff0000"
              }
            ]
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["System/Linux", "MemoryUtilization", "InstanceId", var.instance_id],
            [".", "Average"]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "Memory Utilization"
          annotations = {
            horizontal = [
              {
                value  = var.memory_threshold
                label  = "Memory Threshold"
                color  = "#ff0000"
              }
            ]
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/EC2", "NetworkIn", "InstanceId", var.instance_id],
            [".", "Sum"]
          ]
          period = 300
          stat   = "Sum"
          region = var.aws_region
          title  = "Network In"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/EC2", "NetworkOut", "InstanceId", var.instance_id],
            [".", "Sum"]
          ]
          period = 300
          stat   = "Sum"
          region = var.aws_region
          title  = "Network Out"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/EC2", "DiskSpaceUtilization", "InstanceId", var.instance_id, "Path", "/"],
            [".", "Average"]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "Disk Space Utilization"
          annotations = {
            horizontal = [
              {
                value  = var.disk_threshold
                label  = "Disk Threshold"
                color  = "#ff0000"
              }
            ]
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/EC2", "StatusCheckFailed", "InstanceId", var.instance_id],
            [".", "Maximum"]
          ]
          period = 60
          stat   = "Maximum"
          region = var.aws_region
          title  = "Status Check Failed"
        }
      }
    ]
  })
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-dashboard"
      Environment = var.environment
      Module      = "cloudwatch"
    }
  )
}

resource "aws_cloudwatch_log_metric_filter" "error_filter" {
  name           = "${var.project_name}-error-filter-${var.environment}"
  pattern        = "ERROR"
  log_group_name = aws_cloudwatch_log_group.main.name
  metric_transformation {
    name      = "ErrorCount"
    namespace = "${var.project_name}/Logs"
    value     = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_metric_alarm" "error_count" {
  alarm_name          = "${var.project_name}-error-count-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ErrorCount"
  namespace           = "${var.project_name}/Logs"
  period              = 60
  statistic           = "Sum"
  threshold           = var.error_threshold
  alarm_description   = "This metric monitors error log count"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-error-count-alarm"
      Environment = var.environment
      Type        = "log-alarm"
    }
  )
}

resource "aws_cloudwatch_log_metric_filter" "warning_filter" {
  name           = "${var.project_name}-warning-filter-${var.environment}"
  pattern        = "WARNING"
  log_group_name = aws_cloudwatch_log_group.main.name
  metric_transformation {
    name      = "WarningCount"
    namespace = "${var.project_name}/Logs"
    value     = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_metric_alarm" "warning_count" {
  alarm_name          = "${var.project_name}-warning-count-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "WarningCount"
  namespace           = "${var.project_name}/Logs"
  period              = 300
  statistic           = "Sum"
  threshold           = var.warning_threshold
  alarm_description   = "This metric monitors warning log count"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-warning-count-alarm"
      Environment = var.environment
      Type        = "log-alarm"
    }
  )
}