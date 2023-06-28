param devcenterName string
param location string


module vs2022 'devboxdef.bicep' = {
  name: '${deployment().name}-DevboxDef-vs2022'
  params: {
    devcenterName: devcenterName
    location: location
    image: 'vs2022win11m365'
    storage: 'ssd_256gb'
  }
}

resource vsProjectPool 'Microsoft.DevCenter/projects/pools@2023-01-01-preview' =  [ for (loc, i) in allLocations: {
  name: '${projectTeamName}-vs2022-${loc}'
  location: location
  parent: project
  properties: {
    devBoxDefinitionName: vs2022.outputs.definitionName
    licenseType: 'Windows_Client'
    localAdministrator: 'Enabled'
    networkConnectionName: networkingLocations[i].outputs.attachedNetworkName
  }
}]
