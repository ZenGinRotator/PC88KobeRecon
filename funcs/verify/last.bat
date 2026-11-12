setlocal EnableDelayedExpansion

call %*

goto :eof


:end_bridge
    setlocal
    
    set "phrase=%~1"
    set "last_char=%~2"
    set "last_bridge=%~3"
    set "echo_verify=%~4"

   rem echo VLB bridge "!last_bridge!" "!last_char!"
    rem Collecting option chars
    set o1_right=
    set o2_right=

    REM echo VERIFY "LAST BRIDGE" "!last_bridge!"

    call ".\funcs\encaps\chars.bat" :primary_and_optn_chars "!last_char!"

    for /f "tokens=2 delims=|" %%i in (chars.txt) do (
        set "last_char=%%i"
    )

    for /f "tokens=4 delims=|" %%i in (chars.txt) do (
        set "o1_right=%%i"
    )
    
    for /f "tokens=6 delims=|" %%i in (chars.txt) do (
        set "o2_right=%%i"
    )
  
    set "pad_last_bridge=PAD!last_bridge!"
 


    call ".\funcs\encaps\chars.bat" :optns_in_last_char_bridge "!pad_last_bridge!" "!o1_right!" "!o2_right!"
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

    



    set "los=!last_char!|!o1_right!|!o2_right!"
    set "lasts=!last_bridge!|!pad_last_bridge!"
    set "o_bridges=!o1_bridge!|!o2_bridge!"

    set "ops=!los!|!lasts!|!o_bridges!"
   

    rem ERRORS\CHARS\LAST
    set "last_chr_func=L"
    if "!not_reduced!" neq "0" (
        rem if "!echo_verify!" neq "" (
        rem     set fail=
        rem     call ".\funcs\encaps\last.bat" :out "!ops!" "!last_chr_func!" "!fail!"
        rem )

        rem return error
        rem set "last_char=!last_char!|"
        rem echo !last_char! > "RECONSTRUCT_ERRORS\!phrase!.txt"
        rem echo LAST CHAR ERROR, FILE NAME: "!phrase!"
        rem PAUSE
        rem EXIT /B


        set "one=!last_chr_func!|!not_reduced!"
        set "two=!ops!|!echo_verify!"
        set "three=ERRORS\CHARS\LAST|!phrase!"
        set "four=!last_char!"
        set "ers=!one!|!two!|!three!|!four!|"
        call ".\funcs\verify\errors.bat" :char_error "!ers!"
        set "do_exit="
        for /f "tokens=1 delims=|" %%i in (return.txt) do (
            set "do_exit=%%i"
        )
        if "!do_exit!" equ "T" (
            exit /b
        )
    )
  

   
    set "pass=p"
    if "!echo_verify!" neq "" (
        call ".\funcs\encaps\last.bat" :out "!ops!" "!last_chr_func!" "!pass!"
    )

    set "last_char=!last_char!|"
    echo !last_char! > last_char.txt
    
    endlocal
exit /b