$DependCount = 0

$LenovoVantage = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object {$_.DisplayName -eq "E046963F.LenovoSettingsforEnterprise"}

If (!$LenovoVantage) {

        $DependencyFolderPath = "$($PSScriptRoot)\Dependencies"
        
        $Dependencies = Get-ChildItem -Path $DependencyFolderPath -Filter "*.appx*" | Select-Object -ExpandProperty FullName

        ForEach ($Dependency in $Dependencies) {

            $DependState = Add-AppxProvisionedPackage -Online -PackagePath $Dependency -SkipLicense -ErrorAction SilentlyContinue
 
            If ($DependState.Online -eq $True) { 
                $DependCount = ($DependCount + 1) 
            }
        }
       

        Add-AppxProvisionedPackage -Online -PackagePath "$($PSScriptRoot)\E046963F.LenovoSettingsforEnterprise_10.2305.30.0_neutral_~_k1h2ywk1493x8.Msixbundle" -SkipLicense -ErrorAction SilentlyContinue
       
        Write-Host "The Lenovo Commercial Vantage Store Package been Installed on this System" -ForegroundColor Green

} Else {
    
    Write-Host "The Lenovo Commercial Vantage Store Microsoft Store Package is already Installed on this System" -ForegroundColor Yellow

}

If ($DependCount -eq 3) {

    Write-Host "All of the Lenovo Commercial Vantage Microsoft Store App Dependencies have been Successfully Provisioned" -ForegroundColor Green

} Else {

    Write-Host "One or More of the Lenovo Commercial Vantage Microsoft Store App Dependencies are Not Provisioned" -ForegroundColor Yellow    

}

