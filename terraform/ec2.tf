resource "aws_instance" "consumer" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  key_name      = "chany_cloud"

  tags = {
    Name = "Prueba_Consumer"
  }
}
