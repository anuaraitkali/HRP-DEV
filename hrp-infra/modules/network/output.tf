output "k8s_subnet_id" {
  value = azurerm_subnet.k8s.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "private_subnet_id" {
  value = azurerm_subnet.private.id
}
