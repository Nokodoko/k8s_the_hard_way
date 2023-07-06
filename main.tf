resource "aws_instance" "controller" {
  count         = 3
  ami           = "ami-0c94855ba95c71c99"  # Ubuntu 20.04 LTS
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.kubernetes.id
  tags = {
    Name = "controller-${count.index}"
    k8s_the_hard_way = "true"
    controller = "true"
  }

  root_block_device {
    volume_size = 200
  }

  network_interface {
      device_index = 1
      network_interface_id = "nic"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 200
  }

  iam_instance_profile = "controller-profile"

}

resource "aws_subnet" "kubernetes" {
  vpc_id                  = aws_vpc.kubernetes.id
  cidr_block              = "10.240.0.0/24"
  availability_zone       = var.region
}

resource "aws_security_group" "kubernetes" {
  name        = "k8s_the_hard_way"
  description = "Kubernetes security group"
  ingress {
   from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "kubernetes" {
  cidr_block = "10.240.0.0/16"
}

resource "aws_iam_instance_profile" "controller-profile" {
  name = "controller-profile"
  role = aws_iam_role.controller-role.name
}

resource "aws_iam_role" "controller-role" {
  name = "controller-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "controller-policy-attachment" {
  role       = aws_iam_role.controller-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
