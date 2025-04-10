
$AppId = "8b42f6be-cb08-43d7-b01e-6cfe6c7ec41f"
$ClientSecret = "cGhN:CY1gb5a]JZYR_7anFYPaxJuUXso8Y7wvW~3"
$TenantName = "navnet"
$SiteName = "IT"
$LibraryName = "Documents"
$Subfolders = "/Software/qemu-img-win-x64-2_3_0"
$FilePath = "C:\Temp\NavNet"
$FileName = @("qemu-img.exe","libgcc_s_sjlj-1.dll","libglib-2.0-0.dll","libgthread-2.0-0.dll","libiconv-2.dll","libintl-8.dll","libssp-0.dll")
$Output = @()

# Connect to Graph API
$Body = @{
    Grant_Type = "client_credentials"
    Scope = "https://graph.microsoft.com/.default"
    Client_Id = $AppID
    Client_Secret = $ClientSecret
}

$GraphUrl = "https://login.microsoftonline.com/$($TenantName).onmicrosoft.com/oauth2/v2.0/token"
$AuthorizationRequest = Invoke-RestMethod -Uri $GraphUrl -Method "Post" -Body $Body
$Access_token = $AuthorizationRequest.Access_token

$Header = @{
    Authorization = $AuthorizationRequest.access_token
    "Content-Type"= "application/json"
}

# Get Site ID
$Url  = "https://graph.microsoft.com/v1.0/sites?search=$($SiteName)"
$Response =  Invoke-RestMethod -Uri $Url -Headers $Header -Method Get -ContentType 'multipart/form-data'
$Response = $Response.value | Where-Object {$_.name -eq "$($SiteName)"}
$SiteId = $Response.id

# Get Drive ID
$GraphUrl = "https://graph.microsoft.com/v1.0/sites/$SiteID/drives"
$Result = Invoke-RestMethod -Uri $GraphUrl -Method 'GET' -Headers $Header -ContentType "application/json"
$DriveID = $Result.value| Where-Object {$_.name -eq "$($LibraryName)" } | Select-Object id -ExpandProperty id

If ($DriveID -eq $null){
    Throw "SharePoint Library under $LibraryURL could not be found."
}

Foreach ($File in $FileName) {

    # Get File Info
    $Url  = "https://graph.microsoft.com/v1.0/drives/$DriveID/root:$($Subfolders):/children"
    $Response =  Invoke-RestMethod -Uri $Url -Headers $Header -Method Get -ContentType 'multipart/form-data' 
    $Response = $Response.value | Where-Object {$_.Name -eq "$($File)"}
    
    # Download File
    Try {
        Invoke-RestMethod -Uri $Response.'@microsoft.graph.downloadUrl' -OutFile "$($FilePath)\$($File)" -Method Get
        $Output += "$($Response.Name) Download Successful`n"
    }
    Catch {
        $Output += "$($Response.Name) Download Failed`n"
    }

}

Write-Host "$($Output)"