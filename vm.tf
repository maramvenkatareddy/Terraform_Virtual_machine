resource "azurerm_virtual_machine" "my_vm" {
    name = var.vms[count.index]
    count = length (var.vms)
    location = var.resource_group_details.location
    resource_group_name = var.resource_group_details.name
    network_interface_ids = [azurerm_network_interface.nics[count.index].id]
    vm_size = var.VmSize
    delete_data_disks_on_termination = true
    storage_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-focal"
        sku = "20_04-lts-gen2"
        version   = "latest"
    }
    storage_os_disk {
        name = var.disk_name[count.index]
        caching = "ReadWrite"
        create_option = "FromImage"
        os_type = "Linux"
        disk_size_gb = 30
        managed_disk_type = "Standard_LRS"
    }
    os_profile {
      computer_name = "ubuntu"
      admin_username = var.authentication_details.username
      admin_password = var.authentication_details.password
    }
    os_profile_linux_config {
      disable_password_authentication = false
    }
     depends_on = [
      azurerm_network_interface.nics
    ]
}
resource "null_resource" "version" {
    triggers = {
      version = var.null_version
    }

  provisioner "remote-exec" {
      inline = [
        "sudo apt update",
        "sudo apt install software-properties-common",
        "sudo add-apt-repository --yes --update ppa:ansible/ansible",
        "sudo apt install ansible -y"
      ]
    } 
    connection {
      type     = "ssh"
      user     = var.authentication_details.username
      password = var.authentication_details.password
      host     = azurerm_public_ip.publicip[0].ip_address
    }

    depends_on = [
      azurerm_virtual_machine.my_vm
    ]
}