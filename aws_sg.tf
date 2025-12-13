resource "aws_security_group" "sg" {
    name = "nautilus-sg"
    ingress {
        from_port= 80
        to_port=80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    description = "Security group for Nautilus App Servers"

}