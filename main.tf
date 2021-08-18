data "azuread_client_config" "current" {}

resource "random_uuid" "scope_uuid" {
  for_each = {for scope in var.application_api_scope:  scope.name => scope}
}

resource "azuread_application" "main" {
  display_name     = "backend-${var.application_short_name}-${var.application_environment}"
  owners           = [data.azuread_client_config.current.object_id]
  identifier_uris  = ["api://${lower(var.application_short_name)}-${lower(var.application_environment)}"]
  sign_in_audience = "AzureADMyOrg"

  api {

    dynamic "oauth2_permission_scope" {
      for_each = {for scope in var.application_api_scope:  scope.name => scope}
      content {
            admin_consent_description  = oauth2_permission_scope.value.description
            admin_consent_display_name = oauth2_permission_scope.value.name
            enabled                    = true
            id                         = random_uuid.scope_uuid[oauth2_permission_scope.key].result
            type                       = "User"
            user_consent_description   = oauth2_permission_scope.value.description
            user_consent_display_name  = oauth2_permission_scope.value.name
            value                      = lower(oauth2_permission_scope.value.name)
      }
    }
  }
}

resource azuread_service_principal main {
  application_id               = azuread_application.main.application_id
  app_role_assignment_required = true
}