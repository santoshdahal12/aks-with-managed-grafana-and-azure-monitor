data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "san_group" {
  name = "san-test-resources"
}

resource "azurerm_user_assigned_identity" "aks-cluster" {
  name="sanaks-cluster"
  resource_group_name = data.azurerm_resource_group.san_group.name
  location = data.azurerm_resource_group.san_group.location
  
}

resource "azurerm_user_assigned_identity" "sanaks-kubelet" {
  name="sanaks-kubelet"
  resource_group_name = data.azurerm_resource_group.san_group.name
  location = data.azurerm_resource_group.san_group.location
}

// role assignments 

resource "azurerm_role_assignment" "kubelet" {
  scope=azurerm_user_assigned_identity.sanaks-kubelet.id
  role_definition_name = "Managed Identity Operator"
  principal_id = azurerm_user_assigned_identity.aks-cluster.principal_id
  
}

resource "azurerm_role_assignment" "san_resource_group" {
  scope=data.azurerm_resource_group.san_group.id
  role_definition_name = "Contributor"
  principal_id = azurerm_user_assigned_identity.aks-cluster.principal_id
  
}

module "aks" {
  source = "./module"
  client_id = azurerm_user_assigned_identity.sanaks-kubelet.client_id
  user_assigned_identity_id = azurerm_user_assigned_identity.sanaks-kubelet.id
  identity_ids = [azurerm_user_assigned_identity.aks-cluster.id]
  object_id= azurerm_user_assigned_identity.sanaks-kubelet.principal_id
  resource_group_name=var.resource_group_name
  location=var.location
  grafana_public_network_access_enabled=var.grafana_public_network_access_enabled
  azurerm_monitor_workspace=var.azurerm_monitor_workspace
  azurerm_dashboard_grafana=var.azurerm_dashboard_grafana
  cluster_name=var.cluster_name
  dns_prefix=var.dns_prefix
  adminGroupObjectIds=var.adminGroupObjectIds
}