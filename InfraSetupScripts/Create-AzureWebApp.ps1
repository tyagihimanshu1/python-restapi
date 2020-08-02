<#
.EXAMPLE
 $ResourceGroupName = "rg-test-test-01"
 $WebAppName = "test-webapp-d-01"
 $ServicePlanName = "test-serv-plan"
 $RunTime = "python|3.7"
 .\Create-AzureWebApp.ps1 -ResourceGroupName $ResourceGroupName -WebAppName $WebAppName -ServicePlanName $ServicePlanName -RunTime $RunTime
 
#>


[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)][string]$ResourceGroupName,
    [Parameter(Mandatory = $true)][string]$WebAppName,
    [Parameter(Mandatory = $true)][string]$ServicePlanName,
    [Parameter(Mandatory = $true)][string]$RunTime
) 

$ErrorActionPreference = "Stop"
$scriptName = $MyInvocation.MyCommand.Name

Write-Host "----------------------Script started: ($scriptName)--------------------------"
$grpList = az group list --query "[?name=='$ResourceGroupName']" | ConvertFrom-Json
if($grpList.count -eq 0){
    Write-Host "Resource grp : $ResourceGroupName Not found, cannot proceed further"
    exit 1
}
else {
    $spList = az appservice plan list --query "[?name=='$ServicePlanName']" | ConvertFrom-Json
    if($spList.count -eq 0){
        Write-Host "API Service plan: $ServicePlanName, Not found, cannot proceed further"
        exit 1
    }
    else{
        $appList = az webapp list --query "[?name=='$WebAppName']" | ConvertFrom-Json
        if($appList.count -eq 0){
            $appResp = az webapp create --name $WebAppName --resource-group $ResourceGroupName --plan $ServicePlanName --runtime ""$RunTime"" 
            if($null -eq $appResp){
                Write-Host "Something went wrong while creating API app : $WebAppName, cannot proceed further"
            }
            else {
                Write-Host "WebApp APP created: $WebAppName, please proceed with the deployment.."
                # Configure deployment from Repo if not doing it via pipeline. 
            }  
        }
        else{
            Write-Host "WebApp APP: $WebAppName, Already exists, skipping the task now"
        }
         
    }
}

Write-Host "----------------------Script finished: ($scriptName)--------------------------"