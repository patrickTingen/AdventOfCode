@echo off
cls
set year=2021
set /a daynr=0
set ready=no

:loop
set /a daynr=daynr+1
SET day=00%daynr%
SET day=%day:~-2%
if not exist "Day-%day%" call :createFolder %day%
if "%ready%"=="yes" goto :EOF
if %day% gtr 25 goto :EOF
goto :loop
	
:createFolder
set ready=yes
set Folder=Day-%1
md %Folder%
cd %Folder%
echo /* AoC %year% day %1 > day-%1.p
echo  */ >> day-%1.p
echo. > day-%1.txt
echo. > test.txt
echo. > data.txt
:: open in browser
start https://adventofcode.com/%year%/day/%daynr%
goto :EOF