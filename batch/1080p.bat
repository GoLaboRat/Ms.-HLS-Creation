@echo off
rem 実行ディレクトリに移動
cd %your_directory% & ^

rem 1080pは別処理
set TARGET=4vid
set REPLACE_WITH=1080p

for %%F in ( * ) do call :sub "%%F"
exit /b

:sub
set FILE_NAME=%1
call set FILE_NAME=%%FILE_NAME:%TARGET%=%REPLACE_WITH%%%
ren %1 %FILE_NAME%

goto :EOF
