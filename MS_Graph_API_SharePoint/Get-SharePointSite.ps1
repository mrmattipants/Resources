$Tenant = "navnet"
$TenantId = "8f5f6b39-a2a9-43c9-870b-237155fc27e1"
$ClientSecret = "cGhN:CY1gb5a]JZYR_7anFYPaxJuUXso8Y7wvW~3"
$SiteName = "ITSoftwareDeployment"
$SiteID = "e3f823cb-78dc-44f7-bcfd-6c48ad23ebd4"
$LibraryName = "Documents"
$LibraryURL = "https://navnet.sharepoint.com/sites/ITSoftwareDeployment/Documents"
$AppId = "8b42f6be-cb08-43d7-b01e-6cfe6c7ec41f"
$FilePath = "C:\Temp\ManageEngine"
$FileName = "UEMSAgent.msi"

# Connect to Graph API
$Body = @{
    Grant_Type = "client_credentials"
    Scope = "https://graph.microsoft.com/.default"
    Client_Id = $AppID
    Client_Secret = $ClientSecret
}

$GraphUrl = "https://login.microsoftonline.com/$($Tenant).onmicrosoft.com/oauth2/v2.0/token"
$AuthorizationRequest = Invoke-RestMethod -Uri $GraphUrl -Method "Post" -Body $Body
$Access_token = $AuthorizationRequest.Access_token

$Header = @{
    Authorization = $AuthorizationRequest.access_token
    "Content-Type"= "application/json"
}

# Get Site ID
$Url  = "https://graph.microsoft.com/v1.0/sites?search=Deployment"
$Response =  Invoke-RestMethod -Uri $Url -Headers $Header -Method Get -ContentType 'multipart/form-data'
$Response = $Response.value | Where-Object {$_.name -eq "$($SiteName)"}
$SiteId = $Response.id

# Get Drive ID
$GraphUrl = "https://graph.microsoft.com/v1.0/sites/$SiteID/drives"
$Result = Invoke-RestMethod -Uri $GraphUrl -Method 'GET' -Headers $Header -ContentType "application/json"
$DriveID = $Result.value| Where-Object {$_.webURL -eq $LibraryURL } | Select-Object id -ExpandProperty id

If ($DriveID -eq $null){
    Throw "SharePoint Library under $LibraryURL could not be found."
}

# Get File Info
$Url  = "https://graph.microsoft.com/v1.0/drives/$DriveID/items/root/children"
$Response =  Invoke-RestMethod -Uri $Url -Headers $Header -Method Get -ContentType 'multipart/form-data' 
$Response = $Response.value | Where-Object {$_.Name -eq "$($FileName)"}

# Download File
Invoke-WebRequest -Uri $Response.'@microsoft.graph.downloadUrl' -OutFile "$($FilePath)\$($FileName)"
