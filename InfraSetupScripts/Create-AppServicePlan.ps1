<#
.EXAMPLE
 $ResourceGroupName = "rg-test-test-01"
 $ServicePlanName = "test-serv-plan"
 .\Create-AppServicePlan.ps1 -ResourceGroupName $ResourceGroupName -ServicePlanName $ServicePlanName
 
#>


[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)][string]$ResourceGroupName,
    [Parameter(Mandatory = $true)][string]$ServicePlanName
)

$ErrorActionPreference = "Stop"
$scriptName = $MyInvocation.MyCommand.Name

Write-Host "----------------------Script started: ($scriptName)--------------------------"

$resourceGroupList = az group list --query "[?name=='$ResourceGroupName']" | ConvertFrom-Json
if ($resourceGroupList.count -eq 0) {
    Write-Host "Resource grp : $ResourceGroupName Not found, cannot proceed further"
    exit 1
}
else{
    $spList = az appservice plan list --query "[?name=='$ServicePlanName']" | ConvertFrom-Json
    if($spList.count -eq 0){
        Write-Host "Creating API Service plan: $ServicePlanName.."
        $spResp = az appservice plan create --name $ServicePlanName --resource-group $ResourceGroupName --sku B1 --is-linux
        if($null -eq $spResp){
            Write-Host "Something went wrong while creating app service plan : $ServicePlanName, cannot proceed further"
        }
        else {
            Write-Host "API Service plan: $ServicePlanName created successfully!"
        }
    }
    else{
        Write-Host "API Service plan: $ServicePlanName, already exists, skipping the task now"
    }
}
Write-Host "----------------------Script finished: ($scriptName)--------------------------"
    