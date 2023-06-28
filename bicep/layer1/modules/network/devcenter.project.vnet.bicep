param vnetName string
param location string
param vnetAddressSpace string
param subnetAddressSpace string
param devcenterName string

@description('The name of a new resource group that will be created to store some Networking resources (like NICs) in')
param networkingResourceGroupName string = '${resourceGroup().name}-networking-${location}'

var snetName = 'snet-devbox'

resource dc 'Microsoft.DevCenter/devcenters@2022-11-11-preview' existing = {
  name: devcenterName
}


resource nsg 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: 'nsg-devbox'
  location: location
  properties: {
    securityRules: [
      
    ]
  }
}


resource vnet 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: vnetName
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressSpace
      ]
    }
    subnets: [
      {
        name: 'snet-devbox'
        properties: {
          addressPrefix: subnetAddressSpace
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }
    ]
  }
}

resource networkconnection 'Microsoft.DevCenter/networkConnections@2022-11-11-preview' = {
  name: 'con-${vnetName}-${location}'
  location: location
  properties: {
    domainJoinType: 'AzureADJoin'
    subnetId: '${vnet.id}/subnets/${snetName}'
    networkingResourceGroupName: networkingResourceGroupName
  }
}

resource attachedNetwork 'Microsoft.DevCenter/devcenters/attachednetworks@2022-11-11-preview' = {
  name: 'dcon-${vnetName}-${location}'
  parent: dc
  properties: {
    networkConnectionId: networkconnection.id
  }
}

output networkConnectionName string = networkconnection.name
output networkConnectionId string = networkconnection.id
output attachedNetworkName string = attachedNetwork.name


