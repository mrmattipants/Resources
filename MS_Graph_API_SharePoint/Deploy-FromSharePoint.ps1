$Tenant = "navnet"
$TenantId = "8f5f6b39-a2a9-43c9-870b-237155fc27e1"
$ClientSecret = "cGhN:CY1gb5a]JZYR_7anFYPaxJuUXso8Y7wvW~3"
$SiteName = "ITSoftwareDeployment"
$SiteID = "45b2ca95-53f7-4fb2-886b-a683ba29f9fe"
$LibraryName = "Documents"
$AppId = "8b42f6be-cb08-43d7-b01e-6cfe6c7ec41f"
$LibraryURL = "https://hbns1.sharepoint.com/sites/Deployment/Documents"
$Path = "C:\Temp\NavNet"

$Tenant = "hbns1"
$TenantId = "0c65e808-6d3a-4e3a-8fe5-f7abafffa7f5"
$ClientSecret = "tf08Q~YZtt-r.0Njp1DfnGx6MF.WK3kZ_MxhQb.6"
$AppID = "e107ffae-cf8a-4842-8641-6d99915ba227"
$SiteID = "cb774c6b-c38e-40aa-8c7b-aa5d4895f609"
$DriveID = "b!a0x3y47DqkCMe6pdSJX2CcU1cq-odlFGh67YEZgL_EiDlzISr9OESbieavWEqcuo"
$LibraryURL = "https://hbns1.sharepoint.com/sites/Deployment/Documents"
$Path = "C:\Temp\ManageEngine"

$MEPath = Test-Path $Path -ErrorAction SilentlyContinue
If (!$MEPath) {
    New-Item -ItemType Directory -Path $Path -Force -Confirm:$False -ErrorAction Stop | Out-Null
}

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

$Url  = "https://graph.microsoft.com/v1.0/drives/$DriveID/items/root/children"
$Response =  Invoke-RestMethod -Uri $Url -Headers $Header -Method Get -ContentType 'multipart/form-data' 
$Response = $Response.value | Where-Object {$_.Name -eq "$($FileName)"}

#Invoke-WebRequest -Uri $Response.'@microsoft.graph.downloadUrl' -OutFile "$($Path)\$($FileName)"