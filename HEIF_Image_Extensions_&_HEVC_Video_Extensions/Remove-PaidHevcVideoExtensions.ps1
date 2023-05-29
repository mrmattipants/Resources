$HevcAppxBundle = (Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq "Microsoft.HEVCVideoExtensions"})

$HevcAppx = (Get-AppxPackage -AllUsers "Microsoft.HEVCVideoExtensions")

$HevcExt = (Get-AppxPackage "Microsoft.HEVCVideoExtensions")

If ($HevcAppxBundle) {

        $HevcAppxBundle | Remove-AppxProvisionedPackage -Online
        
        Write-Host "The HEVC Video Extensions Store Package has been Successfully Unprovisioned on this System" -ForegroundColor Green

} Else {
    
    Write-Host "The HEVC Video Extensions Microsoft Store Package has Not been Provisioned on this System" -ForegroundColor Yellow

}

If ($HevcAppx) {

    $HevcAppx | Remove-AppxPackage -AllUsers
        
    Write-Host "The HEVC Video Extensions Microsoft Store Package has been Successfully Removed for All Users" -ForegroundColor Green
            
} Else {

    Write-Host "The HEVC Video Extensions Microsoft Store Package is Not Installed for All Users" -ForegroundColor Yellow

}

If ($HevcExt) {

    $HevcExt | Remove-AppxPackage
        
    Write-Host "The HEVC Video Extensions Microsoft Store Package has been Successfully Removed for this User" -ForegroundColor Green
            
} Else {

    Write-Host "The HEVC Video Extensions Microsoft Store Package is Not Installed for this User" -ForegroundColor Yellow

}