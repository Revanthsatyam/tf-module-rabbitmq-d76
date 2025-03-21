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
    cidr_blocks = var.ssh_ingress_cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "main" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = var.subnet_ids[0]
  user_data              = file("${path.module}/userdata.sh")
  tags                   = merge(local.tags, { Name = "${local.name_prefix}" })
}

resource "aws_route53_record" "main" {
  zone_id = var.hosted_zone_id
  name    = "rabbitmq-${var.env}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.main.private_ip]
}