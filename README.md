## [HEVC 10-bit] [PRESET=SLOW] [RF=22] [TUNE=ANIMATION] [AAC 128 kbps Stereo]

```
ffmpeg -i input.mkv -c:v libx265 -vf format=yuv420p10le -preset slow -crf 22 -tune animation -c:a aac -b:a 128k -ac 2 output.mp4
```

## HEVC ANIME ENCODING SETTINGS

[Source](https://kokomins.wordpress.com/2019/10/10/anime-encoding-guide-for-x265-and-why-to-never-use-flac/)

Set `preset=slow` & `-vf format=yuv420p10le`. Then choose 1 following to override the default parameters. These are my recommended settings, feel free to tune them.

`-x265-params "parameter1=1:parameter2=1"`

**• Setting to rule them all:** 

`crf=19`, `limit-sao:bframes=8:psy-rd=1:aq-mode=3` (higher bitrate)

`crf=20-23`, `bframes=8:psy-rd=1:aq-mode=3` (more compression)
		
**• Flat, slow anime (slice of life, everything is well-lit):** 

`crf=19-22`, `bframes=8:psy-rd=1:aq-mode=3:aq-strength=0.8:deblock=1,1`
		
**• Some dark scenes, some battle scenes (shonen, historical, etc.):** 

`crf=18-20` (motion + fancy & detailed FX), `limit-sao:bframes=8:psy-rd=1.5:psy-rdoq=2:aq-mode=3`

`crf=19-22` (non-complex, motion-only alternative), `bframes=8:psy-rd=1:psy-rdoq=1:aq-mode=3:qcomp=0.8`
		
**• The movie-tier dark scene, complex grain/detail, and BDs with dynamic-grain injected debanding:** 

`crf=16-18`, `no-sao:bframes=8:psy-rd=1.5:psy-rdoq=<2-5>:aq-mode=3:ref=6` 

(rdoq 2 to 5 depending on content)
			
**• I have infinite storage, a supercomputer, and I want details:** 
	
`preset=veryslow`, `crf=14`, `no-sao:no-strong-intra-smoothing:bframes=8:psy-rd=2:psy-rdoq=<1-5>:aq-mode=3:deblock=-1,-1:ref=6` 

(rdoq 1 to 5 depending on content)

**Side note: If you want x265 to behave similarly to x264, use these: `no-sao:no-strong-intra-smoothing:deblock=-1,-1`. Your result video will be very similar to x264, including all its flaws (blocking behavior, etc.).**

## Quick Hardcode Yellow-Colored SRT Subtitles [TUNE=FILM] [RF=22] [ARIAL] [H.264 8-bit 720p AAC 128 kbps Stereo]

```
ffmpeg -i input.mp4 -c:v libx264 -crf 22 -tune film -vf "format=yuv420p,scale=1280:720,subtitles=input.srt:force_style='FontName=Arial,FontSize=33,PrimaryColour=&H0000FFFF,BackColour=&H00000000,Outline=0.5,Shadow=0.3,MarginV=20'" -c:a aac -b:a 128k -ac 2 output.mp4
```

## MAIN ENCODING SETTINGS FOR HARDCODING CUSTOMIZED [.ASS] SUBTITLES [H.264 8-bit 720p AAC 128kbps Stereo]

```
ffmpeg -i input.mp4 -c:v libx264 -vf format=yuv420p -preset slow -crf 22 -c:a aac -b:a 128k -ac 2 -tune film -vf ass=input.ass output.mp4
```

## Two-Pass Encoding Settings (Windows PowerShell)

**[ Target file size in MiB * {8388.608} = file size in kilobits / video duration in seconds ] = overall bitrate - audio bitrate = video bitrate**

`AVC 8-bit [Web Optimized] [Tune=Animation] [Output Filesize=25 MB] [Duration = 01:31] [AAC 128k Stereo] `
```
ffmpeg -i input.mp4 -c:v libx264 -vf format=yuv420p -b:v 2.1M -maxrate 2.1M -bufsize 4.2M -pass 1 -an -f null NUL && ` ffmpeg -i input.mp4 -c:v libx264 -vf format=yuv420p -b:v 2.1M -maxrate 2.1M -bufsize 4.2M -pass 2 -c:a aac -b:a 128k -ac 2 -movflags faststart output.mp4
```

`[AVC 8-bit] [Tune=Film] [H.264 (2.40:1 Panavision) 1150 kbps AAC 128k Stereo] [Hardcode Yellow Arial Subtitles:Font=30]` 

**MAIN**
```
ffmpeg -i input.mkv -c:v libx264 -b:v 1150k -vf format=yuv420p -pass 1 -an -f null NUL && ` ffmpeg -i input.mkv -c:v libx264 -b:v 1150k -pass 2 -tune film -vf "format=yuv420p,scale=1280:534,subtitles=input.srt:force_style='FontName=Arial,FontSize=30,PrimaryColour=&H0000FFFF,BackColour=&H00000000,Outline=0.5,Shadow=0.3,MarginV=20'" -c:a aac -b:a 128k -ac 2 output.mp4
```

`[AVC 8-bit] [Tune=Film] [H.264 (16:9 720p) 1150 kbps AAC 128k Stereo] [Hardcode Yellow Arial Subtitles:Font=30]`

**MAIN**
```
ffmpeg -i input.mkv -c:v libx264 -b:v 1150k -vf format=yuv420p -pass 1 -an -f null NUL && ` ffmpeg -i input.mkv -c:v libx264 -b:v 1150k -pass 2 -tune film -vf "format=yuv420p,scale=1280:720,subtitles=input.srt:force_style='FontName=Arial,FontSize=30,PrimaryColour=&H0000FFFF,BackColour=&H00000000,Outline=0.5,Shadow=0.3,MarginV=20'" -c:a aac -b:a 128k -ac 2 output.mp4
```

`[HEVC 8-bit] [Tune=Animation]`
```
ffmpeg -i input.mkv -c:v libx265 -vf format=yuv420p -b:v 1150k -x265-params pass=1 -an -f null NUL && ` ffmpeg -i input.mkv -c:v libx265 -vf format=yuv420p -b:v 1150k -tune animation -x265-params pass=2 -c:a aac -b:a 128k -ac 2 output.mp4
```

`[HEVC 10-bit] [Tune=Animation]`
```
ffmpeg -i input.mkv -c:v libx265 -vf format=yuv420p10le -b:v 1150k -x265-params pass=1 -an -f null NUL && ` ffmpeg -i input.mkv -c:v libx265 -vf format=yuv420p10le -b:v 1150k -tune animation -x265-params pass=2 -c:a aac -b:a 128k -ac 2 output.mp4
```

`[HEVC 10-bit] [Tune=Animation] [Output filesize=25 MB] [Duration = 01:31] [Web Optimized] [b:v 2120 kbps] [b:a 128kbps]`
```
ffmpeg -i input.mkv -c:v libx265 -vf format=yuv420p10le -b:v 2.1M -maxrate 2.1M -bufsize 4.2M -x265-params pass=1 -an -f null NUL && ` ffmpeg -i input.mkv -c:v libx265 -vf format=yuv420p10le -b:v 2.1M -maxrate 2.1M -bufsize 4.2M -tune animation -x265-params pass=2 -c:a aac -b:a 128k -ac 2 -movflags faststart output.mp4
```

## Extract subtitles from mkv [0:s:0 = 1st sub track, 0:s:1 = 2nd sub track, and so on]
```
ffmpeg -i input.mkv -map 0:s:1 input.srt
```

## Remux mkv to mp4
```
ffmpeg -i input.mkv -c copy output.mp4
```

## Extract mp3 audio from video file (ffprobe input.mkv)
```
ffmpeg -i input.mkv -map 0:a:0 -c:a libmp3lame -q:a 3 output.mp3
```
