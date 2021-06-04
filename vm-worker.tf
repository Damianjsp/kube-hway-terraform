resource "azurerm_linux_virtual_machine" "workhardway" {
  count               = 3
  name                = "${var.workname}-${random_id.prefix[count.index].id}"
  resource_group_name = azurerm_resource_group.hardway.name
  location            = azurerm_resource_group.hardway.location
  size                = var.contsize
  admin_username      = "damian"
  network_interface_ids = [
    azurerm_network_interface.workhardway[count.index].id,
  ]

  admin_ssh_key {
    username   = "damian"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 40
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
