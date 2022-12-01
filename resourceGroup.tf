resource "azurerm_resource_group" "resg" {
    name = var.resource_group_details.name
    location = var.resource_group_details.location 
}
