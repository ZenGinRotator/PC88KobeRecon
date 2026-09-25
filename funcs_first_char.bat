
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

rem Work In Progress - might not need
:find
    setlocal
    set "name=%~1"

    set "padname=PAD!name!"
    echo PADNAME "!padname!"

    set first=
    set h_par=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "(" "!padname!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "h_par=%%i"
    )
    
    set t_sqr=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "[" "!h_par!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "t_sqr=%%i"
    )

    if "!t_sqr!" neq "!h_par!" (
        set "first=["
    )
    
    call "funcs_rom_keywords.bat" :delim_with_char "1" "{" "!t_sqr!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "t_cur=%%i"
    )

    if "!t_cur!" neq "!t_sqr!" (
        set "first={"
    )

    echo "first=" "!first!"


exit /b



    if "!hs!" equ "PAD" (
        ECHO "()"
        exit /b
    )
    rem set hs=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "{" "!hs!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "hs=%%i"
    )
    if "!hs!" equ "PAD" (
        ECHO "{"
        exit  /b
    )

    call "funcs_rom_keywords.bat" :delim_with_char "1" "[" "!hs!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "hs=%%i"
    )

    if "!hs!" equ "PAD" (
        echo "[]"
        exit /b
    )

    exit /b

    if "!hd!" neq "!padname!" (
        rem echo "!padname!" "("
        call "funcs_last_char.bat" :primary_and_optn_chars ")"
        for /f "tokens=*" %%i in (chars.txt) do (
            echo "!padname!" "%%i"
        )
        exit /b
    )

    set hd2=

    call "funcs_rom_keywords.bat" :delim_with_char "1" "{" "!hd!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "hd2=%%i"
        
    )

    if "!hd2!" neq "!hd!" (
        rem echo "!padname!" "{"
        call "funcs_last_char.bat" :primary_and_optn_chars "}"
        for /f "tokens=*" %%i in (chars.txt) do (
            echo "!padname!" "%%i"
            
        )

        exit /b
    )

    set hd3=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "[" "!hd2!" 
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "hd3=%%i"
    )

    if "!hd3!" neq "!hd2!" (
        rem echo "!padname!" "["
        call "funcs_last_char.bat" :primary_and_optn_chars "]"
        for /f "tokens=*" %%i in (chars.txt) do (
            echo "!padname!" "%%i"
        )

        exit /b
    )
    set "r=|"
    rem echo "!padname!" R "!r!"
    echo !r! > chars.txt
    rem for /f "tokens=1 delims=|" %%i in (chars.txt) do (
        rem echo chars "%%i"
    rem )
    endlocal
exit /b

:isolate
    setlocal

    endlocal
exit /b