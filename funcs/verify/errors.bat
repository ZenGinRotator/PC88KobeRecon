setlocal EnableDelayedExpansion




call %*

goto :eof

rem This is a new file and function. Need to use git add ... command
:char_error
    setlocal
    set "ers=%~1"

    set "chr_func="
    set "not_reduced="
    set "ops="
    set "echo_verify="
    set "name="
    set "path="



    for /f "tokens=1 delims=|" %%i in ("!ers!") do (
        set "chr_func=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!ers!") do (
        set "not_reduced=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!ers!") do (
        set "ops=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!ers!") do (
        set "echo_verify=%%i"        
    )
    for /f "tokens=5 delims=|" %%i in ("!ers!") do (
        set "path=%%i"        
    )
    for /f "tokens=6 delims=|" %%i in ("!ers!") do (
        set "name=%%i"        
    )
    
    
    set "prompt=FIRST"
    if "!chr_func!" equ "L" (
        set "prompt=LAST"
    )

    set "do_exist=|"
    if "!not_reduced!" neq "0" (
        if "!echo_verify!" neq "" (
            set "fail="
            call ".\funcs\encaps\last.bat" :out "!ops!" "!chr_func!" "!fail!"
        )
        echo !name! > "!path!\!name!"
        echo "!prompt! CHAR ERROR, FILE NAME: !name!"
        set "do_exist=T|"
        PAUSE

    )

    echo !do_exist! > return.txt

    endlocal
exit /b


:reconstruct_errors
    setlocal
    
    set "name=%~1"
    set "flag=%~2"

    set file=construct.txt
    set "prompt=REAL TIME"

    if "!flag!" equ "BL" (
        set file=name.txt
        set "prompt=BY LABEL"
    )

    set construct=
    if exist !file! (
        for /f "tokens=1 delims=|" %%i in (!file!) do (
            set "construct=%%i"
        )
    )


    if "!name!" equ " " (
        set "construct= "
    )


rem ERRORS\RECONSTRUCT\REALTIME
    if "!construct!" neq "!name!" (
        echo "*************************************************************"
        echo "!prompt! CONSTRUCT ERROR: constructed name vs input name"
        echo "!construct!" 
        ECHO VS 
        ECHO "!name!"
        pause
    )
    endlocal
exit /b