variable "adminGroupObjectIds" {
  type        = list(string)
  description = "A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster"
  default     = ["admin guids from AD"]
}

variable "metric_labels_allowlist" {
  default = null
}

variable "metric_annotations_allowlist" {
  default = null
}

variable "dns_prefix" {
  default = "sanaks1"
}
variable "grafana_sku" {
  default = "Standard"
}
variable "resource_group_name" {default="san-test-resources"}
variable "location" {default="East US 2"}
variable "grafana_public_network_access_enabled"{default=true}
variable "azurerm_monitor_workspace"{default="san-test"}
variable "azurerm_dashboard_grafana"{default="san-test"}
