$LenovoVantage = (Get-AppxPackage | Where-Object {$_.Name -eq "E046963F.LenovoSettingsforEnterprise"})

If (!$LenovoVantage) {

        $DependencyFolderPath = "$($PSScriptRoot)\Dependencies"
        
        $Dependencies = Get-ChildItem -Path $DependencyFolderPath -Filter "*.appx*" | Select-Object -ExpandProperty FullName

        Add-AppxPackage -Path "$($PSScriptRoot)\E046963F.LenovoSettingsforEnterprise_10.2305.30.0_neutral_~_k1h2ywk1493x8.Msixbundle" -DependencyPath $Dependencies -Confirm:$False -ErrorAction SilentlyContinue
       
        Write-Host "The Lenovo Commercial Vantage Microsoft Store App been Installed to this System" -ForegroundColor Green

} Else {
    
    Write-Host "The Lenovo Commercial Vantage Microsoft Store App is already Installed on this System" -ForegroundColor Yellow

}

$MsVcLibs = Get-AppxPackage "Microsoft.VCLibs.140.00" -ErrorAction SilentlyContinue | Where-Object {$_.Architecture -eq "X64"}
        
$MsNetRuntime = Get-AppxPackage "Microsoft.NET.Native.Runtime.2.2" -ErrorAction SilentlyContinue | Where-Object {$_.Architecture -eq "X64"}
        
$MsNetFramework = Get-AppxPackage "Microsoft.NET.Native.Framework.2.2" -ErrorAction SilentlyContinue | Where-Object {$_.Architecture -eq "X64"}

If ($MsVcLibs -and $MsNetRuntime -and $MsNetFramework) {

    Write-Host "All Lenovo Commercial Vantage Dependencies have been Installed to this System" -ForegroundColor Green

} ElseIf (!$MsVcLibs) {

    Write-Host "The Lenovo Commercial Vantage Store Microsoft VCLibs v140.00 Dependency is Not Installed" -ForegroundColor Red

} ElseIf (!$MsNetRuntime) {

    Write-Host "The Lenovo Commercial Vantage Store Microsoft NET Native Runtime v2.2 Dependency is Not Installed" -ForegroundColor Red

} ElseIf (!$MsNetFramework) {

    Write-Host "The Lenovo Commercial Vantage Store Microsoft NET Native Framework v2.2 Dependency is Not Installed" -ForegroundColor Red

}

