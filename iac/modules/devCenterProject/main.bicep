@description('Provide the AzureAd UserId to assign project rbac for (get the current user with az ad signed-in-user show --query id)')
param devboxProjectUsers array 

@description('Provide the AzureAd UserId to assign project rbac for (get the current user with az ad signed-in-user show --query id)')
param devboxProjectAdmin string

@description('The name of the dev center')
param dcName string

@description('Resource group where is located the DC project')
param rgDcName string

@description('The location of the DC project')
param location string

@description('The name of the devbox project')
param projectTeamName string

module dcProject 'modules/devBox/project.bicep' = {
  name: 'dcProject'
  params: {
    dcName: dcName
    devboxProjectAdmin: devboxProjectAdmin
    devboxProjectUsers: devboxProjectUsers
    location: location
    projectTeamName: projectTeamName
    rgDcName: rgDcName
  }
}
