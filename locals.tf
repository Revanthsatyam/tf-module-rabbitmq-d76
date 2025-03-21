locals {
  name_prefix = "${var.env}-rabbitmq"
  tags = merge(var.tags, { Name = "tf-module-rabbitmq" }, { env = var.env })
}