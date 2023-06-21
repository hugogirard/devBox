targetScope = 'subscription'

@description('Azure location of the resource')
param location string

@description('Azure resource group name')
param managementRgName string

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

output acrLoginServer string = acr.outputs.acrLoginServer
