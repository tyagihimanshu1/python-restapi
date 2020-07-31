[CmdletBinding()]
param (
    [Parameter(Mandatory = $True)][string]$ParameterFilePath
)
[Console]::ResetColor()

function ReadParametersFromFile($fileName) {
    $paramsObject = Get-Content -Path $fileName | ConvertFrom-Json
    if (!$paramsObject) {
        Write-Error " ## Error: Unable to read parameter file. ($fileName)"
        exit 1
    }
    $paramsObject.parameters.PSObject.Properties | ForEach-Object {
        $keyname = $_.name
        $value = $_.value

        Write-Output "##vso[task.setvariable variable=$keyname]$value"
        Write-Output "##vso[task.setvariable variable=$keyname;isOutput=true]$value"
        Write-Output " -- ${keyname}: '$value'"
    }
}

if (!(Test-Path $ParameterFilePath -PathType Leaf)) {
    Write-Error " ## Error: Parameter file could not be found. ($ParameterFilePath)"
    exit 1
}

ReadParametersFromFile($ParameterFilePath)
