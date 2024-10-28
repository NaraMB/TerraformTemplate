# These are the common tags to be associated with all resources to be provisioned. Resource-specific tags can be merged.
# Keeping track of tags is very important for billing and cloud cost consumption tracking
locals {
  owner                     = ""
  managed_by                = "Terraform"
  created_by                = ""
  billing_team              = ""
  app_name                  = ""
  project_name              = ""


  tags = {
    Application                   = local.project_name
    Name                          = "${local.project_name}_${var.env}"
    Environment                   = var.env
    CreatedBy                     = local.created_by
    ProductName                   = "${local.project_name}_${var.env}"
    Owner                         = local.owner
    BillingTeam                   = local.billing_team
    ManagedBy                     = local.managed_by
  }
}