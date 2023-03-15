variable "region" {
  type    = string
  default = "us-west-2"
}

variable "boundary_addr" {
  type = string
}

variable "boundary_username" {
  type = string
}

variable "boundary_password" {
  type = string
}

variable "worker_port" {
  type    = number
  default = 9202
}

variable "ipv4_addresses" {
  default = []
}

variable "ipv6_addresses" {
  default = []
}

variable "boundary_worker_tags" {
	type = map
	default = {}
}

variable "worker_generated_auth_token" {
	type = string
	default = ""
}