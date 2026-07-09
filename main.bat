setlocal EnableDelayedExpansion

@ set "src=..\ARCHV_RECON"
@ set "u_scor=UNDERSCORES"

for /d %%i in ("%src%\*") do (


    @ rem parse the directory
    @ call :find_underscore "%u_scor%\DIR" "%%~nxi"

    for %%j in ("%%i\*") do (
        @ call :find_underscore "%u_scor%\FILE\%%~nxi" "%%~nxj"

    )

)

echo END OF MAIN
pause
goto :eof



:find_underscore

    @ set part=
    for /f "tokens=1 delims=_" %%i in ("%~2") do (
        @ set "part=%%i"
    )

    echo ORIG "%~2" PART "!part!"
    @ rem pause
    @ rem @ goto :eof
    if "%~2" neq "!part!" (

        @ call :make_dir "%~1" "%~2"

    )
exit /b


:make_dir
    md "%~1"
    echo > "%~1\%~2"
exit /b