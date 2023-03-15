# locals {
#   vpc_id                  = data.tfe_outputs.aws-core.values.vpc_id
#   subnet_id               = data.tfe_outputs.aws-core.values.public_subnets[0]
#   security_group_outbound = data.tfe_outputs.aws-core.values.security_group_outbound
#   security_group_ssh      = data.tfe_outputs.aws-core.values.security_group_ssh
# }

# data "tfe_outputs" "aws-core" {
#   organization = "grantorchard"
#   workspace    = "aws-core"
# }

# data "hcp_packer_image" "this" {
#   bucket_name    = "boundary-self-managed-worker"
#   cloud_provider = "aws"
#   channel        = "0-11"
#   region         = var.region
# }

# resource "aws_eip" "this" {}

# resource "aws_eip_association" "this" {
#   instance_id = module.ec2-instance.id
#   public_ip   = aws_eip.this.public_ip
# }

# module "ec2-instance" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "4.1.4"

#   ami           = data.hcp_packer_image.this.cloud_image_id
#   instance_type = "t3.micro"
#   key_name      = "go"

#   subnet_id = local.subnet_id

#   vpc_security_group_ids = [
#     aws_security_group.worker.id,
#     local.security_group_outbound,
#     local.security_group_ssh
#   ]

# 	user_data = templatefile("${path.module}/files/userdata.yaml.tmpl", {
# 		hcp_boundary_cluster_id = split(".", trimprefix(var.boundary_addr, "https://"))[0]
# 		public_addr = aws_eip.this.public_ip
# 		boundary_worker_tags = var.boundary_worker_tags
# 		controller_generated_activation_token = var.worker_generated_auth_token == "" ? boundary_self_managed_worker.controller_led[0].controller_generated_activation_token : var.worker_generated_auth_token
# 	})
# }

# resource "aws_security_group" "worker" {
#   vpc_id = local.vpc_id
#   name   = "boundary_self_managed_workers"

#   ingress {
#     description      = "Boundary Client Connections"
#     from_port        = var.worker_port
#     to_port          = var.worker_port
#     protocol         = "tcp"
#     cidr_blocks      = var.ipv4_addresses
#     ipv6_cidr_blocks = var.ipv6_addresses
#   }
# }

resource "boundary_worker" "controller_led" {
	scope_id = "global"
	name = "worker 1"
	description = "self managed worker with controlled led auth"
	worker_generated_auth_token = var.worker_generated_auth_token
}

# resource "boundary_self_managed_worker" "worker_led" {
# 	scope_id = "global"
# 	name = "worker 2"
# 	description = "self managed worker with controlled led auth"
# 	worker_generated_auth_token = var.worker_generated_auth_token
# }