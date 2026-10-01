variable "vpc_cidr_block" {
  description = "vpc cidr block value"
  type = string
  default = "10.0.0.0/16"  
}

variable "publicsunet_cidr_block" {
  description = "CIDR block of the public subnet"
  type = string
  default = "10.0.0.0/18"
}

variable "privatesubnet_cidr_block" {
  description = "cidr block of private subnet"
  type = string
  default = "10.0.66.0/24" 
}
