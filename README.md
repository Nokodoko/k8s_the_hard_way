k8s_the_hard_way

1. Provider: We specify the AWS provider and set the region to "us-east-1" (you can change it to your desired region).
2. Subnet: We create a subnet with the CIDR block "10.240.0.0/24" in the specified availability zone.
3. Security Group: We create a security group named "kubernetes" with ingress and egress rules allowing all traffic.
4. VPC: We create a VPC with the CIDR block "10.240.0.0/16".
5. IAM Instance Profile: We create an IAM instance profile named "controller-profile" and associate it with the "controller-role".
6. IAM Role: We create an IAM role named "controller-role" with a trust policy allowing EC2 instances to assume this role.
7. IAM Role Policy Attachment: We attach the "AmazonEC2FullAccess" policy to the "controller-role".
8. EC2 Instances: We create three EC2 instances using the "aws_instance" resource. The instances are launched with the specified AMI, instance type, subnet, and security group. Each instance is assigned a private IP address in the range "10.240.0.10", "

After running `terraform plan` you should have 9 resources being added.

Also if attempting to be cloud conscious (which you should), be sure to `terraform destroy` once you have ended your session!

