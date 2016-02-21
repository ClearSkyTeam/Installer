Add-Type -AssemblyName System.IO.Compression.FileSystem
$WC = New-Object System.Net.WebClient
'================================================================='
'|     ClearSkyのインストール(windows)             　　　        |'
'================================================================='
sleep 1
Try{
'最新のClearSky pharを検索中...'
[xml]$jenkinsinfo = $WC.DownloadString("http://jenkins.clearskyteam.org/job/ClearSky/api/xml")
$buildnumber = $jenkinsinfo.freeStyleProject.lastSuccessfulBuild.number
"最新のビルドは #$buildnumber です"
'Clearskyをダウンロード中...'
$WC.DownloadFile("http://jenkins.clearskyteam.org/job/ClearSky/$buildnumber/artifact/releases/ClearSky-master-%23$buildnumber.phar",".\ClearSky.phar")
'完了'
'PHPをダウンロード中...'
$WC.DownloadFile("https://github.com/ClearSkyTeam/PHPbinary/blob/master/PHP5-windows-x86.zip?raw=true",".\php.zip")
'解凍中...'
[System.IO.Compression.ZipFile]::ExtractToDirectory(".\php.zip", ".\")
'ごみ集め...'
rm php.zip
'完了'
'起動スクリプトのダウンロード中...'
$WC.DownloadFile("https://raw.githubusercontent.com/ClearSkyTeam/ClearSky/master/start.cmd",".\start.cmd")
'VS2012をダウンロード中...'
$WC.DownloadFile("https://download.microsoft.com/download/C/A/F/CAF5E118-4803-4D68-B6B5-A1772903D119/VSU4/vcredist_x86.exe",".\vcredist_x86.exe")
'完了'}
Catch{
'なんか変です、後でインストールを試してください'
sleep 5
exit
}
'完了しましたstart.cmdをダブルクリックでpmmpを立ち上げてください'
'もし、'
''
'/usr/bin/php/php.exe: error while loading shared libraries: MSVCR110.dll: cannot open shared object file: No such file or directory'
''
'と言われたらダウンロードされたvcredist_x86.exeをインストールしてください。'
sleep 5
rm ClearSkyWindows用インストーラ.ps1
exit
