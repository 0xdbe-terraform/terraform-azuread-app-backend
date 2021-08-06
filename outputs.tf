output "object_id" {
  value = azuread_application.main.id
}

output "client_id" {
  value = azuread_application.main.application_id
}

output "scopes_id" {
  value = toset([
    for uuid in random_uuid.scope_uuid : uuid.result
  ])
}