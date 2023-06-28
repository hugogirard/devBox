@description('Provide the AzureAd UserId to assign project rbac for (get the current user with az ad signed-in-user show --query id)')
param devboxProjectUser string 

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

module project 'br:acrsharedrauc2mc7b2opi.azurecr.io/bicep/devboxproject:1' = {
  name: 'devboxproject'
  params: {
    location: location
    dcName: dcName
    devboxProjectAdmin: devboxProjectAdmin
    devboxProjectUser: devboxProjectUser
    projectTeamName: projectTeamName
    rgDcName: rgDcName
  }
}
