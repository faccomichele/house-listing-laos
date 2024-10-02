resource "aws_key_pair" "host" {
  key_name   = "${var.name}-host"
  public_key = file("~/.ssh/id_rsa_${var.name}.pub")
}

resource "aws_iam_instance_profile" "host" {
  name_prefix = "${var.name}-host-profile-"
  role        = aws_iam_role.host.name
}

resource "aws_instance" "host" {
  launch_template {
    id      = aws_launch_template.host.id
    version = aws_launch_template.host.latest_version
  }
  
  subnet_id = aws_subnet.public[0].id
  tags      = {
    Name     = "${var.name}-host"
    Template = "ec2.tf"
  }
}

resource "aws_eip" "host" {
  instance = aws_instance.host.id
  domain   = "vpc"
  tags     = {
    Name     = "${var.name}-host"
    Template = "ec2.tf"
  }
}

resource "aws_launch_template" "host" {
  name_prefix   = "${var.name}-host-"
  image_id      = data.aws_ssm_parameter.latest-ami.value
  instance_type = "t2.micro"
  key_name      = aws_key_pair.host.key_name
  
  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids               = [ aws_security_group.host.id ]
  
  block_device_mappings {
    device_name  = "/dev/xvda"
    virtual_name = "ephimeral-0-for-${var.name}-host"

    ebs {
      volume_size           = 30
      delete_on_termination = true
      volume_type           = "gp3"
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.host.name
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "volume"
    tags          = {
      Name     = "${var.name}-host-volume"
      Template = "ec2.tf"
    }
  }

  tag_specifications {
    resource_type = "network-interface"
    tags          = {
      Name     = "${var.name}-host-nic"
      Template = "ec2.tf"
    }
  }

  tags = {
    Name     = "${var.name}-host-template"
    Template = "ec2.tf"
  }

  user_data = filebase64("user-data.sh")
}
