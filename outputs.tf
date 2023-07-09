## IPs
output "instance_0" {
    value = aws_instance.controller[0].private_ip
}
output "instance_1" {
    value = aws_instance.controller[1].private_ip
}
output "instance_2" {
    value = aws_instance.controller[2].private_ip
}
