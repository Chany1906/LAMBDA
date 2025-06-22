resource "aws_s3_bucket" "data_bucket" {
  bucket = "bucket-prueba-002-wilson"
}
resource "random_id" "suffix" {
  byte_length = 4
}
