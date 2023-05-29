$HeifAppxBundle = (Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq "Microsoft.HEIFImageExtension"})

$HeifAppx = (Get-AppxPackage -AllUsers "Microsoft.HEIFImageExtension")

$HeifExt = (Get-AppxPackage "Microsoft.HEIFImageExtension")

If ($HeifAppxBundle) {

        $HeifAppxBundle | Remove-AppxProvisionedPackage -Online
        
        Write-Host "The HEIF Image Extensions Microsoft Store Package has been Successfully Unprovisioned on this System" -ForegroundColor Green

} Else {
    
    Write-Host "The HEIF Image Extensions Microsoft Store Package hass Not been Provisioned on this System" -ForegroundColor Yellow

}

If ($HeifAppx) {

    $HeifAppx | Remove-AppxPackage -AllUsers
        
    Write-Host "The HEIF Image Extensions Microsoft Store Package has been Successfully Removed for All Users" -ForegroundColor Green
            
} Else {

    Write-Host "The HEIF Image Extensions Microsoft Store Package is Not Installed for All Users" -ForegroundColor Yellow

}

If ($HeifExt) {

    $HeifExt | Remove-AppxPackage
        
    Write-Host "The HEIF Image Extensions Microsoft Store Package has been Successfully Removed for this User" -ForegroundColor Green
            
} Else {

    Write-Host "The HEIF Image Extensions Microsoft Store Package is Not Installed for this User" -ForegroundColor Yellow

}