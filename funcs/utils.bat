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



:primary_and_optn_chars
    setlocal
    set "right_char=%~1"

    set left_char=

    if "!right_char!" equ "" (
        set "left_char=@"
        set "right_char=@"
        set "optn_one_left=@"
        set "optn_one_right=@"
        set "optn_two_left=@"
        set "optn_two_right=@"
    )

    if "!right_char!" equ ")" (
        set "left_char=("
    
        set "optn_one_left={"
        set "optn_one_right=}"

        set "optn_two_left=["
        set "optn_two_right=]"

    )

    if "!right_char!" equ "}" (
        set "left_char={"
        set "optn_one_left=["
        set "optn_one_right=]"
        set "optn_two_left=("
        set "optn_two_right=)"
    )
    if "!right_char!" equ "]" (
        set "left_char=["
        set "optn_one_left=("
        set "optn_one_right=)"
        set "optn_two_left={"
        set "optn_two_right=}"
    )

    set "prime=!left_char!|!right_char!"
    set "optn1=!optn_one_left!|!optn_one_right!"
    set "optn2=!optn_two_left!|!optn_two_right!"

    set "chars=!prime!|!optn1!|!optn2!|"
    echo !chars! > "chars.txt"
    

    endlocal
exit /b


:print
    setlocal
    echo HELLO WORLD
    endlocal
exit /b