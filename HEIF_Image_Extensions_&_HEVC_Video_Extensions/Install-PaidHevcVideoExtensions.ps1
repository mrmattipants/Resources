$PaidHevcExtensions = (Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq "Microsoft.HEVCVideoExtension"})

If (!$PaidHevcExtensions) {

        Add-AppxProvisionedPackage -Online -PackagePath "$($PSScriptRoot)\Microsoft.HEVCVideoExtensions_2.0.60962.0_neutral_~_8wekyb3d8bbwe_(Paid).AppxBundle" -SkipLicense
        
        Write-Host "The Commercial HEVC Video Extensions Store App has been Installed to this System" -ForegroundColor Green

} Else {
    
    Write-Host "The Commercial HEVC Video Extensions Microsoft Store App is already Installed on this System" -ForegroundColor Yellow

}