Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools

$url='tfdemo.advantasure.com'

$fullPath="C:\sites\$url"

if (Test-Path "$fullPath\index.html"){
	Write-Host "Exist $_"
}
else{
	New-Item -Path $fullPath\index.html -ItemType File -Force -Value '<!DOCTYPE html><html><head><title>Demo Site</title></head><body><h1>This is a Demo site.</h1></body></html>'
}
Import-Module WebAdministration
New-Item -Path "IIS:\AppPools" -Name $url -Type AppPool
#Set-ItemProperty -Path "IIS:AppPools\$url" -name "processModel" -value $identity
Set-ItemProperty -Path "IIS:AppPools\$url" -name "processModel"

New-Item -Path "IIS:\Sites" -Name $url -Type Site -Bindings @{protocol="https";bindingInformation="*:443:$url"}
Set-ItemProperty -Path "IIS:\Sites\$url" -name "physicalPath" -value $fullPath
Set-ItemProperty -Path "IIS:\Sites\$url" -name "applicationPool" -value $url
$theCert = Get-ChildItem -Path "Cert:\LocalMachine\My\" | Where-Object {$_.Subject -like "*WMSvc-SHA2*"}
$binding = Get-WebBinding -Name $url
$binding.AddSslCertificate($theCert.GetCertHashString(), "my")
Add-Content "C:\Windows\System32\drivers\etc\hosts" "`n127.0.0.1 $url"
Start-Website -Name $url
