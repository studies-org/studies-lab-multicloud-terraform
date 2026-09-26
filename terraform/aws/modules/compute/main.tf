data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_security_group" "web" {
  name        = "sg-web-${var.project}"
  description = "HTTP vindo do ALB e SSH opcional"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP a partir do ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.lb_sg_id]
  }

  dynamic "ingress" {
    for_each = length(var.ssh_allowed_cidrs) > 0 ? [1] : []
    content {
      description = "SSH de origens autorizadas"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.ssh_allowed_cidrs
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  count = var.instance_count

  ami                    = data.aws_ami.al2023.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = var.key_name

  user_data = templatefile("${path.module}/user-data.sh.tftpl", {
    instance_name = format("web-%02d", count.index + 1)
  })

  metadata_options {
    http_tokens = "required"
  }

  tags = { Name = format("web-%02d-%s", count.index + 1, var.project) }
}
