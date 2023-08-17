

resource "azurerm_resource_group" "rg" {
  name     = "rmt-rg-aks-iac"
  location = "northeurope"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name       = "rmt-aks-iac"
  location   = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix = "rmtaksiac"

  default_node_pool {
    name       = "default"
    node_count = "2"
    vm_size    = "standard_d2_v2"
  }
  identity {
    type = "SystemAssigned"
  }
}
