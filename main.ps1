$desktopPath = [System.Environment]::GetFolderPath('Desktop')

$inputVideo = Join-Path $desktopPath "input.mp4"

$ffmpegCommand = "ffmpeg -i $inputVideo -c:v libx264 -b:v 1150k -vf format=yuv420p -pass 1 -an -f null NUL && ` ffmpeg -i $inputVideo -c:v libx264 -b:v 1150k -pass 2 -tune film -vf format=yuv420p,scale=1280:720,subtitles=input.srt:force_style='FontName=Arial,FontSize=30,PrimaryColour=&H0000FFFF,BackColour=&H00000000,Outline=0.5,Shadow=0.3,MarginV=20' -c:a aac -b:a 128k -ac 2 output.mp4"

Invoke-Expression $ffmpegCommand
