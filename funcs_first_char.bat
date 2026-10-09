
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
    echo FIND2 FIRST CHAR  "!first_char!"

    call :verify_ "!first_char!" "!name!" "!smallest_bridge!"
    
    
    endlocal
exit /b

:verify_
    setlocal
    set "first_char=%~1"
    set "phrase=%~2"
    set "smallest_bridge=%~3"

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
    echo o1_left "!o1_left_char!"
    echo o2_left "!o2_left_char!"

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

    echo "!o1_bridge!"
    echo "!o2_bridge!"
    echo "!smallest_bridge!"
    REM exit /b 
    set /a same_found_bridge=0
    if "!o1_bridge!" neq "!smallest_bridge!" (
        set /a same_found_bridge+=1
    )

    if "!o2_bridge!" neq "!smallest_bridge!" (
        set /a same_found_bridge+=1
    )

    if "!same_found_bridge!" neq "0" (
        echo FALSE
        pause
        exit /b
    )

    echo PASSED FIRST CHAR _V_
    exit /b

    set "pad_name=PAD!phrase!"
    set test_o1L=
    set test_o2L=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!o1_left!" "!pad_name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "test_o1L=%%i"
    )

    call "funcs_rom_keywords.bat" :delim_with_char "1" "!o2_left!" "!pad_name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "test_o2L=%%i"
    )


    set has_first_o1=
    set has_first_o2=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!first_char!" "!test_o1L!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "has_first_o1=%%i"
    )

    call "funcs_rom_keywords.bat" :delim_with_char "1" "!first_char!" "!test_o2L!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "has_first_o2=%%i"
    )



    endlocal
exit /b