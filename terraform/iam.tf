resource "aws_iam_role" "host" {
  name_prefix        = "${var.name}-host-role-"
  description        = "IAM for EC2 to assume for ${var.name}-host"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    aws_iam_policy.host.arn
  ]

  tags = {
    Name     = "${var.name}-host-role"
    Template = "iam.tf"
  }
}

resource "aws_iam_policy" "host" {
  name_prefix = "${var.name}-host-policy-"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid      = "AllowNotificationHookForASG"
        Effect   = "Allow"
        Action   = "autoscaling:CompleteLifecycleAction"
        Resource = "arn:aws:autoscaling:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:autoScalingGroup:*:autoScalingGroupName/*" # Change last * with ref to actual ASG group name
      },
      # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.IAMPolicy.html
    ]
  })

  tags = {
    Name     = "${var.name}-host-policy"
    Template = "iam.tf"
  }
}
