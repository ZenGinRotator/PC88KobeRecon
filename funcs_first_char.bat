
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

    rem change when character p, c, or s does not exist in name
    set /a fqty=3
    set /a total=9
    if "!p!" equ "!padname!" (
        set "p="
        set /a fqty-=1
        rem echo NOT P
        set /a total-=1
    )
    if "!c!" equ "!padname!" (
        set "c="
        set /a fqty-=1
        rem echo NOT C
        set /a total-=3
    )
    if "!s!" equ "!padname!" (
        set "s="
        set /a fqty-=1
        rem echo NOT S
        set /a total-=5
    )
    if "!fqty!" equ "2" (
        set /a fqty=1
    )

    set answ=
    if "!total!" equ "1" (
        set "answ=()"

    )
    if "!total!" equ "3" (
        set "answ={}"
    )
    if "!total!" equ "5" (
        set "answ=[]"
    )

    rem if "!total!" neq "9" (
        rem if "!fqty!" equ "1" (
            if "!answ!" neq "" (
        echo first char is "!answ!"
  exit /b
    )
    if "!fqty!" equ "0" (
        echo file is encap-free
        exit /b
    )

    if exist "stop.txt" ( del "stop.txt" )

    call :sum_em "!p!" "!s!" "!c!" "!fqty!" "("

    for /f "tokens=1 delims=|" %%i in (chars.txt) do (
        set "p=%%i"
    )

    for /f "tokens=2 delims=|" %%i in (chars.txt) do (
        set "s=%%i"
    )
    for /f "tokens=3 delims=|" %%i in (chars.txt) do (
        set "c=%%i"
    )

    if exist "stop.txt" ( exit /b )
 
    call :sum_em "!p!" "!s!" "!c!" "!fqty!" "["
    
    for /f "tokens=1 delims=|" %%i in (chars.txt) do (
        set "p=%%i"
    )
    for /f "tokens=2 delims=|" %%i in (chars.txt) do (
        set "s=%%i"
    )
    for /f "tokens=3 delims=|" %%i in (chars.txt) do (
        set "c=%%i"
    )

    if exist "stop.txt" ( exit /b )

    call :sum_em "!p!" "!s!" "!c!" "!fqty!" "{"
    for /f "tokens=1 delims=|" %%i in (chars.txt) do (
        set "p=%%i"
    )
    for /f "tokens=2 delims=|" %%i in (chars.txt) do (
        set "s=%%i"
    )
    for /f "tokens=3 delims=|" %%i in (chars.txt) do (
        set "c=%%i"
    )

    


    endlocal
exit /b

:isolate
    setlocal
    set "p=%~1"
    set "s=%~2"
    set "c=%~3"
    set "fqty=%~4"
    endlocal
exit /b

:sum_em
    setlocal
    set "delimp=%~1"
    set "delims=%~2"
    set "delimc=%~3"
    set "fqty=%~4"
    set "char=%~5"
rem echo "delimp" "!delimp!"
rem echo "delims" "!delims!"
rem echo "delimc" "!delimc!"
rem echo fqty "!fqty!"
rem echo char "!char!"
rem pause
    set p=
    set s=
    set c=
    if "!delimp!" neq  " " (
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!char!" "!delimp!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
       set "p=%%i" 
    )
    )

    if "!delims!" neq " " (
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!char!" "!delims!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
       set "s=%%i" 
    )
    )

    if "!delimc!" neq " " (
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!char!" "!delimc!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
       set "c=%%i" 
    )
    )
rem pause
    set "chars=!p!|!s!|!c!|"
    rem echo "CHARS" "!chars!"
    echo !chars! > "chars.txt"

    set /a q=0
    if "!p!" equ "!s!" (
        set /a q+=1
        
    )
    if "!p!" equ "!c!" (
        set /a q+=1
        
    )
    
    if "!c!" equ "!s!" (
        set /a q+=1
    )

    if "!q!" neq "!fqty!" (
        rem echo NOT BIG ENOUGH, Q "!q!", F "!fqty!"
        rem EXIT /b 
    )

    ECHO FOUND A FIRST "!char!"
    echo "" > "stop.txt"

    endlocal
exit /b