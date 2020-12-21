@echo off
cls
set /a daynr=0
set ready=no

:loop
set /a daynr=daynr+1
set day=00%daynr%
set day=%day:~-2%
if not exist "Day-%day%" call :createFolder %daynr%
if "%ready%"=="yes" goto :EOF
if %day% gtr 25 goto :EOF
goto :loop
	
:createFolder
set ready=yes
set Folder=Day-%1
md %Folder%
cd %Folder%
echo /* AoC 2020 day %1 > day-%1.p
echo  */ >> day-%1.p
echo. > day-%1.txt
echo. > test.txt
:: open in browser
start https://adventofcode.com/2020/day/%daynr%
goto :EOF