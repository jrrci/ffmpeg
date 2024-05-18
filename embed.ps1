# Define paths to input video and subtitle files
$inputVideo = "$env:USERPROFILE\Desktop\input.mp4"
$inputSubtitle = "$env:USERPROFILE\Desktop\input.srt"

# Define path for the output video file
$outputVideo = "$env:USERPROFILE\Desktop\output.mp4"

# Execute ffmpeg command
$ffmpegCommand = "ffmpeg -i `"$inputVideo`" -i `"$inputSubtitle`" -c:v copy -c:a copy -c:s mov_text -metadata:s:s:0 language=eng `"$outputVideo`""
Invoke-Expression -Command $ffmpegCommand

# Delete input video and subtitle files
Remove-Item -Path $inputVideo
Remove-Item -Path $inputSubtitle