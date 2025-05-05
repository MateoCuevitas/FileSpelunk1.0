@echo off
setlocal enabledelayedexpansion

:: === CHANGE THE PATH IN COMMON SETTINGS TO WHERE YOU WANT TO SEARCH, OUTPUT SAVED, AND PATH TO SYSINTERNALSUITE!! ===

:: === COMMON SETTINGS ===
set "targetDir=C:\Your\Path\Here"
set "outputDir=C:\Path\To\Output\Desired"
set "stringsExe=C:\Path\To\SysinternalsSuite\strings64.exe"
set "fileTypes=*.txt *.log *.csv *.rtf *.xml *.json *.html *.htm *.eml"

if not exist "%outputDir%" mkdir "%outputDir%"

:: === FUNCTION TEMPLATE ===
:: CALL :RunSearch "SearchName" "SearchTerms" "OutputFileName"

:: === SEARCH JOBS ===
CALL :RunSearch "All_Strings"      "String 1 String 2 String 3 String 4"     "Matches_All_Strings.csv"

CALL :RunSearch "Only_String1"     "String 1"         "Only_String1.csv"
CALL :RunSearch "Only_String2"        "String 2"            "Only_String2.csv"
CALL :RunSearch "Only_String3"  "String 3"      "Only_String3.csv"
CALL :RunSearch "Only_String4"     "String 4" "Only_String4.csv"

goto :EOF

:RunSearch
set "searchName=%~1"
set "terms=%~2"
set "outputFile=%outputDir%\%~3"

echo.
echo ----------------------------------------
echo [!searchName!] Searching for: %terms%
echo Output: !outputFile!

if exist "!outputFile!" del "!outputFile!"
echo "Filename","Last Modified","Extension","Matched Lines" >> "!outputFile!"

set /a total=0
set /a matches=0

for %%x in (%fileTypes%) do (
    for /R "%targetDir%" %%f in (%%x) do (
        set /a total+=1
        "%stringsExe%" "%%f" > "%temp%\current_strings.tmp" 2>nul

        set "includeFile=true"
        for %%t in (%terms%) do (
            findstr /i "%%t" "%temp%\current_strings.tmp" >nul || set "includeFile="
        )

        if defined includeFile (
            set /a matches+=1
            set "matchLines="

            for /f "usebackq delims=" %%l in ("%temp%\current_strings.tmp") do (
                echo %%l | findstr /i "%terms%" >nul && set "matchLines=!matchLines!%%l || "
            )

            echo "%%~f","%%~tf","%%~xf","!matchLines!" >> "!outputFile!"
        )

        <nul set /p="Scanning !searchName!: !total! files, !matches! matches... `r"
    )
)

echo.
echo [!searchName!] Finished. Matches: !matches!
goto :EOF
