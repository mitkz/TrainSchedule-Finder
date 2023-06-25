# copy from
$sourceFilePath = "bin\TrainScheduleFinder.prg"

# copy to
$destinationFilePath = "D:\GARMIN\APPS"


Write-Host "Building App..."
java.exe -Xms1g -jar ..\..\AppData\Roaming\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-4.2.4-2023-04-05-5830cc591\bin\monkeybrains.jar -o bin\TrainScheduleFinder.prg -f "monkey.jungle" -y ..\developer_key -d vivoactive3_sim -w
if ($? -ne $true) {
    Write-Host "Build failed!"
    exit
}

Write-Host "Copying $sourceFilePath to $destinationFilePath"
Copy-Item $sourceFilePath $destinationFilePath
Write-Host "Done!"
