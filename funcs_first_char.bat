
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


:find_first_char
    setlocal
    set "name=%~1"
    set "echo_verify=%~2"
    rem echo EV "!echo_verify!"
    rem pause

    if "!echo_verify!" neq "" (
        echo ------------------------------ "!name!" --------------------
    )
    
    set "pad_name=PAD!name!"
    rem echo padname "!pad_name!"

    set first_char=
    set p_bridge=
    set c_bridge=
    set s_bridge=
    set "smallest_bridge= "
    call ".\funcs\utils.bat" :delim_with_char "1" "(" "!pad_name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "p_bridge=%%i"
    )


    if "!p_bridge!" neq "!pad_name!" (
        set "first_char=("
        set "smallest_bridge=!p_bridge!"
    )

    call ".\funcs\utils.bat" :delim_with_char "1" "[" "!p_bridge!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "s_bridge=%%i"
    )

    if "!s_bridge!" neq "!p_bridge!" (
        set "first_char=["
        set "smallest_bridge=!s_bridge!"
    )


    call ".\funcs\utils.bat" :delim_with_char "1" "{" "!s_bridge!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "c_bridge=%%i"
    )

    if "!c_bridge!" neq "!s_bridge!" (
        set "first_char={"
        set "smallest_bridge=!c_bridge!"
    )
    rem echo p bridge "!p_bridge!"
    rem echo s bridge "!s_bridge!"
    rem echo c bridge "!c_bridge!"
    rem echo sm bridge "!smallest_bridge!"
    if "!c_bridge!" equ "PAD" (
        set "smallest_bridge=PAD"
    )

    if "!c_bridge!" equ "PAD " (
        set "smallest_bridge=PAD "
    )

   

    call :verify_smallest_bridge "!first_char!" "!name!" "!smallest_bridge!" "!echo_verify!"
    
    
    endlocal
exit /b

rem -- This might be a shared function for verifying the found first & last chars -- 
rem Compare the bridge from the found first character, with the bridges 
rem     found with the optional characters
:verify_smallest_bridge
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
    call ".\funcs\utils.bat" :primary_and_optn_chars "!right_char!"
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
    call ".\funcs\utils.bat" :optns_in_last_char_bridge "!smallest_bridge!" "!o1_left!" "!o2_left!"
    
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
rem echo after call "!o1_bridge!" "!o2_bridge!"
rem echo bridge "!smallest_bridge!"
rem echo "!o1_bridge!"
rem echo "!o2_bridge!"


  


    set "los=!first_char!|!o1_left_char!|!o2_left_char!"
    rem set los "!los!"

    set "firsts=!smallest_bridge!|!smallest_bridge!"
    set "o_bridges=!o1_bridge!|!o2_bridge!"

    set "ops=!los!|!firsts!|!o_bridges!"
    rem echo LAST CHAR OPSecho FIRST CHAR OPS
    rem echo "!los!"
    rem echo "!firsts!"
    rem echo "!o_bridges!"

    echo "!not_reduced!"
    set first_chr_func=
    if "!not_reduced!" neq "0" (
        if "!echo_verify!" neq "" (
            set fail=

            call "funcs_last_char.bat" :out "!ops!" !first_chr_func!" "!fail!" 
            
        )
        set "first_char=!first_char!|"
        echo !first_char! > first_char.txt
        echo FIRST CHAR PAUSE
        pause
        exit /b
    )
    set "pass=p"
    if "!echo_verify!" neq "" (
        call "funcs_last_char.bat" :out "!ops!" "!first_chr_func!" "!pass!"
    )
    set "first_char=!first_char!|"
    echo !first_char! > first_char.txt
    endlocal
exit /b