param projectTeamName string
param location string 
param dcName string
param rgDcName string
param devboxProjectUsers array 
param devboxProjectAdmin string 

resource dc 'Microsoft.DevCenter/devCenters@2022-11-11-preview' existing = {
  name: dcName
  scope: resourceGroup(rgDcName)
}

resource project 'Microsoft.DevCenter/projects@2022-11-11-preview' = {
  name: projectTeamName
  location: location
  properties: {
    devCenterId: dc.id
  }
}

var devCenterDevBoxAdminRoleId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '331c37c6-af14-46d9-b9f4-e1909e1b95a0')
resource projectAdminRbac 'Microsoft.Authorization/roleAssignments@2022-04-01' = if(!empty(devboxProjectAdmin)) {
  scope: project
  name: guid(project.id, devboxProjectAdmin, devCenterDevBoxAdminRoleId)
  properties: {
    roleDefinitionId: devCenterDevBoxAdminRoleId
    principalType: 'User'
    principalId: devboxProjectAdmin
  }
}

// Loop all users that need to be assigned to the devbox project
var devCenterDevBoxUserRoleId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '45d50f46-0b78-4001-a660-4198cbe8cd05')
resource projectUserRbac 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for devboxProjectUser in devboxProjectUsers:{
  scope: project
  name: guid(project.id, devboxProjectUser, devCenterDevBoxUserRoleId)
  properties: {
    roleDefinitionId: devCenterDevBoxUserRoleId
    principalType: 'User'
    principalId: devboxProjectUser
  }
}]
