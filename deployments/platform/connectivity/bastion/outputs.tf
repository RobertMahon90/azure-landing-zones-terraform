output "bastion_id" {
  description = "Resource ID of the hub Bastion host"
  value       = module.hub_bastion.bastion_id
}

output "bastion_name" {
  description = "Name of the hub Bastion host"
  value       = module.hub_bastion.bastion_name
}

output "bastion_public_ip_id" {
  description = "Public IP ID of the Bastion host"
  value       = module.hub_bastion.public_ip_id
}

output "bastion_public_ip_address" {
  description = "Public IP address of the Bastion host"
  value       = module.hub_bastion.public_ip_address
}
