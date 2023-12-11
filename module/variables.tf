variable "identity_ids" {}
variable "dns_prefix"{}
variable "client_id"{}
variable "object_id"{}
variable "user_assigned_identity_id"{}
variable "metric_annotations_allowlist" {default=null}
variable "metric_labels_allowlist"{default=null}
variable "resource_group_name" {}
variable "location" {}
variable "grafana_public_network_access_enabled"{default=true}
variable "azurerm_monitor_workspace"{}
variable "azurerm_dashboard_grafana"{}
variable "cluster_name"{}
variable "adminGroupObjectIds"{}