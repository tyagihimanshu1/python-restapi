#Get the list of Resource group and delete
$list = az group list --tag 'owner = testsolutions'
if('[]' -ne $list){
    $lst = $list|ConvertFrom-Json
    foreach($resGrp in $lst.name){
    if(-not ($resGrp -eq 'cloudsolutions01-dev-rg'))
        {
            # -y is to skip the prompt message asking for yes or no to delete the resGrp
            $response = az group delete -n $resGrp -y | ConvertFrom-Json
            if($null -eq $response)
            {
                Write-Host "Something went wrong while deleting : $resGrp"
            }
            Write-Host "ResourceGrp Name deleted: $resGrp"    
        }
    }
}
else {
    Write-Host "No Resource Groups are available to delete"
}