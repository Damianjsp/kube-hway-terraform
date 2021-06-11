resource "azurerm_network_security_group" "hardway" {
  name                = "${var.name}-nsg"
  location            = azurerm_resource_group.hardway.location
  resource_group_name = azurerm_resource_group.hardway.name
  tags                = var.tag
  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "ssh"
    priority                   = 100
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "22"
    destination_address_prefix = azurerm_network_interface.piphardway.private_ip_address
  }
}

resource "azurerm_subnet_network_security_group_association" "hardway" {
  subnet_id                 = azurerm_subnet.hardway.id
  network_security_group_id = azurerm_network_security_group.hardway.id
}
