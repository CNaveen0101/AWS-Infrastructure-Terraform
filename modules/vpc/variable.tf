variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "srivpc"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_cidr_block" {
  description = "vpc cidr block value"
  type = string
  default = "10.0.0.0/16"  
}

variable "public_subnet_name" {
  description = "Public Subnet Name"
  type        = string
  default     = "PublicSubnet"
}

variable "publicsunet_cidr_block" {
  description = "CIDR block of the public subnet"
  type = string
  default = "10.0.0.0/18"
}

variable "private_subnet_name" {
  description = "Private Subnet Name"
  type        = string
  default     = "PrivateSubnet"
}

variable "privatesubnet_cidr_block" {
  description = "cidr block of private subnet"
  type = string
  default = "10.0.66.0/24" 
}


