resource "aws_security_group" "jum_sg"{
    name = "jump server security group"
    vpc_id = data.terraform_remote_state.infrastructure.outputs.aws_vpc

    // Inbound rule allowing SSH access from any IP address
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Inbound rule allowing HTTP access from specific IP address range
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    // Outbound rule allowing all traffic to any destination
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
