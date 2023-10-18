$desktopPath = [System.Environment]::GetFolderPath('Desktop')

$inputVideo = Join-Path $desktopPath "input.ts"
$outputVideo = Join-Path $desktopPath "output.mp4"

$ffmpegCommand = "ffmpeg -i $inputVideo -c copy $outputVideo && rm $inputVideo"

Invoke-Expression $ffmpegCommand
