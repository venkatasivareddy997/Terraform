# Block for creating the EC2 instance
resource "aws_instance" "myec2" {

  tags = {
    Name = "datacenter-ec2"
  }

  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"

  # Using the key pair created by Terraform
  key_name = aws_key_pair.public_key.key_name
}

# Block for generating the private/public key pair
resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Block for saving the private key to a file
resource "local_file" "private_key" {

  # Private key content (sensitive)
  sensitive_content = tls_private_key.key_pair.private_key_pem

  # Path where the private key will be stored
  filename = "/home/bob/nautilus-kp.pem"

  # File permission required for SSH (read-only for owner)
  file_permission = "0400"
}

# Block for uploading the public key to AWS as a key pair
resource "aws_key_pair" "public_key" {
  key_name   = "datacenter-kp"
  public_key = tls_private_key.key_pair.public_key_openssh
}
