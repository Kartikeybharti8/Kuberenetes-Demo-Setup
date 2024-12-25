resource "azurerm_resource_group" "rg" {
  name     = "k8s-demo-static-webapp"
  location = "East US"
}

resource "azurerm_container_registry" "acr" {
  name                = "demoContainerRegistry"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
}

resource  "azurerm_kubernetes_cluster" "aks" {
  name                = "k8s-demo-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }
  
  dns_prefix = "k8sdemostaticwebapp"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "example" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
}