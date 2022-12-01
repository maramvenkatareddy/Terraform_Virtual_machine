resource "azurerm_public_ip" "publicip" {
    name = var.publicips[count.index]
    count = length(var.publicips)
    location = var.resource_group_details.location
    resource_group_name = var.resource_group_details.name
    allocation_method = "Dynamic"
    depends_on = [
      azurerm_resource_group.resg
    ]
}
resource "azurerm_network_interface" "nics" {
    name = var.nics[count.index]
    count = length(var.nics)
    location = var.resource_group_details.location
    resource_group_name = var.resource_group_details.name
    ip_configuration {
      name = "internal"
      subnet_id = azurerm_subnet.subnet[count.index].id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.publicip[count.index].id
    }
    depends_on = [
      azurerm_public_ip.publicip,
      azurerm_virtual_network.my_vnet,
      azurerm_subnet.subnet
    ]
}
resource "azurerm_network_interface_security_group_association" "nic_id" {
    count = length(var.nics)
    network_interface_id = azurerm_network_interface.nics[count.index].id
    network_security_group_id = azurerm_network_security_group.webnsg.id

    depends_on = [
      azurerm_network_interface.nics,
      azurerm_network_security_group.webnsg
    ]
}
