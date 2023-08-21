resource "aws_vpc" "k8s_the_hard_way" {
  cidr_block = "10.240.0.0/16"
}

resource "aws_subnet" "kubernetes" {
  vpc_id                  = aws_vpc.k8s_the_hard_way.id
  cidr_block              = "10.240.0.0/24"
}

resource "aws_route_table" "kubernetes" {
  vpc_id = aws_vpc.k8s_the_hard_way.id
}

resource "aws_route" "kubernetes" {
  route_table_id         = aws_route_table.kubernetes.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.kubernetes.id
}

resource "aws_internet_gateway" "kubernetes" {
  vpc_id = aws_vpc.k8s_the_hard_way.id
}
