@echo off
ECHO ------------------------------------------------------------Creating 30fps VIDEO------------------------------------------------------------
rem エンコード
@echo
for %%a in (%video%) do (

ffmpeg -i %%a ^
-r 30 -vsync 1 -filter:v:0 scale=-2:480 -c:v:0 libx264 -profile:v:0 main -level:v:0 3.1 -crf:v:0 20 -maxrate:v:0 1200k -bufsize:v:0 1700k -b:a:0 160k -aac_coder twoloop -g 90 -sc_threshold 0 -f segment -segment_format_options movflags=+faststart ^
-r 30 -vsync 1 -filter:v:1 scale=-2:240 -c:v:1 libx264 -profile:v:1 main -level:v:1 3.1 -crf:v:1 22  -maxrate:v:1 400k -bufsize:v:1 900k -b:a:1 96k -aac_coder twoloop -g 90 -sc_threshold 0 -f segment -segment_format_options movflags=+faststart ^
-r 30 -vsync 1 -filter:v:2 scale=-2:360 -c:v:2 libx264 -profile:v:2 main -level:v:2 3.1 -crf:v:2 21 -maxrate:v:2 700k -bufsize:v:2 1200k -b:a:2 128k -aac_coder twoloop -g 90 -sc_threshold 0 -f segment -segment_format_options movflags=+faststart ^
-r 30 -vsync 1 -filter:v:3 scale=-2:720 -c:v:3 libx264 -profile:v:3 main -level:v:3 3.1 -crf:v:3 19 -maxrate:v:3 2200k -bufsize:v:3 2700k -b:a:3 192k -aac_coder twoloop -g 90 -sc_threshold 0 -f segment -segment_format_options movflags=+faststart ^
-r 30 -vsync 1 -filter:v:4 scale=-2:1080 -c:v:4 libx264 -profile:v:4 main -level:v:4 3.1 -crf:v:4 18  -maxrate:v:4 3800k -bufsize:v:4 4300k -b:a:4 224k -aac_coder twoloop -g 90 -sc_threshold 0 -f segment -segment_format_options movflags=+faststart ^
-map v:0 -map v:0 -map v:0 -map v:0 -map v:0 -map a:0 -map a:0 -map a:0 -map a:0 -map a:0 -f hls ^
-hls_playlist_type vod -hls_time 3 -master_pl_name master.txt -master_pl_publish_rate 3 ^
-var_stream_map "v:0,a:0 v:1,a:1 v:2,a:2 v:3,a:3 v:4,a:4" "%your_directory%%%vvid.txt"
)
ECHO -------------------------------------------------------Successful creation of .ts file-------------------------------------------------------

ECHO -----------------------------------------------------------------Please wait-----------------------------------------------------------------