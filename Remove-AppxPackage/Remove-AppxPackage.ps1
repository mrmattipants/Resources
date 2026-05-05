$AppxPackage = "Microsoft.LanguageExperiencePackit"

$ProvisionedAppxBundle = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object {$_.DisplayName -like "*$($AppxPackage)*"}

$AllUsersAppxPackage = (Get-AppxPackage -AllUsers -ErrorAction SilentlyContinue | Where-Object {$_.Name -like "*$($AppxPackage)*"})

$UserAppxPackage = (Get-AppxPackage -ErrorAction SilentlyContinue | Where-Object {$_.Name -like "*$($AppxPackage)*"})

If ($ProvisionedAppxBundle) {

    $ProvisionedAppxBundle | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
        
    Write-Host "The Microsoft Store Appx Bundle has been Successfully Deprovisioned" -ForegroundColor Green

} Else {
    
    Write-Host "The Microsoft Store Appx Bundle was Not Provisioned on this System" -ForegroundColor Yellow

}

If ($AllUsersAppxPackage) {

    $AllUsersAppxPackage | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
        
    Write-Host "The Microsoft Store Appx Package has been Successfully Removed for All Users" -ForegroundColor Green
            
} Else {

    Write-Host "The Microsoft Store Appx Package is Not Installed for All Users" -ForegroundColor Yellow

}

If ($UserAppxPackage) {

    $UserAppxPackage | Remove-AppxPackage -ErrorAction SilentlyContinue
       
    Write-Host "The Microsoft Store Appx Package been Removed from the Current User Account" -ForegroundColor Green

} Else {
    
    Write-Host "The Microsoft Store Appx Package is Not Installed under the Current User Account" -ForegroundColor Yellow

}