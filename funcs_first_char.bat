
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
    echo "!brk!"
    echo PADNAME "!padname!"

    set c=
    set p=
    set s=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "(" "!padname!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "p=%%i"
    )
    call "funcs_rom_keywords.bat" :delim_with_char "1" "{" "!padname!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "c=%%i"
    )
    call "funcs_rom_keywords.bat" :delim_with_char "1" "[" "!padname!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "s=%%i"
    )

    set /a q=0
    if "!p!" equ "!padname!" (
        set /a q+=1
    )
    if "!s!" equ "!padname!" (
        set /a q+=1
    )
    if "!c!" equ "!padname!" (
        set /a q+=1
    )

    if "!q!" equ "3" (
        echo NO ENCAPS 
        exit /b
    )

    call :count_it "!p!" "("
    call :count_it "!c!" "{"
    call :count_it "!s!" "["
    
exit /b

:count_it
    setlocal
    set "delim=%~1"
    set "char=%~2"
    rem set "delim=PAD!delim!"
    set del_p=
    set del_c=
    set del_s=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "(" "!delim!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "del_p=%%i"
    )
    call "funcs_rom_keywords.bat" :delim_with_char "1" "{" "!delim!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "del_s=%%i"
    )
    call "funcs_rom_keywords.bat" :delim_with_char "1" "[" "!delim!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "del_c=%%i"
    )

     set /a q=0

    if "!del_p!" equ "!delim!" (
        set /a q+=1
    )
    if "!del_c!" equ "!delim!" (
        set /a q+=1
    )
    if "!del_s!" equ "!delim!" (
        set /a q+=1
    )
    

    if "!q!" neq "3" (
        exit /b
    )
echo FIRST CHAR "!char!"
    


    endlocal
exit /b
