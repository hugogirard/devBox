targetScope = 'subscription'

@description('Azure location of the resource')
param location string

@description('Azure resource group name')
param managementRgName string

//@description('Provide the AzureAd UserId to assign project rbac for (get the current user with az ad signed-in-user show --query id)')
//param devboxProjectAdmin string

param vnetConfigHub object = {
  name: 'vnet-hub'
  addressSpace: '172.0.0.0/16'
  subnets: [
    {
      name: 'AzureFirewallSubnet'
      addressPrefix: '172.0.1.0/24'
    }
  ]
}

var suffix = uniqueString(rg.id)



resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: managementRgName
  location: location
}

var tags = {
  description: 'management resource group'
}

module acr 'modules/acr/acr.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'acr'
  params: {
    location: location
    suffix: suffix
    tags: tags
  }
}

module hubVnet 'modules/network/hub.vnet.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'vnetHub'
  params: {
    location: location
    vnetConfiguration: vnetConfigHub
  }
}

// module vnetManagement 'modules/network/management.vnet.bicep' = {
//   scope: resourceGroup(rg.name)
//   name: 'vnetManagement'
//   params: {
//     location: location
//     vnetConfig: vnetConfig
//   }
// }

module logs 'modules/logs/logAnalytics.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'logs'
  params: {
    location: location 
    suffix: suffix
  }
}

module devCenter 'modules/devBox/dev.center.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'devcenter'
  params: {
    location: location
    logId: logs.outputs.logId
    suffix: suffix
  }
}

output acrLoginServer string = acr.outputs.acrLoginServer
