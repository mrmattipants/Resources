
$LenovoVantage = Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq "E046963F.LenovoSettingsforEnterprise"}

If (!$LenovoVantage) {

        $DependencyFolderPath = "$($PSScriptRoot)\Dependencies"
        
        $Dependencies = Get-ChildItem -Path $DependencyFolderPath -Filter "*.appx*" | Select-Object -ExpandProperty FullName     

        Add-AppxProvisionedPackage -Online -PackagePath "$($PSScriptRoot)\E046963F.LenovoSettingsforEnterprise_10.2305.30.0_neutral_~_k1h2ywk1493x8.Msixbundle" -DependencyPackagePath $Dependencies -SkipLicense -ErrorAction SilentlyContinue
       
        $LenovoVantage = Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq "E046963F.LenovoSettingsforEnterprise"}

        If ($LenovoVantage) {
       
            Write-Host "The Lenovo Commercial Vantage Microsoft Store Package been Successfully Provisioned on this System" -ForegroundColor Green

        } Else {

            Write-Host "The Lenovo Commercial Vantage Microsoft Store Package Provisioning Process has Failed" -ForegroundColor Red

        }

} Else {
    
    Write-Host "The Lenovo Commercial Vantage Microsoft Store Package is already Provisioned on this System" -ForegroundColor Yellow

}

$MsVcLibs = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object {$_.PackageName -eq "Microsoft.VCLibs.140.00_14.0.30704.0_x64__8wekyb3d8bbwe"}

$MsNetRuntime = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object {$_.PackageName -eq "Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe"}

$MsNetFramework =  Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object {$_.PackageName -eq "Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe"}

If ($MsVcLibs -and $MsNetRuntime -and $MsNetFramework) {
ok
    Write-Host "All Lenovo Commercial Vantage Dependency Packages have been Successfully Provisioned on this System" -ForegroundColor Green

} ElseIf (!$MsVcLibs) {

    Write-Host "The Lenovo Commercial Vantage Microsoft VCLibs v140.00 Dependency is Not Provisioned" -ForegroundColor Yellow

} ElseIf (!$MsNetRuntime) {

    Write-Host "The Lenovo Commercial Vantage Microsoft NET Native Runtime v2.2 Dependency is Not Provisioned" -ForegroundColor Yellow

} ElseIf (!$MsNetFramework) {

    Write-Host "The Lenovo Commercial Vantage Microsoft NET Native Framework v2.2 Dependency is Not Provisioned" -ForegroundColor Yellow

}

