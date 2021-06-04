resource "azurerm_network_interface" "controlhardway" {
  count               = 2
  name                = "${var.contname}-${random_id.prefix[count.index].id}-nic"
  location            = azurerm_resource_group.hardway.location
  resource_group_name = azurerm_resource_group.hardway.name

  ip_configuration {
    name                          = azurerm_subnet.hardway.name
    subnet_id                     = azurerm_subnet.hardway.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "workhardway" {
  count               = 3
  name                = "${var.workname}-${random_id.prefix[count.index].id}-nic"
  location            = azurerm_resource_group.hardway.location
  resource_group_name = azurerm_resource_group.hardway.name

  ip_configuration {
    name                          = azurerm_subnet.hardway.name
    subnet_id                     = azurerm_subnet.hardway.id
    private_ip_address_allocation = "Dynamic"
  }
}

# resource "azurerm_network_interface" "mainhardway" {
#   name                = "${var.mastname}-nic"
#   location            = azurerm_resource_group.hardway.location
#   resource_group_name = azurerm_resource_group.hardway.name

#   ip_configuration {
#     name                          = azurerm_subnet.hardway.name
#     subnet_id                     = azurerm_subnet.hardway.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

resource "azurerm_network_interface" "piphardway" {
  name                = "${var.mastname}-nic"
  resource_group_name = azurerm_resource_group.hardway.name
  location            = azurerm_resource_group.hardway.location

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.hardway.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.hardway.id
  }
}
