param(
    [ValidateSet('Build','Deploy')]
    [string]$Action = 'Deploy'
)

# copy from
$sourceFilePath = "bin\TrainScheduleFinder.prg"

# copy to
$destinationFilePath = "D:\GARMIN\APPS"

function WaitForDriveAvailability {
    param (
        [string]$destinationFilePath,
        [int]$maxAttempts = 30
    )

    $attempt = 0
    Write-Host "Waiting for $destinationFilePath to become available..."
    while (!(Test-Path $destinationFilePath) -and $attempt -lt $maxAttempts) {
        Write-Host "." -NoNewline
        Start-Sleep -Seconds 1
        $attempt++
    }
    Write-Host ""

    if ($attempt -eq $maxAttempts) {
        Write-Host "Drive $destinationFilePath did not become available within the time limit."
        exit
    }
}

Write-Host "Building App..."
java.exe -Xms1g -jar ..\..\AppData\Roaming\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-4.2.4-2023-04-05-5830cc591\bin\monkeybrains.jar -o $sourceFilePath -f "monkey.jungle" -y ..\developer_key -d vivoactive3_sim -w
if ($? -ne $true) {
    Write-Host "Build failed!"
    exit 1
}

if ($Action -eq 'Build') {
    Write-Host "Build completed. Skipping deployment"
    exit 0
}

WaitForDriveAvailability -destinationFilePath $destinationFilePath

Write-Host "Copying $sourceFilePath to $destinationFilePath"
Copy-Item $sourceFilePath $destinationFilePath

Write-Host "Done!"
