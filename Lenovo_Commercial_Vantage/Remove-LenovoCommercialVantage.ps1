$LenovoBundle = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object {$_.DisplayName -eq "E046963F.LenovoSettingsforEnterprise"}

$LenovoMachineApp = (Get-AppxPackage -AllUsers -ErrorAction SilentlyContinue | Where-Object {$_.Name -eq "E046963F.LenovoSettingsforEnterprise"})

$LenovoUserApp = (Get-AppxPackage -ErrorAction SilentlyContinue | Where-Object {$_.Name -eq "E046963F.LenovoSettingsforEnterprise"})

If ($LenovoBundle) {

        $LenovoBundle | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
        
        Write-Host "The Lenovo Commercial Vantage Microsoft Store Package has been Successfully Unprovisioned on this System" -ForegroundColor Green

} Else {
    
    Write-Host "The Lenovo Commercial Vantage Microsoft Store Package has Not been Provisioned on this System" -ForegroundColor Yellow

}

If ($LenovoMachineApp) {

    $LenovoMachineApp | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
        
    Write-Host "The Lenovo Commercial Vantage Microsoft Store Package has been Successfully Removed for All Users" -ForegroundColor Green
            
} Else {

    Write-Host "The Lenovo Commercial Vantage Microsoft Store Package is Not Installed for All Users" -ForegroundColor Yellow

}

If ($LenovoUserApp) {

        $LenovoUserApp | Remove-AppxPackage -ErrorAction SilentlyContinue
       
        Write-Host "The Lenovo Commercial Vantage Microsoft Store App been Removed from this User Account" -ForegroundColor Green

} Else {
    
    Write-Host "The Lenovo Commercial Vantage Microsoft Store App is Not Installed under this User Account" -ForegroundColor Yellow

}
