param location string
param vnetConfig object

resource vnet 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: 'vnet-management'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [        
        vnetConfig.addressSpace      
      ]      
    }
    subnets: [    
    ]
  }
}
