resource "aws_security_group" "sglb" {
    vpc_id = var.vpc_id_input
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        description = "TCP/80 from All"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "sgec2" {
    vpc_id = var.vpc_id_input
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        description = "TCP/80 from All"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "TCP/22 from All"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "instance01" {
    ami                    = "ami-0f409bae3775dc8e5"
    instance_type          = "t2.micro"
    subnet_id              = var.subnet1a_id_input
    vpc_security_group_ids = [aws_security_group.sgec2.id]
    user_data              = <<EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd
        echo "staticsite-lb-multi-cloud - AWS - instance01" > /var/www/html/index.html
        service httpd restart
    EOF
}

resource "aws_instance" "instance02" {
    ami                    = "ami-0f409bae3775dc8e5"
    instance_type          = "t2.micro"
    subnet_id              = var.subnet1a_id_input
    vpc_security_group_ids = [aws_security_group.sgec2.id]
    user_data              = <<EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd
        echo "staticsite-lb-multi-cloud - AWS - instance02" > /var/www/html/index.html
        service httpd restart
    EOF
}

resource "aws_instance" "instance03" {
    ami                    = "ami-0f409bae3775dc8e5"
    instance_type          = "t2.micro"
    subnet_id              = var.subnet1c_id_input
    vpc_security_group_ids = [aws_security_group.sgec2.id]
    user_data              = <<EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd
        echo "staticsite-lb-multi-cloud - AWS - instance03" > /var/www/html/index.html
        service httpd restart
    EOF
}

resource "aws_instance" "instance04" {
    ami                    = "ami-0f409bae3775dc8e5"
    instance_type          = "t2.micro"
    subnet_id              = var.subnet1c_id_input
    vpc_security_group_ids = [aws_security_group.sgec2.id]
    user_data              = <<EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd
        echo "staticsite-lb-multi-cloud - AWS - instance04" > /var/www/html/index.html
        service httpd restart
    EOF
}

resource "aws_elb" "elb" {
    name            = "staticsitelbmulticloudtfwilliam"
    security_groups = [aws_security_group.sglb.id]
    subnets         = [var.subnet1a_id_input, var.subnet1c_id_input]
    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }
    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:80/"
        interval            = 30
    }
    instances = [
        aws_instance.instance01.id, 
        aws_instance.instance02.id,
        aws_instance.instance03.id,
        aws_instance.instance04.id
    ]
}

output "elb_dns_name" {
    value = aws_elb.elb.dns_name
}