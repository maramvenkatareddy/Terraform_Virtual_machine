resource "azurerm_network_security_group" "webnsg" {
    name = var.nsgs
    resource_group_name = var.resource_group_details.name
    location = var.resource_group_details.location
    security_rule  {
        name = local.ssh
        description = "this rule is only attached for web server"
        protocol = local.protocol
        source_port_range = local.source_port_range
        destination_port_range = local.destination_port_range
        source_address_prefix = local.source_address_prefix
        destination_address_prefix = local.destination_address_prefix
        access = local.access
        priority = local.priority
        direction = local.inbound

    }
    security_rule  {
        name = local.http
        description = "this rule is only attached for web server"
        protocol = local.protocol
        source_port_range = local.source_port_range
        destination_port_range = local.destination_port_range_http
        source_address_prefix = local.source_address_prefix
        destination_address_prefix = local.destination_address_prefix
        access = local.access
        priority = local.priority_http
        direction = local.inbound

    }
    depends_on = [
            azurerm_resource_group.resg,
            azurerm_subnet.subnet
        ]
}