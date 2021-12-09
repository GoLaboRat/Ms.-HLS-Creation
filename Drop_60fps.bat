@echo off

rem 実行ディレクトリを取得
set your_directory=%~dp0
rem 入力ファイルの取得
SET video=%*
ECHO -------------------------------------------------Initialization in folder-------------------------------------------------
rem 初期化
call %your_directory%batch/rename.bat %your_directory%
call %your_directory%batch/1080p.bat %your_directory%
call %your_directory%batch/move.bat %your_directory%
call %your_directory%batch/Initialization.bat %your_directory%

rem エンコード
call %your_directory%batch/enc60fps.bat %your_directory% %video%

rem ファイル名変更
call %your_directory%batch/rename.bat %your_directory%

rem 1080pのみ変更
call %your_directory%batch/1080p.bat %your_directory%

rem ファイル移動
call %your_directory%batch/move.bat %your_directory%
ECHO -------------------------------------Successful HLS_Video Thank you for using---------------------------------------------
pause