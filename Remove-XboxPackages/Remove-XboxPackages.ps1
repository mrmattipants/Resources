$AppxPackage = "Microsoft.Xbox*"

$ProvisionedAppxBundles = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object {$_.DisplayName -like "*$($AppxPackage)*" -And $_.DisplayName -notlike "*Microsoft.XboxGameCallableUI*"}

$AllUsersAppxPackages = Get-AppxPackage -AllUsers -ErrorAction SilentlyContinue | Where-Object {$_.Name -like "*$($AppxPackage)*" -And $_.Name -notlike "*Microsoft.XboxGameCallableUI*"}

$UserAppxPackages = Get-AppxPackage -ErrorAction SilentlyContinue | Where-Object {$_.Name -like "*$($AppxPackage)*" -And $_.Name -notlike "*Microsoft.XboxGameCallableUI*"}

# Deprovision Xbox Appx Bundle Package From Computer
If ($ProvisionedAppxBundles.count -ge 1) {

    $ProvisionedAppxBundles | Foreach-Object {
    
        $_ | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
        
        Write-Host "The $($_.DisplayName) Appx Bundle Package has been Successfully Deprovisioned" -ForegroundColor Green

    }

} Else {
    
    Write-Host "The Microsoft Xbox Appx Bundle Package was Not Provisioned on this System" -ForegroundColor Yellow

}

# Uninstall Xbox Appx Package for All Users
If ($AllUsersAppxPackages.count -ge 1) {

    $AllUsersAppxPackages | Foreach-Object {

        $_ | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
        
        Write-Host "The $($_.Name) Appx Package has been Successfully Removed for All Users" -ForegroundColor Green
       
    }
          
} Else {

    Write-Host "The Microsoft Xbox Appx Package is Not Installed for All Users" -ForegroundColor Yellow

}

# Uninstall Xbox Appx Package for Current User
If ($UserAppxPackages.count -ge 1) {

    $UserAppxPackages | Foreach-Object {
    
        $_ | Remove-AppxPackage -ErrorAction SilentlyContinue
       
        Write-Host "The $($_.Name) Appx Package been Removed from the Current User Account" -ForegroundColor Green

    }

} Else {
    
    Write-Host "The Microsoft Xbox Appx Package is Not Installed under the Current User Account" -ForegroundColor Yellow

}
