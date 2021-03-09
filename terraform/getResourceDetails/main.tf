#################################
# TERRAFORM
#################################
terraform {
  required_providers{
      azurerm = {
          source = "hashicorp/azurerm"
          version = "~>2.0"
      }
  }
}

#################################
# VARIABLES
#################################

variable "resource_group_name" {
    type = string
    default = "pmishra"
}

variable "location" {
    type = string
    default = "westus2"
}

variable "cog_svc_name" {
    type = string
    default = "pmishra-cog-svc-centralus"
}

#################################
# PROVIDERS
#################################
provider "azurerm" {
    features {}
}

#################################
# DATA
#################################
data "azurerm_cognitive_account" "cogsvc" {
    name = var.cog_svc_name
    resource_group_name = var.resource_group_name
}

#################################
# OUTPUT
#################################
output "cogsvc_details" {
    value = [
        data.azurerm_cognitive_account.cogsvc.id,
        data.azurerm_cognitive_account.cogsvc.endpoint,
        data.azurerm_cognitive_account.cogsvc.primary_access_key,
        data.azurerm_cognitive_account.cogsvc.secondary_access_key
    ]
}