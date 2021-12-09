@echo off
rem 実行ディレクトリに移動
cd %your_directory% & ^

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
ren 3vid*.ts 720p*.ts