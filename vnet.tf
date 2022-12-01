resource "azurerm_virtual_network" "my_vnet" {
    name                    =   var.virtual_network_details.name
    resource_group_name     =   var.resource_group_details.name
    address_space           =   var.virtual_network_details.address_space
    location                =   var.resource_group_details.location 

    depends_on = [
      azurerm_resource_group.resg
    ]

}
resource "azurerm_subnet" "subnet" {
    name                    = var.subnet_details[count.index]
    count                   = length(var.subnet_details)
    resource_group_name     = var.resource_group_details.name
    virtual_network_name    = var.virtual_network_details.name     
    address_prefixes        = [cidrsubnet(var.virtual_network_details.address_space[0], 8, count.index)]


    depends_on = [
      azurerm_virtual_network.my_vnet
    ]

}