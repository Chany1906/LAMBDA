variable "input_bucket_arn" { 
    type = string 
}

variable "output_bucket_arn" { 
    type = string 
}

variable "suffix" {
  type        = string
  description = "Sufijo aleatorio para recursos únicos"
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}