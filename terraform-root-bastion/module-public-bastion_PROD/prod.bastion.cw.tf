//locals {
//  bastion_instances = [
//    {
//      instanceId           = aws_instance.bastion_01.id
//      name                 = local.instance_name_bastion_01_prefix
//      index                = local.instance_name_bastion_01_index
//      rootDevice           = local.ebs_root_device_link
//    },
//  ]
//}
//
//resource "aws_cloudwatch_metric_alarm" "bastion_High-CPUUtilization" {
//  count = length(local.bastion_instances)
//
//  alarm_name          = "${lookup(local.bastion_instances[count.index], "name")}-${lookup(local.bastion_instances[count.index], "index")}/${var.environment}-High_CPUUtil"
//  comparison_operator = "GreaterThanOrEqualToThreshold"
//
//  period              = "300"
//  evaluation_periods  = "2"
//  datapoints_to_alarm = 2
//
//  # second
//  statistic         = "Average"
//  threshold         = "80"
//  alarm_description = ""
//
//  metric_name = "CPUUtilization"
//  namespace   = "AWS/EC2"
//
//  dimensions = {
//    InstanceId = lookup(local.bastion_instances[count.index], "instanceId")
//  }
//
//  actions_enabled           = true
//  insufficient_data_actions = []
//  ok_actions                = []
//
//  alarm_actions = [
//    // TODO: set SNS topic integrated w/ Slack
//  ]
//}
//
//# EC2 Custom Metric (Disk, Memory)
//
//resource "aws_cloudwatch_metric_alarm" "bastion_High-RootDiskUtil" {
//  count = length(local.bastion_instances)
//
//  alarm_name          = "${lookup(local.bastion_instances[count.index], "name")}-${lookup(local.bastion_instances[count.index], "index")}/${var.environment}-High_RootDiskUtil"
//  comparison_operator = "GreaterThanOrEqualToThreshold"
//
//  period              = "300"
//  evaluation_periods  = "2"
//  datapoints_to_alarm = 2
//
//  # second
//  statistic         = "Maximum"
//  threshold         = "80"
//  alarm_description = ""
//
//  metric_name = "DiskSpaceUtilization"
//  namespace   = "System/Linux"
//
//  dimensions = {
//    InstanceId = lookup(local.bastion_instances[count.index], "instanceId")
//    MountPath  = "/"
//    Filesystem = lookup(local.bastion_instances[count.index], "rootDevice")
//  }
//
//  actions_enabled = true
//
//  insufficient_data_actions = [
//    // TODO: set SNS topic integrated w/ Slack
//  ]
//
//  ok_actions = []
//
//  alarm_actions = [
//    // TODO: set SNS topic integrated w/ Slack
//  ]
//}
//
//resource "aws_cloudwatch_metric_alarm" "bastion_High-MemUtil" {
//  count = length(local.bastion_instances)
//
//  alarm_name          = "${lookup(local.bastion_instances[count.index], "name")}-${lookup(local.bastion_instances[count.index], "index")}/${var.environment}-High_MemUtil"
//  comparison_operator = "GreaterThanOrEqualToThreshold"
//
//  period              = "300"
//  evaluation_periods  = "2"
//  datapoints_to_alarm = 2
//
//  # second
//  statistic         = "Maximum"
//  threshold         = "80"
//  alarm_description = ""
//
//  metric_name = "MemoryUtilization"
//  namespace   = "System/Linux"
//
//  dimensions = {
//    InstanceId = lookup(local.bastion_instances[count.index], "instanceId")
//  }
//
//  actions_enabled = true
//
//  insufficient_data_actions = [
//    // TODO: set SNS topic integrated w/ Slack
//  ]
//
//  ok_actions = []
//
//  alarm_actions = [
//    // TODO: set SNS topic integrated w/ Slack
//  ]
//}
