locals {
  # Standardized ALZ tag format
  rg_tags = {
    Tier      = var.tier
    Service   = var.rg_service
    Built     = var.built_date
    CreatedBy = var.created_by
  }

  resource_tags = {
    Tier      = var.tier
    Service   = var.resource_service
    Built     = var.built_date
    CreatedBy = var.created_by
  }
}

output "rg_tags" {
  description = "Tags for resource group"
  value       = local.rg_tags
}

output "resource_tags" {
  description = "Tags for individual resources"
  value       = local.resource_tags
}
