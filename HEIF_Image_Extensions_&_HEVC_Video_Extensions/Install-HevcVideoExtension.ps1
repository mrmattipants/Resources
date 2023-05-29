$HevcExtensions = (Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq "Microsoft.HEVCVideoExtension"})

If (!$HevcExtensions) {

        Add-AppxProvisionedPackage -Online -PackagePath "$($PSScriptRoot)\Microsoft.HEVCVideoExtension_2.0.61301.0_neutral_~_8wekyb3d8bbwe.AppxBundle" -SkipLicense
        
        Write-Host "The HEVC Video Extensions Store App has been Installed to this System" -ForegroundColor Green

} Else {
    
    Write-Host "The HEVC Video Extensions Microsoft Store App is already Installed on this System" -ForegroundColor Yellow

}