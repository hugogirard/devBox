param location string
param suffix string
param logId string

resource dc 'Microsoft.DevCenter/devcenters@2022-11-11-preview' = {
  name: 'dc-${suffix}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

resource dcDiags 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: dc.name
  scope: dc
  properties: {
    workspaceId: logId
    logs: [
      {
        enabled: true
        categoryGroup: 'allLogs'
      }
      {
        enabled: true
        categoryGroup: 'audit'
      }
    ]
  }
}
