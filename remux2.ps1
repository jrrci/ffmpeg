$desktopPath = [System.Environment]::GetFolderPath('Desktop')

$inputVideo = Join-Path $desktopPath "input.mp4"
$outputVideo = Join-Path $desktopPath "output.ts"

$ffmpegCommand = "ffmpeg -i $inputVideo -c copy $outputVideo && rm $inputVideo"

Invoke-Expression $ffmpegCommand