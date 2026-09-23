resource "azurerm_network_security_group" "this" {
  name                = "nsg-k8s-dev"
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_rule" "ssh" {
  name      = "AllowSSH"
  priority  = 100
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range      = "*"
  destination_port_range = "22"

  source_address_prefix      = var.my_ip
  destination_address_prefix = "*"

  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.this.name

}

resource "azurerm_network_security_rule" "http" {
  name      = "AllowHTTP"
  priority  = 200
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range      = "*"
  destination_port_range = "80"

  source_address_prefix      = "*"
  destination_address_prefix = "*"

  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.this.name

}


resource "azurerm_network_security_rule" "https" {
  name      = "AllowHTTPS"
  priority  = 300
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range      = "*"
  destination_port_range = "443"

  source_address_prefix      = "*"
  destination_address_prefix = "*"

  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.this.name
}

resource "azurerm_subnet_network_security_group_association" "k8s" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.this.id
}
