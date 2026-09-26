#imputs do module network no modulo compute
variable "vpc_id_input" {
  description = "The ID of the VPC"
  type        = string 
}

variable "subnet1a_id_input" {
  description = "The ID of the subnet in us-east-1a"
  type        = string 
}

variable "subnet1c_id_input" {
  description = "The ID of the subnet in us-east-1c"
  type        = string  
}

#----------------------------------------------------------

