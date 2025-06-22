resource "aws_instance" "consumer" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux
  instance_type = "t2.micro"
  key_name      = "my-key"  # crea uno desde AWS si no tienes

  tags = {
    Name = "EC2Consumer"
  }
}
