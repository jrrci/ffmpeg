$desktopPath = [System.Environment]::GetFolderPath('Desktop')

# Get all .ts files on the desktop
$tsFiles = Get-ChildItem $desktopPath -Filter *.ts

foreach ($tsFile in $tsFiles) {
    $inputVideo = $tsFile.FullName
    
    # Extract the file name from the input path
    $outputFileName = [System.IO.Path]::GetFileNameWithoutExtension($inputVideo)
    $outputVideo = Join-Path $desktopPath "$outputFileName.mp4"
    
    $ffmpegCommand = "ffmpeg -i `"$inputVideo`" -c copy `"$outputVideo`" && rm `"$inputVideo`""
    
    Invoke-Expression $ffmpegCommand
}
