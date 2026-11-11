
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

    set "smallest_bridge= "
    set "bridge=!pad_name!"


    call :delim_bridge "!pad_name!" "("
    for /f "tokens=1 delims=|" %%i in (return.txt) do (
        if "%%i" neq " " (
            set "first_char_=%%i"
        )
    )
    for /f "tokens=2 delims=|" %%i in (return.txt) do (
        if "%%i" neq " " (
            set "bridge=%%i"
        )
    )




    call :delim_bridge "!bridge!" "["
    for /f "tokens=1 delims=|" %%i in (return.txt) do (
        if "%%i" neq " " (
            set "first_char_=%%i"
        )
    )
    for /f "tokens=2 delims=|" %%i in (return.txt) do (
        if "%%i" neq " " (
            set "bridge=%%i"
        )
    )




    call :delim_bridge "!bridge!" "{"
    for /f "tokens=1 delims=|" %%i in (return.txt) do (
        if "%%i" neq " " (
            set "first_char_=%%i"
        )
    )
    for /f "tokens=2 delims=|" %%i in (return.txt) do (
        if "%%i" neq " " (
            set "bridge=%%i"
        )
    )
   

    call ".\funcs\verify\first.bat" :start_bridge "!first_char_!" "!name!" "!bridge!" "!echo_verify!"
    
    
    endlocal
exit /b




:delim_bridge
    setlocal


    rem Phrase to delimit
    set "text=%~1"

    rem Left delimiting character
    set "left=%~2"

    set "first_char="
    set "bridge="
    set "delim_bridge="

    call ".\funcs\utils.bat" :delim_with_char "1" "!left!" "!text!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "delim_bridge=%%i"
    )

    if "!delim_bridge!" neq "!text!" (
        set "first_char=!left!"
        set "bridge=!delim_bridge!"
    )

    set "out=!first_char!|!bridge!|"

    echo !out! > return.txt
    echo "!out!"


    endlocal
exit /b