
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


    echo ------------------------------ "!name!" --------------------
    set "pad_name=PAD!name!"

    set first_char=
    set p_bridge=
    set c_bridge=
    set s_bridge=
    set "smallest_bridge= "
    call "funcs_rom_keywords.bat" :delim_with_char "1" "(" "!pad_name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "p_bridge=%%i"
    )

    if "!p_bridge!" neq "!pad_name!" (
        set "first_char=("
        set "smallest_bridge=!p_bridge!"
    ) 

    rem set "p_bridge=PAD!p_bridge!"
    call "funcs_rom_keywords.bat" :delim_with_char "1" "[" "!p_bridge!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "s_bridge=%%i"
    )

    if "!s_bridge!" neq "!p_bridge!" (
        set "first_char=["
        set "smallest_bridge=!s_bridge!"
    ) 


    call "funcs_rom_keywords.bat" :delim_with_char "1" "{" "!s_bridge!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "c_bridge=%%i"
    )

    if "!c_bridge!" neq "!s_bridge!" (
        set "first_char={"
        set "smallest_bridge=!c_bridge!"
    )
    

    call :verify_smallest_bridge "!first_char!" "!name!" "!smallest_bridge!" "!echo_verify!"
    
    
    endlocal
exit /b


rem Compare the bridge from the found first character, with the bridges 
rem     found with the optional characters
:verify_smallest_bridge
    setlocal
    set "first_char=%~1"
    set "phrase=%~2"
    set "smallest_bridge=%~3"
    set "echo_verify=%~4"

    set "right_char=)"
    if "!first_char!" equ "{" (
        set "right_char=}"
    )

    if "!first_char!" equ "[" (
        set "right_char=]"
    )

    set o1_left_char=
    set o2_left_char=
    call "funcs_last_char.bat" :primary_and_optn_chars "!right_char!"
    for /f "tokens=3 delims=|" %%i in (chars.txt) do (
        set "o1_left_char=%%i"
    )
    
    for /f "tokens=5 delims=|" %%i in (chars.txt) do (
        set "o2_left_char=%%i"
    )

    set /a not_first=0

    set o1_bridge=
    set o2_bridge=
    set "pad_name=PAD!phrase!"
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!o1_left!" "!smallest_bridge!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "o1_bridge=%%i"
    )

    call "funcs_rom_keywords.bat" :delim_with_char "1" "!o2_left!" "!smallest_bridge!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "o2_bridge=%%i" 
    )


    rem primary bridge vs. each optional bridge
    set /a same_found_bridge=0
    if "!o1_bridge!" neq "!smallest_bridge!" (
        set /a same_found_bridge+=1
    )

    if "!o2_bridge!" neq "!smallest_bridge!" (
        set /a same_found_bridge+=1
    )


    
    set "pad_bridge=PAD!smallest_bridge!"

    set "los=!first_char!|!o1_left_char!|!o2_left_char!"
    set "firsts=!smallest_bridge!|!smallest_bridge!"
    set "o_bridges= !o1_bridge!| !o2_bridge!"

    set "ops=!los!|!firsts!|!o_bridges!"


    set first_chr_func=
    if "!same_found_bridge!" neq "0" (
        if "!echo_verify!" neq "" (
            set fail=

            call "funcs_last_char.bat" :out "!ops!" !first_chr_func!" "!fail!" 
        )

        pause
        exit /b
    )
    set "pass=p"
    call "funcs_last_char.bat" :out "!ops!" "!first_chr_func!" "!pass!"

    endlocal
exit /b