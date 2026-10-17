setlocal EnableDelayedExpansion


set hep=has_encaps_pnth.txt
set hec=has_encaps_curl.txt
set hes=has_encaps_sqr.txt

set inp=is_nested_pnth.txt
set inc=is_nested_curl.txt
set ins=is_nested_sqr.txt

set grptxt=group.txt
set delimtxt=delimited.txt
set toktxt=tokens.txt
set encptd=encapsulated.txt
set onstxt=ones.txt
set brgtxt=bridges.txt
set brk=^




call %*

goto :eof



:delim_with_char
    setlocal
    rem %~1: token
    rem %~2: delim char 
    rem (eg. [, (, {, ], ), or })
    set "phrase=%~3"
     rem echo ---- DELIMITING "%~3"---- with "%~1" and "%~2"
    set d=
    for /f "tokens=%~1 delims=%~2" %%i in ("!phrase!") do (
        set "d=%%i"
    )

    set "d=!d!|"
    echo !d! > "%delimtxt%"
    endlocal
exit /b

:print
    setlocal
    echo HELLO WORLD
    endlocal
exit /b