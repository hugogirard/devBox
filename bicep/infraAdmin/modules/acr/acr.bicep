// This is the module registry for all common bicep modules.

@description('The location of resource')
param location string
@description('The suffix of resource')
param suffix string
@description('The tags of resource')
param tags object

resource acr 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: 'myacr'
  location: location
  tags: tags
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: false
  }
}

output acrName string = acr.name
output acrLoginServer string = acr.properties.loginServer
