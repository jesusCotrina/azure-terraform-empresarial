resource "azurerm_resource_group" "demo" {
  name     = "rg-terraform-empresarial-demo"
  location = "East US"

  tags = {
    environment = "demo"
    managed_by  = "terraform"
  }
}

resource "azurerm_storage_account" "app" {
  name                     = "stappterraformjc001"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  tags = {
    environment = "demo"
    managed_by  = "terraform"
  }
}

resource "azurerm_storage_container" "demo" {
  name                  = "demo"
  storage_account_id    = azurerm_storage_account.app.id
  container_access_type = "private"
}

resource "azurerm_service_plan" "function" {
  name                = "asp-terraform-demo"
  resource_group_name = azurerm_resource_group.demo.name
  location            = azurerm_resource_group.demo.location

  os_type  = "Linux"
  sku_name = "Y1"
}

resource "azurerm_linux_function_app" "demo" {
  name                = "func-terraform-jc-demo"
  resource_group_name = azurerm_resource_group.demo.name
  location            = azurerm_resource_group.demo.location

  service_plan_id = azurerm_service_plan.function.id

  storage_account_name       = azurerm_storage_account.app.name
  storage_account_access_key = azurerm_storage_account.app.primary_access_key

  functions_extension_version = "~4"

  site_config {
    application_stack {
      python_version = "3.11"
    }
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "python"
  }

  https_only = true

  tags = {
    environment = "demo"
    managed_by  = "terraform"
  }
}
