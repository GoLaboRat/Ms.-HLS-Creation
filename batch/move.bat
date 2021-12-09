@echo off
rem 実行ディレクトリに移動
cd %your_directory% & ^

rem .tsファイル移動
move 240p*.ts %your_directory=%video\240p & ^
move 360p*.ts %your_directory=%video\360p & ^
move 480p*.ts %your_directory=%video\480p & ^
move 720p*.ts %your_directory=%video\720p & ^
move 1080p*.ts %your_directory=%video\1080p & ^


rem .m3u8ファイル移動
move 240p*.m3u8 %your_directory=%video\240p & ^
move 360p*.m3u8 %your_directory=%video\360p & ^
move 480p*.m3u8 %your_directory=%video\480p & ^
move 720p*.m3u8 %your_directory=%video\720p & ^
move 1080p*.m3u8 %your_directory=%video\1080p & ^
move master*.m3u8 %your_directory=%video & ^

rem テキストファイル削除
del 0vid.txt & ^
del 1vid.txt & ^
del 2vid.txt & ^
del 3vid.txt & ^
del 1080p.txt & ^
del master.txt
