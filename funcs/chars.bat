setlocal EnableDelayedExpansion

call %*

goto :eof


:start_n_ends
    setlocal
    set "name=%~1"
    set "show_out=%~2"
    echo "!brk!" NAME: -- "!name!" ---
   

    if exist first_char.txt ( del first_char.txt )
    if exist last_char.txt ( del last_char.txt )

    set no_output=
    set "show_output=\"
    call "funcs_first_char.bat" :find_first_char "!name!" "!show_out!"
    for /f "tokens=1 delims=|" %%i in (first_char.txt) do (
        set "left=%%i"
        if "!left!" equ "@" (
            set left=
        )
    )

    call "funcs_last_char.bat" :find_last_char "!name!" "!show_out!"
    
    for /f "tokens=1 delims=|" %%i in (last_char.txt) do (
        set "right=%%i"
        if "!right!" equ "@" (
            set right=
        )
    )

    echo **** "!left!" "!right!"

    endlocal
exit /b