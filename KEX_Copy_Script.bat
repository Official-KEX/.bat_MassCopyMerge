@echo off
setlocal enabledelayedexpansion
set /p "start_folder=Enter the name of the folder you want to search through: "
if "%start_folder%"=="" (
    set "root_dir=%~dp0"
) else (
    set "root_dir=%~dp0%start_folder%"
)
set /p "output_folder=Enter the name of the output folder: "
set "target_dir=%~dp0%output_folder%"
if not exist "%target_dir%" mkdir "%target_dir%"
echo What should I copy?:
echo 1. EVERY FILE in those folders
echo 2. Files containing a certain name
set /p "choice=Enter your choice (1/2): "
set "pattern=*"
if "%choice%"=="2" (
    set /p "filename=What should i look for and copy?: "
)
set "checked=0"
set "copied=0"
set "prefix=0"
echo Checking files...
for /r "%root_dir%" %%f in (%pattern%) do (
    set /a checked+=1
    if "%choice%"=="2" (
        echo %%~nxf | find /i "%filename%" >nul && (
            for %%d in ("%%~dpf.") do (
                set /a prefix+=1
                copy "%%f" "%target_dir%\KCS-!prefix!-%%~nxd-%%~nxf" >nul
                set /a copied+=1
            )
        )
    ) else (
        for %%d in ("%%~dpf.") do (
            set /a prefix+=1
            copy "%%f" "%target_dir%\KCS-!prefix!-%%~nxd-%%~nxf" >nul
            set /a copied+=1
        )
    )
    cls
    echo Files checked: !checked! Copied: !copied!
)
cls
echo All done! Files checked: %checked% Copied: %copied%
echo You'll find them in the %target_dir% folder!
pause
endlocal