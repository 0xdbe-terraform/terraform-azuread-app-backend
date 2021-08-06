# Terraform Azure AD Application for Backend

Terraform module to create an application (aka app registration) in Azure Active Directory.

This module sets suitable configuration for Backend, such as scope.

This module use the Microsoft Graph API and not the AzureAD Graph API.
So, if you're authenticating using a Service Principal then it must have ``Application.ReadWrite.OwnedBy`` permission in Microsoft Graph API.


## Usage

```hcl
module "azuread_app_backend" {
  source                    = "git::https://github.com/0xdbe-terraform/terraform-azuread-app-backend.git?ref=v1.0.1"
  application_short_name    = "HW"
  application_environment   = "dev"
  application_api_scope     = [
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
```
