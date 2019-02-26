@echo off
SET ASSETS_DIR=themes\fotographic-theme\assets\js\vendor\
SET OUTPUT_DIR=public

COPY /Y node_modules\jquery/dist/jquery.min.js %ASSETS_DIR%
COPY /Y node_modules\popper.js\dist\umd\popper.min.js %ASSETS_DIR%
COPY /Y node_modules\bootstrap\dist\js\bootstrap.min.js %ASSETS_DIR%

RD /S /Q %OUTPUT_DIR%
HUGO

WINSCP /console /command "option batch on" "open ftp://fotographic@afparets.com:AFp4r3ts@149.202.147.247/" "synchronize remote -delete public" "exit"