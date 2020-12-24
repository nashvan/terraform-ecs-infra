data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

data "aws_ami" "ecs_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
}

data "template_file" "user-data" {
  template = file("${path.module}/ec2/user-data.sh")

  vars = {
    cluster_name = aws_ecs_cluster.ecs-cluster.name
    proxy_host   = var.proxy_host
    aws_region   = data.aws_region.current.name
    stack_name   = "${var.service_name}-${var.app_name}-${var.environment}-ecs-asg"
    resource     = "ASG"
  }
}

data "aws_subnet_ids" "subnet-ids" {
  vpc_id = data.aws_vpc.vpc.id
}

data "aws_security_group" "vpc-default-sg" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "default"
}
