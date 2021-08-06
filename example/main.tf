locals {
  application_short_name  = "HW"
  application_environment = "dev"
  application_api_scope   = [
    {
      name = "product:read"
      description = "read all product"
    },
    {
      name = "product:write"
      description = "write all product"
    }
  ]
}

module "azuread_app_backend" {
  source = "../"
  application_short_name    = local.application_short_name
  application_environment   = local.application_environment
  application_api_scope     = local.application_api_scope
}