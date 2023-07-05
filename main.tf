resource "aws_instance" "control-nodes" {
  count = 5

  ami           = "ami-0953acd4901494a03"
  instance_type = "t2.micro"

  tags = {
    Name = "n0kos-controls"
  }
}


## IPs
output "instance_0" {
    value = aws_instance.control-nodes[0].private_ip
}
output "instance_1" {
    value = aws_instance.control-nodes[1].private_ip
}
output "instance_2" {
    value = aws_instance.control-nodes[2].private_ip
}
output "instance_3" {
    value = aws_instance.control-nodes[3].private_ip
}
output "instance_4" {
    value = aws_instance.control-nodes[4].private_ip
}
