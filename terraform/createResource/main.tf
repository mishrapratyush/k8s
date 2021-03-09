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
variable "subscription_id" {
    type = string
    default = "<<subscription id>>"
}

variable "resource_group_name" {
    type = string
    default = "<<rg name>>"
}

variable "location" {
    type = string
    default = "westus2"
}

variable "cog_svc_name" {
    type = string
    default = "<<account name>>"
}

variable "cog_svc_location" {
    type = string
    default = "centralus"
}

#################################
# PROVIDERS
#################################
provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
}

#################################
# RESOURCES
#################################
resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location

    tags = {
      "reason" = "dev resource group"
    }
}

resource "azurerm_cognitive_account" "cogsvc" {
    name = var.cog_svc_name
    location = var.cog_svc_location
    resource_group_name = var.resource_group_name
    kind = "CognitiveServices"
    
    sku_name = "S0"

    tags = {
      "Purpose" = "pmishra test"
    }
}

#################################
# OUTPUT
#################################
output "cogsvc_details" {
    value = [
        azurerm_cognitive_account.cogsvc.id,
        azurerm_cognitive_account.cogsvc.endpoint,
        azurerm_cognitive_account.cogsvc.primary_access_key,
        azurerm_cognitive_account.cogsvc.secondary_access_key
    ]
}
