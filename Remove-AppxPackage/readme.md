Simply Add the first part of the Appx Package Name (before to the first underscore) and Save your changes.

For example, if the full package name is "Microsoft.Windows.Photos_2020.20090.1002.0_x64__8wekyb3d8bbwe", the $AppxPackage Variable should be set as follows.

$AppxPackage = "Microsoft.Windows.Photos"

Afterwards, Run the Script (as Admin) and it will Remove any installations, whether it's a single user install, installed for all users or a provisioned app.
