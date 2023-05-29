$HeifExtensions = (Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq "Microsoft.HEIFImageExtension"})

If (!$HeifExtensions) {

        Add-AppxProvisionedPackage -Online -PackagePath "$($PSScriptRoot)\Microsoft.HEIFImageExtension_1.0.61171.0_neutral_~_8wekyb3d8bbwe.AppxBundle" -SkipLicense
        
        Write-Host "The HEIF Image Extensions Store App has been Installed to this System" -ForegroundColor Green

} Else {
    
    Write-Host "The HEIF Image Extensions Microsoft Store App is already Installed on this System" -ForegroundColor Yellow

}