data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "http" "my-current-public-ip" {
  url = "https://ipinfo.io"
}

data "aws_ssm_parameter" "latest-ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-minimal-kernel-default-x86_64"
}

data "aws_ec2_managed_prefix_list" "aws-ec2-instance-connect-ipv6" {
  name = "com.amazonaws.${data.aws_region.current.name}.ipv6.ec2-instance-connect"
}
