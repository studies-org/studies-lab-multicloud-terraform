variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
    default = "10.0.0.0/16"
}

variable "subnet1a_cidr_block" {
    description = "The CIDR block for the subnet in us-east-1a"
    type        = string
    default = "10.0.5.0/24"
}

variable "subnet1c_cidr_block" {
    description = "The CIDR block for the subnet in us-east-1c"
    type        = string
    default = "10.0.6.0/24"  
}