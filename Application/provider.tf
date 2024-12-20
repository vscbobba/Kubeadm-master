provider "aws" {
   region = "ap-south-1"
}

terraform {
  backend "s3" {
    
  }
}

data "terraform_remote_state" "platform"{
    backend = "s3"
    config = {
       region = "ap-south-1" 
       bucket = var.bucket
       key    = var.key_platform    
    }
}

data "terraform_remote_state" "infrastructure"{
    backend = "s3"
    config = {
       region = "ap-south-1" 
       bucket = var.bucket
       key    = var.key_infra   
    }
}