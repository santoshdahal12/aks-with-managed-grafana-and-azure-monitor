# to-do: creates networking resources on fly right now.
# Need to add terraform for networking
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2"
  }
  
  // to enable metrics. If we dont add this, daemon sets don't get created
  monitor_metrics {
  annotations_allowed = var.metric_annotations_allowlist
  labels_allowed      = var.metric_annotations_allowlist
  }

  identity {
    type = "UserAssigned"
    identity_ids = var.identity_ids
  }

  kubelet_identity {
    client_id = var.client_id
    object_id = var.object_id
    user_assigned_identity_id = var.user_assigned_identity_id
  }

  tags = {
    Environment = "Production"
  }
}


resource "azurerm_kubernetes_cluster_node_pool" "worker" {
  name                  = "worker"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = "Standard_D2"
  node_count            = 1

  tags = {
    Environment = "Production"
  }
}