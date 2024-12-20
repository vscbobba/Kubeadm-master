output "aws_vpc" {
  value = aws_vpc.VPC1.id
}

output "aws_pub_1" {
  value = aws_subnet.public_1.id
}

output "aws_pub_2" {
  value = aws_subnet.public_2.id
}

output "aws_priv_1" {
  value = aws_subnet.private_1.id
}

output "aws_priv_2" {
  value = aws_subnet.private_2.id
}