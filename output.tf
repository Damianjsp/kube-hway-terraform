output "key-vault-id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.hardway.id
}

output "vm-names" {
  description = "VM names"
  value       = azurerm_linux_virtual_machine.mainhardway.name
}

