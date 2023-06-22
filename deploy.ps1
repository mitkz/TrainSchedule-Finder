# コピー元のファイルパス
$sourceFilePath = "bin\TrainScheduleFinder.prg"

# コピー先のファイルパス
$destinationFilePath = "D:\GARMIN\APPS"

Write-Host "Don't forget to build prg file before run this script."
Write-Host "Copying $sourceFilePath to $destinationFilePath"

# ファイルをコピーする
Copy-Item $sourceFilePath $destinationFilePath