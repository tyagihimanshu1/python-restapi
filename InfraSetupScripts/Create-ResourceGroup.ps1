<#
.EXAMPLE
 $ResourceGroupName = "rg-test-02"
 $Location = "North Europe"
 .\Create-ResourceGroup.ps1 -ResourceGroupName $ResourceGroupName -Location $Location
#>


[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)][string]$ResourceGroupName,
    [Parameter(Mandatory = $false)][string]$Location
)

Write-Host " -- Checking resource group: $ResourceGroupName"
$resourceGroupList = az group list --query "[?name=='$ResourceGroupName']" | ConvertFrom-Json

# If not, create the resource group along with tags
if ($resourceGroupList.count -eq 0) {
    Write-Host " -- Creating resource group"
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
    Write-Host " -- Resource Group already exists"
}