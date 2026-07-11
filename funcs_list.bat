@ setlocal EnableDelayedExpansion



@ call %*
@ goto :eof






:list_gen

@ set src=
@ set u_scor=
@ set prnth=
@ set brkt=
@ set exts=

for /f "tokens=1 delims=|" %%i in ("%~1") do (
    @ set "src=%%i"
)
for /f "tokens=2 delims=|" %%i in ("%~1") do (
    @ set "u_score=%%i"
)
for /f "tokens=3 delims=|" %%i in ("%~1") do (
    @ set "prnth=%%i"
)
for /f "tokens=4 delims=|" %%i in ("%~1") do (
    @ set "brkt=%%i"
)
for /f "tokens=5 delims=|" %%i in ("%~1") do (
    @ set "exts=%%i"
)

for /d %%i in ("!src!\*") do (


    @ rem parse the directory
    @ call :find_underscore "!u_scor!\DIR" "%%~nxi"
    @ call :parenths "!prnth!\DIR" "%%~nxi"
    @ call :brackets "!brkt!\DIR" "%%~nxi"

    for %%j in ("%%i\*") do (
        @ call :find_underscore "!u_scor!\FILE\%%~nxi" "%%~nxj"
        @ call :parenths "!prnth!\FILE" "%%~nxj"
        @ call :brackets "!brkt!\FILE" "%%~nxj"
        @ call :extensions "!src!" "!exts!"
    )

)

@ rem %~2 = LIST_MADE
echo > "%~2"
exit /b



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


    @ rem This excludes second word beyond the space
    @ rem Remove the last char from word that might be a space character
    for /f "tokens=1 delims= " %%i in ("!wrd!") do (
        @ set "wrd=%%i"

    )

	if "!wrd!" neq "" (
		@ rem @ md "%~3\!wrd!\"
        @ call "funcs_no_make.bat" :no_dir_make "%~3\!wrd!"
		@ rem echo > "%~3\!wrd!\%~4"
        @ call "funcs_no_make.bat" :no_file_make "%~3\!wrd!\%~4"
	)
exit /b





:extensions

    for /d %%i in ("%~1\*") do (
        for %%j in ("%%i\*") do (
            echo ECHO "%%~nxj" "%%~xj"
            @ call "funcs_no_make.bat" :no_dir_make "%~2\%%~xj"
            @ call "funcs_no_make.bat" :no_file_make "%~2\%%~xj\%%~nxj"
           
        )
    )
exit /b