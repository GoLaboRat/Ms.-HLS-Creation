@echo off


rem 実行ディレクトリを取得
set "your_directory=%~dp0"

rem 動画ファイルの習得
set "movie=%1"

rem videoフォルダ作成
if exist %your_directory%video (goto TRUE) else (goto FALSE)

:TRUE
rmdir %your_directory%video /s /q  & ^
mkdir %your_directory%video\240p & ^
mkdir %your_directory%video\360p & ^
mkdir %your_directory%video\480p & ^
mkdir %your_directory%video\720p & ^
mkdir %your_directory%video\1080p
echo Initialization completion

goto END

:FALSE
mkdir %your_directory%video\240p & ^
mkdir %your_directory%video\360p & ^
mkdir %your_directory%video\480p & ^
mkdir %your_directory%video\720p & ^
mkdir %your_directory%video\1080p
echo Folder creation completed
echo Initialization completion
goto END

:END

rem Temporaryフォルダ作成
if exist %your_directory%Temporary (goto TRUE) else (goto FALSE)

:TRUE
rmdir %your_directory%Temporary /s /q
mkdir %your_directory%Temporary
echo Initialization completion

goto END

:FALSE
mkdir %your_directory%Temporary
echo Folder creation completed
echo Initialization completion
goto END

:END

rem エンコード

ECHO ------------------------------------------------------------Creating 60fps VIDEO------------------------------------------------------------
for %%a in ("%movie%") do (
ffmpeg -i %%a ^
-r 60 -vsync 1 -filter:v:0 scale=-2:480 -c:v:0 libx264 -profile:v:0 main -level:v:0 3.1 -crf:v:0 20 -maxrate:v:0 1400k -bufsize:v:0 2100k -b:a:0 160k -aac_coder twoloop -g 180 -sc_threshold 0 -f segment -segment_format_options movflags=+faststart ^
-r 60 -vsync 1 -filter:v:1 scale=-2:240 -c:v:1 libx264 -profile:v:1 main -level:v:1 3.1 -crf:v:1 22  -maxrate:v:1 600k -bufsize:v:1 1100k -b:a:1 96k -aac_coder twoloop -g 180 -sc_threshold 0 -f segment -segment_format_options movflags=+faststart ^
-r 60 -vsync 1 -filter:v:2 scale=-2:360 -c:v:2 libx264 -profile:v:2 main -level:v:2 3.1 -crf:v:2 21 -maxrate:v:2 900k -bufsize:v:2 1400k -b:a:2 128k -aac_coder twoloop -g 180 -sc_threshold 0 -f segment -segment_format_options movflags=+faststart ^
-r 60 -vsync 1 -filter:v:3 scale=-2:720 -c:v:3 libx264 -profile:v:3 main -level:v:3 3.1 -crf:v:3 19 -maxrate:v:3 3000k -bufsize:v:3 3500k -b:a:3 192k -aac_coder twoloop -g 180 -sc_threshold 0 -f segment -segment_format_options movflags=+faststart ^
-r 60 -vsync 1 -filter:v:4 scale=-2:1080 -c:v:4 libx264 -profile:v:4 main -level:v:4 3.1 -crf:v:4 18  -maxrate:v:4 6000k -bufsize:v:4 7000k -b:a:4 256k -aac_coder twoloop -g 180 -sc_threshold 0 -f segment -segment_format_options movflags=+faststart ^
-map v:0 -map v:0 -map v:0 -map v:0 -map v:0 -map a:0 -map a:0 -map a:0 -map a:0 -map a:0 -f hls ^
-hls_playlist_type vod -hls_time 3 -master_pl_name master.txt -master_pl_publish_rate 3 ^
-var_stream_map "v:0,a:0 v:1,a:1 v:2,a:2 v:3,a:3 v:4,a:4" "%your_directory%Temporary\%%vvid.txt"
)

ECHO -------------------------------------------------------Successful creation of .ts file-------------------------------------------------------


ECHO -----------------------------------------------------------------Rename-Move-----------------------------------------------------------------
cd /d "%your_directory%Temporary"

rem .m3u8書き換え
rem 240p
setlocal enabledelayedexpansion
for /f "delims=" %%a in (1vid.txt) do (
set line=%%a
echo !line:1vid=240p!>> 240p.m3u8
) & ^

rem 360p
setlocal enabledelayedexpansion
for /f "delims=" %%a in (2vid.txt) do (
set line=%%a
echo !line:2vid=360p!>> 360p.m3u8
) & ^

rem 480p
setlocal enabledelayedexpansion
for /f "delims=" %%a in (0vid.txt) do (
set line=%%a
echo !line:0vid=480p!>> 480p.m3u8
) & ^

rem 720p
setlocal enabledelayedexpansion
for /f "delims=" %%a in (3vid.txt) do (
set line=%%a
echo !line:3vid=720p!>> 720p.m3u8
) & ^

rem 1080p
setlocal enabledelayedexpansion
for /f "delims=" %%a in (4vid.txt) do (
set line=%%a
echo !line:4vid=1080p!>> 1080p.m3u8
) & ^

rem master
setlocal enabledelayedexpansion
for /f "delims=" %%a in (master.txt) do (
set line=%%a
set line=!line:1vid=240p/240p!
set line=!line:2vid=360p/360p!
set line=!line:0vid=480p/480p!
set line=!line:3vid=720p/720p!
set line=!line:4vid=1080p/1080p!
set line=!line:txt=m3u8!
echo !line!>> master.m3u8
) & ^

rem tsファイル名変更
ren 1vid*.ts 240p*.ts & ^
ren 2vid*.ts 360p*.ts & ^
ren 0vid*.ts 480p*.ts & ^
ren 3vid*.ts 720p*.ts & ^

rem 1080pのみ別のやり方
setlocal enabledelayedexpansion
for %%f in ("4vid*.ts") do (
    set "filename=%%f"
    ren "!filename!" "!filename:4vid=1080p!"
)  & ^

rem .tsファイル移動
move %your_directory%Temporary\240p*.ts %your_directory%video\240p\ & ^
move %your_directory%Temporary\360p*.ts %your_directory%video\360p\ & ^
move %your_directory%Temporary\480p*.ts %your_directory%video\480p\ & ^
move %your_directory%Temporary\720p*.ts %your_directory%video\720p\ & ^
move %your_directory%Temporary\1080p*.ts %your_directory%video\1080p\ & ^


rem .m3u8ファイル移動
move 240p*.m3u8 "%your_directory%video\240p\" & ^
move 360p*.m3u8 "%your_directory%video\360p\" & ^
move 480p*.m3u8 "%your_directory%video\480p\" & ^
move 720p*.m3u8 "%your_directory%video\720p\" & ^
move 1080p*.m3u8 "%your_directory%video\1080p\" & ^
move master*.m3u8 "%your_directory%video\" & ^

rem テキストファイル削除
del 0vid.txt & ^
del 1vid.txt & ^
del 2vid.txt & ^
del 3vid.txt & ^
del 4vid.txt & ^
del master.txt


pause
