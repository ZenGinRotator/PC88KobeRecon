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


:start_bridge
    setlocal

    set "first_char=%~1"
    set "phrase=%~2"
    set "smallest_bridge=%~3"
    set "echo_verify=%~4"


    set right_char=
    if "!first_char!" equ "(" (
        set "right_char=)"
    )
    if "!first_char!" equ "{" (
        set "right_char=}"
    )

    if "!first_char!" equ "[" (
        set "right_char=]"
    )

    set o1_left_char=
    set o2_left_char=
    call ".\funcs\encaps\chars.bat" :primary_and_optn_chars "!right_char!"
    for /f "tokens=1 delims=|" %%i in (chars.txt) do (
        set "first_char=%%i"
    )

    for /f "tokens=2 delims=|" %%i in (chars.txt) do (
        set "right_char=%%i"
    )


    for /f "tokens=3 delims=|" %%i in (chars.txt) do (
        set "o1_left_char=%%i"
    )
    
    for /f "tokens=5 delims=|" %%i in (chars.txt) do (
        set "o2_left_char=%%i"
    )

    rem ECHO first char smallest bridge "!smallest_bridge!"
    call ".\funcs\encaps\chars.bat" :optns_in_last_char_bridge "!smallest_bridge!" "!o1_left!" "!o2_left!"
    
    set /a not_reduced=0
    set o1_bridge=
    set o2_bridge=
    for /f "tokens=1 delims=|" %%i in (reduced_bridge.txt) do (
        set /a not_reduced=%%i
    )
    for /f "tokens=2 delims=|" %%i in (reduced_bridge.txt) do (
        set "o1_bridge=%%i"
    )
    for /f "tokens=3 delims=|" %%i in (reduced_bridge.txt) do (
        set "o2_bridge=%%i"
    )


  
    rem echo "!first_char!"
    rem echo "!o1_left_char!"
    rem echo "!o2_left_char!"

    set "los=!first_char!|!o1_left_char!|!o2_left_char!"
    set "firsts=!smallest_bridge!|!smallest_bridge!"
    set "o_bridges=!o1_bridge!|!o2_bridge!"

    set "ops=!los!|!firsts!|!o_bridges!"
    

rem ERRORS\CHARS\FIRST
    set first_chr_func=
    if "!not_reduced!" neq "0" (
        rem if "!echo_verify!" neq "" (
        rem     set fail=
        rem     call ".\funcs\encaps\last.bat" :out "!ops!" !first_chr_func!" "!fail!" 
        rem )
        rem set "first_char=!first_char!|"
        rem echo !first_char! > "RECONSTRUCT_ERRORS\!phrase!.txt"
        rem echo FIRST CHAR ERROR, FILE NAME: "!phrase!"
        rem pause
        rem exit /b

        set "one=!first_chr_func!|!not_reduced!"
        set "two=!ops!|!echo_verify!"
        set "three=ERRORS\CHARS\FIRST|!phrase!"
        set "four=!first_char!"
        set "ers=!one!|!two!|!three!|!four!"
        call ".\funcs\verify\errors.bat" :char_error "!ers!"
        set "do_exit="
        for /f "tokens=1 delims=|" %%i in (return.txt) do (
            set "do_exit=%%i"
        )
        if "!do_exis!" equ "T" (
            exit /b
        )
    )




    set "pass=p"
    if "!echo_verify!" neq "" (
        call ".\funcs\encaps\last.bat" :out "!ops!" "!first_chr_func!" "!pass!"
    )
    set "first_char=!first_char!|"
    echo !first_char! > first_char.txt


    endlocal
exit /b