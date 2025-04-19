@echo off
setlocal enabledelayedexpansion
set "v=1.9"
title Webhooker v%v%
notepad URI
:loop
cls
set message=
set howlong=
echo 1: Once
echo 2: Spam
choice/c "12" /m "Enter mode"
cls
if %errorlevel%==1 (
goto once
) else if %errorlevel%==2 (
goto spam
)

:once
echo Current Mode: Once

if not exist URI (
echo URI file not found!
pause
exit/b
)

set /p URI=<URI

if "%URI%"=="" (
echo URI is empty!
pause
exit/b
)

type URI&echo.

set/p "message=Enter Message to Send: "

curl -X POST -H "Content-Type: application/json" ^
-d "{\"content\": \"%message%\"}" ^
%URI%

echo Success!

goto loop
:spam
echo Current Mode: SPAM

if not exist URI (
echo URI file not found!
pause
exit/b
)

set /p URI=<URI

if "%URI%"=="" (
echo URI is empty!
pause
exit/b
)

type URI&echo.

set/p "message=Enter Message to Send: "
set/p "howlong=Enter Count to Send: "

for /l %%i in (1, 1, %howlong%) do (
curl -X POST -H "Content-Type: application/json" ^
-d "{\"content\": \"%message%\"}" ^
%URI%
ping 127.0.0.1 -n 1 -w 850 >nul
)

echo Success!

goto loop