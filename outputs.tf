output "resource_group_name" {
  value = azurerm_resource_group.demo.name
}

output "storage_account_name" {
  value = azurerm_storage_account.app.name
}

output "blob_container_name" {
  value = azurerm_storage_container.demo.name
}

output "function_app_name" {
  value = azurerm_linux_function_app.demo.name
}

output "function_app_url" {
  value = "https://${azurerm_linux_function_app.demo.default_hostname}"
}