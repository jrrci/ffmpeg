$desktopPath = [System.Environment]::GetFolderPath('Desktop')

$inputVideo = Join-Path $desktopPath "input.ts"

$ffmpegCommand = "ffmpeg -i $inputVideo -c copy output.mp4 && rm $inputVideo"

Invoke-Expression $ffmpegCommand