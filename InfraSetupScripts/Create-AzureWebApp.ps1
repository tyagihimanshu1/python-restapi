<#
.EXAMPLE
 $ResourceGroupName = "test-rg-d"
 $WebAppName = "test-webapp-d-01"
 $ServicePlanName = "test-serv-plan"
 $RunTime = "python|3.6"
 .\Create-AzureWebApp.ps1 -ResourceGroupName $ResourceGroupName -WebAppName $WebAppName -ServicePlanName $ServicePlanName -RunTime $RunTime
 
#>


[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)][string]$ResourceGroupName,
    [Parameter(Mandatory = $true)][string]$WebAppName,
    [Parameter(Mandatory = $true)][string]$ServicePlanName,
    [Parameter(Mandatory = $true)][string]$RunTime
) 
$grpList = az group list --query "[?name=='$ResourceGroupName']"|ConvertFrom-Json
if($grpList.Length -eq 0){
    Write-Host "Resource grp : $ResourceGroupName Not found, cannot proceed further"
}
else {
    # Create an App Service plan (Linux)
    $spResp = az appservice plan create --name $ServicePlanName --resource-group $ResourceGroupName --sku B1 --is-linux
    if($null -eq $spResp){
        Write-Host "Something went wrong while creating app service plan : $ServicePlanName, cannot proceed further"
    }
    else {
        Write-Host "API Service plan created: $ServicePlanName, creating webapp: $WebAppName now.."
        # Create a web app
        $appResp = az webapp create --name $WebAppName --resource-group $ResourceGroupName --plan $ServicePlanName --runtime ""$RunTime"" 
        if($null -eq $appResp){
            Write-Host "Something went wrong while creating API app : $WebAppName, cannot proceed further"
        }
        else {
            Write-Host "WebApp APP created: $WebAppName, please proceed with the deployment.."
            # Configure deployment from Repo if not doing it via pipeline. 
        }
        
    }
}