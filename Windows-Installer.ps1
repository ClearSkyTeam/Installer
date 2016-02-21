Add-Type -AssemblyName System.IO.Compression.FileSystem
$WC = New-Object System.Net.WebClient
'================================================================='
'|     Welcome to ClearSky install script for Windows            |'
'| We strong suggest you use Linux instead of Microsoft Windows  |'
'================================================================='
sleep 1
Try{
'Fetching latest ClearSky phar...'
[xml]$jenkinsinfo = $WC.DownloadString("http://jenkins.clearskyteam.org/job/ClearSky/api/xml")
$buildnumber = $jenkinsinfo.freeStyleProject.lastSuccessfulBuild.number
"Latest successful build number is #$buildnumber"
'Downloading Clearsky...'
$WC.DownloadFile("http://jenkins.clearskyteam.org/job/ClearSky/$buildnumber/artifact/releases/ClearSky-master-%23$buildnumber.phar",".\ClearSky.phar")
'Done!'
'Downloading PHP runtime...'
$WC.DownloadFile("https://github.com/ClearSkyTeam/PHPbinary/blob/master/PHP5-windows-x86.zip?raw=true",".\php.zip")
'Extracting...'
[System.IO.Compression.ZipFile]::ExtractToDirectory(".\php.zip", ".\")
'Cleaning...'
rm php.zip
'Done!'
'Downloading Startup Script'
$WC.DownloadFile("https://raw.githubusercontent.com/ClearSkyTeam/ClearSky/master/start.cmd",".\start.cmd")
'Done!'
'Downloading　VS2012...'
$WC.DownloadFile("https://download.microsoft.com/download/C/A/F/CAF5E118-4803-4D68-B6B5-A1772903D119/VSU4/vcredist_x86.exe",".\vcredist_x86.exe")
'Done!'
}
Catch{
'Something went wronly , please restart this script later'
sleep 5
exit
}
'All have done! Run start.cmd for your new server!'
'If it said to be'
''
'/usr/bin/php/php.exe: error while loading shared libraries: MSVCR110.dll: cannot open shared object file: No such file or directory'
''
'please install vcredist_x86.exe.'

sleep 5
rm Windows-Installer.ps1
exit
