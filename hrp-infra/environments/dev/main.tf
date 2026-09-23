resource "azurerm_resource_group" "rg" {
  name     = "HRP-Dev-tf"
  location = "eastus"

  tags = {
    "env"     = "dev",
    "project" = "hrp"
  }
}

module "network" {
  source   = "../../modules/network"
  location = azurerm_resource_group.rg.location
  rg_name  = azurerm_resource_group.rg.name
}

module "nsg" {
  source    = "../../modules/nsg"
  location  = azurerm_resource_group.rg.location
  rg_name   = azurerm_resource_group.rg.name
  subnet_id = module.network.k8s_subnet_id
  my_ip     = "178.91.55.159/32" # Replace with your actual public IP address
}

module "vm" {
  source         = "../../modules/vm"
  vm_name        = "k8s-master"
  location       = azurerm_resource_group.rg.location
  rg_name        = azurerm_resource_group.rg.name
  subnet_id      = module.network.k8s_subnet_id
  admin_username = "azureuser"
  ssh_public_key = file("C:/Users/admin/.ssh/id_ed25519.pub")
}
