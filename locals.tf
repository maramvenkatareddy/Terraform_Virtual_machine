locals {
  ssh = "allowssh"
  http = "allowhttp"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "*"
  destination_address_prefix = "*"
  inbound = "Inbound"
  priority = 310
  access = "Allow"
  destination_port_range_http = "80"
  priority_http = 320
}
