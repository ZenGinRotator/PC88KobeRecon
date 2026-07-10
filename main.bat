setlocal EnableDelayedExpansion

@ set "src=..\ARCHV_RECON"
@ set "u_scor=UNDERSCORES"
@ set "prnth=PARENTHESES"
@ set "brkt=BRACKETS"


for /d %%i in ("%src%\*") do (


    @ rem parse the directory
    @ call :find_underscore "%u_scor%\DIR" "%%~nxi"
    @ call :parenths "%prnth%\DIR" "%%~nxi"
    @ call :brackets "%brkt%\DIR" "%%~nxi"

    for %%j in ("%%i\*") do (
        @ call :find_underscore "%u_scor%\FILE\%%~nxi" "%%~nxj"
        @ call :parenths "%prnth%\FILE" "%%~nxj"
        @ call :brackets "%brkt%\FILE" "%%~nxj"

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

        @ rem @ call :make_dir "%~1" "%~2"
        @ call :no_dir_make "%~1"
        @ call :no_file_make "%~1\%~2"

    )
exit /b


:make_dir
    md "%~1"
    echo > "%~1\%~2"
exit /b


:parenths
	@ call :word_only "(" ")" "%~1" "%~2"
exit /b

:brackets
	@ call :word_only "[" "]" "%~1" "%~2"
exit /b


:word_only
	@ set wrd_tail=
	@ set wrd=
	for /f "tokens=2 delims=%~1" %%i in ("%~4") do (
		@ set "wrd_tail=%%i"
	)
	for /f "tokens=1 delims=%~2" %%i in ("!wrd_tail!") do (
		@ set "wrd=%%i"
	)


    @ rem Remove the last char from word that might be a space character
    for /f "tokens=1 delims= " %%i in ("!wrd!") do (
        @ set "wrd=%%i"

    )

	if "!wrd!" neq "" (
		@ rem @ md "%~3\!wrd!\"
        @ call :no_dir_make "%~3\!wrd!"
		@ rem echo > "%~3\!wrd!\%~4"
        @ call :no_file_make "%~3\!wrd!\%~4"
	)
exit /b

:no_file_make
    if not exist "%~1" (
        @ rem @ md ""
        echo > "%~1"z
    )
exit /b

:no_dir_make
    if not exist "%~1" (
        @ md "%~1"
    )
exit /b