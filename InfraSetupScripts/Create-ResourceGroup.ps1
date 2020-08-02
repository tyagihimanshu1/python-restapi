<#
.EXAMPLE
 $ResourceGroupName = "rg-test-test-01"
 $Location = "North Europe"
 .\Create-ResourceGroup.ps1 -ResourceGroupName $ResourceGroupName -Location $Location
#>


[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)][string]$ResourceGroupName,
    [Parameter(Mandatory = $false)][string]$Location
)

$ErrorActionPreference = "Stop"
$scriptName = $MyInvocation.MyCommand.Name

Write-Host "----------------------Script started: ($scriptName)--------------------------"
$resourceGroupList = az group list --query "[?name=='$ResourceGroupName']" | ConvertFrom-Json

if ($resourceGroupList.count -eq 0) {
    Write-Host "Creating resource group: $ResourceGroupName"
    $resourceGroup = az group create --location $Location --name $ResourceGroupName --tag 'owner = testsolutions'
    if ($null -eq $resourceGroup) {
        Write-Error " ## Error: Unable to create the resource group : $ResourceGroupName"
        exit 1
    }
    else{
        Write-Host " -- Resource Group: $ResourceGroupName created successfully!"
    }
}
else {
    Write-Host " -- Resource Group: $ResourceGroupName already exists"
}

Write-Host "----------------------Script finished: ($scriptName)--------------------------"