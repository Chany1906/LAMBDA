variable "input_bucket_arn" { 
    type = string 
}

variable "output_bucket_arn" { 
    type = string 
}


variable "s3_bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}

variable "suffix" {
  description = "Sufijo para evitar duplicados"
  type        = string
}