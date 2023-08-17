

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
    node_count = "1"
    vm_size    = "standard_d2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "mem" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
  name                  = "mem"
  node_count            = "1"
  vm_size               = "standard_d2_v2"
}