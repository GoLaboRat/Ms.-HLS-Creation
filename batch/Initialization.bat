@echo off

if exist %your_directory%video (goto TRUE) else (goto FALSE)

:TRUE
del /Q %your_directory%video\240p\* & ^
del /Q %your_directory%video\360p\* & ^
del /Q %your_directory%video\480p\* & ^
del /Q %your_directory%video\480p\* & ^
del /Q %your_directory%video\720p\* & ^
del /Q %your_directory%video\1080p\* & ^
del /Q %your_directory%video\*.m3u8
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
