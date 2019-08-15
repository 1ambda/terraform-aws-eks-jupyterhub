locals {
  instance_purpose_basic = "ec2-basic"
}

#
# Role, Instance Profile
#

resource "aws_iam_role" "basic" {
  name = "${lower(var.environment)}-role-${local.instance_purpose_basic}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "basic" {
  name = "${lower(var.environment)}-role-${local.instance_purpose_basic}"
  role = aws_iam_role.basic.name
}



# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/QuickStartEC2Instance.html
resource "aws_iam_policy" "ec2_cloudwatch_monitoring" {
  name = "${lower(var.environment)}-policy-ec2-monitoring"
  path = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudwatch:PutMetricData",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics",
        "ec2:DescribeTags",
        "logs:DescribeLogGroups",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams",
        "cloudwatch:ListMetrics"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ec2_operation_tags" {
  name = "${lower(var.environment)}-policy-ec2-operation-tags"
  path = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:CreateTags",
                "ec2:DeleteTags"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "ec2_operation_private_ip" {
  name = "${lower(var.environment)}-policy-ec2-operation-private-ip"
  path = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AssignPrivateIpAddresses"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "ec2_operation_volume" {
  name = "${lower(var.environment)}-policy-ec2-operation-volume"
  path = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVolumes"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}


#
# Policy Attachments
#

resource "aws_iam_role_policy_attachment" "basic_cloudwatch" {
  role       = aws_iam_role.basic.name
  policy_arn = aws_iam_policy.ec2_cloudwatch_monitoring.arn
}

resource "aws_iam_role_policy_attachment" "basic_operation_private_ip" {
  role       = aws_iam_role.basic.name
  policy_arn = aws_iam_policy.ec2_operation_private_ip.arn
}

resource "aws_iam_role_policy_attachment" "basic_operation_volume" {
  role       = aws_iam_role.basic.name
  policy_arn = aws_iam_policy.ec2_operation_volume.arn
}

