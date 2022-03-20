$url = 'tfdemo.advantasure.com'
$fullPath= "C:\sites\$url"
$logpath = "C:\vmlogs"

if (Test-Path "$logpath\log.txt"){
	Add-Content "$logpath\log.txt" "Log file already exist`n" 
}
else{
	New-Item -Path $logpath\log.txt -ItemType File -Force -Value "Created log file`n"
}

try{
	Add-Content "$logpath\log.txt" "Installing IIS`n"
	Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools
	Add-Content "$logpath\log.txt" "Installed IIS successfully. `n"
}
catch{
	Add-Content "$logpath\log.txt" "Error installing IIS. `n"
	Add-Content "$logpath\log.txt" "$_ `n"
}


if (Test-Path "$fullPath\index.html"){
	Add-Content "$logpath\log.txt" "Index file already exist. `n"
}
else{
	try{
		Add-Content "$logpath\log.txt" "Creating $fullPath\index.html file`n"
		New-Item -Path $fullPath\index.html -ItemType File -Force -Value '<!DOCTYPE html><html><head><title>Demo Site</title></head><body><h1>This is a Demo site.</h1></body></html>'
		Add-Content "$logpath\log.txt" "Created $fullPath\index.html file successfully. `n"
	}
	catch{
		Add-Content "$logpath\log.txt" "Error creating $fullPath\index.html file. `n"
		Add-Content "$logpath\log.txt" "$_ `n"
	}
}
try{
	Add-Content "$logpath\log.txt" "Setting up site $url `n"
	Import-Module WebAdministration
	New-Item -Path "IIS:\AppPools" -Name $url -Type AppPool
	New-Item -Path "IIS:\Sites" -Name $url -Type Site -Bindings @{protocol="https";bindingInformation="*:443:$url"}
	Set-ItemProperty -Path "IIS:\Sites\$url" -name "physicalPath" -value $fullPath
	Set-ItemProperty -Path "IIS:\Sites\$url" -name "applicationPool" -value $url
	$theCert = Get-ChildItem -Path "Cert:\LocalMachine\My\" | Where-Object {$_.Subject -like "*WMSvc-SHA2*"}
	$binding = Get-WebBinding -Name $url
	$binding.AddSslCertificate($theCert.GetCertHashString(), "my")
	Add-Content "C:\Windows\System32\drivers\etc\hosts" "`n127.0.0.1 $url"
	Start-Website -Name $url
	Add-Content "$logpath\log.txt" "Site $url is up and running https://$url `n"
}
catch{
	Add-Content "$logpath\log.txt" "Error etting up site $url `n"
	Add-Content "$logpath\log.txt" "$_ `n"
}
