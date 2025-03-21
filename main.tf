resource "aws_security_group" "main" {
  name   = "${local.name_prefix}-sg"
  vpc_id = var.vpc_id
  tags   = merge(local.tags, { Name = "${local.name_prefix}-sg" })

  ingress {
    description = "RABBITMQ"
    from_port   = var.sg_port_1
    to_port     = var.sg_port_1
    protocol    = "tcp"
    cidr_blocks = var.ssh_ingress
  }

  ingress {
    description = "RABBITMQ"
    from_port   = var.sg_port_2
    to_port     = var.sg_port_2
    protocol    = "tcp"
    cidr_blocks = var.ssh_ingress
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "172.31.25.133/32"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}