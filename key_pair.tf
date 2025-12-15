resource "tls_private_key" "key_pair" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "private_key" {

    sensitive_content = tls_private_key.key_pair.private_key_pem
    filename = "/home/bob/nautilus-kp.pem"
    file_permission = 0400

}

resource "aws_key_pair" "public_key" {
    key_name = "nautilus-kp"
    public_key = tls_private_key.key_pair.public_key_openssh

}