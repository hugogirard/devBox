# Introduction

This GitHub repository is using innersourcing for infrastructure as code to deploy re-usable infrastructure components.  The goal is to have administrator creating a Azure DevBox center, once this done development teams can create project and devbox for their team.

Other module will be added to this repository to deploy other infrastructure components.  For example you want to deploy a new Azure App Service Environment v3 fully protected by a Azure Firewall, you will be able to do it with this repository.

This repository show 3 concepts in Azure

- Private bicep registry with innersourcing in mind
- Azure DevBox
- Azure Deployment Environment

In this repository all will be in one monolith repository, but in a real world organization scenario you will have multiples ones.