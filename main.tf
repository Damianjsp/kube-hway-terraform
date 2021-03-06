resource "random_id" "prefix" {
  count       = 5
  byte_length = 4
}

resource "random_password" "secret" {
  length           = 16
  special          = true
  min_lower        = 4
  min_numeric      = 4
  min_special      = 4
  min_upper        = 4
  override_special = "_%+-*"
}

resource "azurerm_resource_group" "hardway" {
  name     = var.name
  location = var.location
  tags     = var.tag
}
resource "azurerm_virtual_network" "hardway" {
  name                = "${var.name}-us-vnet01"
  location            = azurerm_resource_group.hardway.location
  resource_group_name = azurerm_resource_group.hardway.name
  address_space       = ["10.200.0.0/24"]
  tags                = var.tag
}

resource "azurerm_subnet" "hardway" {
  name                 = "${var.name}-services"
  address_prefixes     = ["10.200.0.0/25"]
  virtual_network_name = azurerm_virtual_network.hardway.name
  resource_group_name  = azurerm_resource_group.hardway.name

}

resource "azurerm_public_ip" "hardway" {
  name                = "${var.name}-pip"
  resource_group_name = azurerm_resource_group.hardway.name
  location            = azurerm_resource_group.hardway.location
  allocation_method   = "Static"
  tags                = var.tag
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "hardway" {
  name                            = "kv-${var.name}"
  location                        = azurerm_resource_group.hardway.location
  resource_group_name             = azurerm_resource_group.hardway.name
  enabled_for_disk_encryption     = true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  soft_delete_enabled             = true
  sku_name                        = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "ce860f46-dab9-4f83-8b4c-0bddf74acf82"

    key_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]

    storage_permissions = [
      "get",
      "list",
      "set",
      "delete",
      "update",
      "regeneratekey",
      "restore",
    ]
    certificate_permissions = [
      "Get",
      "List",
      "Update",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "ManageContacts",
      "ManageIssuers",
      "GetIssuers",
      "ListIssuers",
      "SetIssuers",
      "DeleteIssuers",
    ]
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
      "list",
    ]

    secret_permissions = [
      "get",
      "list",
      "Set",
      "Delete",
    ]

    storage_permissions = [
      "get",
      "list",
    ]

    certificate_permissions = [
      "get",
      "list",
    ]

  }
}

resource "azurerm_key_vault_secret" "secret" {
  key_vault_id = azurerm_key_vault.hardway.id
  name         = "nodes-password"
  value        = random_password.secret.result
  tags         = var.tag
  depends_on = [
    azurerm_key_vault.hardway,
  ]
}
