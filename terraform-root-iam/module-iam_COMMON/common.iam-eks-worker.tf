#
# WORKER
#

data "aws_iam_policy_document" "eks_workers_assume_role_policy" {
  statement {
    sid = "EKSWorkerAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# INSTANCE PROFILE

resource "aws_iam_instance_profile" "eks_workers_launch_template" {
  name = "common-role-eks-worker"
  role = aws_iam_role.eks_workers.id
}

# WORKER ROLE

resource "aws_iam_role" "eks_workers" {
  name                  = "common-role-eks-worker"
  assume_role_policy    = data.aws_iam_policy_document.eks_workers_assume_role_policy.json
  force_detach_policies = true
}

resource "aws_iam_role_policy_attachment" "eks_workers_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_workers.name
}

resource "aws_iam_role_policy_attachment" "eks_workers_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_workers.name
}

resource "aws_iam_role_policy_attachment" "eks_workers_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_workers.name
}

resource "aws_iam_role_policy_attachment" "eks_workers_Cloudwatch" {
  policy_arn = aws_iam_policy.ec2_cloudwatch_monitoring.arn
  role       = aws_iam_role.eks_workers.name
}

# ASG Policies for Worker

resource "aws_iam_role_policy_attachment" "eks_workers_autoscaling" {
  policy_arn = aws_iam_policy.eks_worker_autoscaling.arn
  role       = aws_iam_role.eks_workers.name
}

resource "aws_iam_policy" "eks_worker_autoscaling" {
  name        = "common-policy-eks-worker-autoscaling"
  description = "EKS worker node autoscaling policy for cluster"
  policy      = data.aws_iam_policy_document.eks_worker_autoscaling.json
}

data "aws_iam_policy_document" "eks_worker_autoscaling" {
  statement {
    sid    = "eksWorkerAutoscalingAll"
    effect = "Allow"

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "ec2:DescribeLaunchTemplateVersions",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "eksWorkerAutoscalingOwn"
    effect = "Allow"

    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:UpdateAutoScalingGroup",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/k8s.io/cluster-autoscaler/enabled"
      values   = ["true"]
    }
  }
}
