setlocal EnableDelayedExpansion
set brk=^



call %*


goto :eof



:reconstruct
    setlocal

    set "item=%~1"

    rem echo RECONSTRUCT WITH "!item!"

    rem exclude bridges composed of 1 or more spaces
   

    if not exist construct.txt (
        set "item=!item!|"
        echo !item! > construct.txt
        exit /b
    )

    set old=
    for /f "tokens=1 delims=|" %%i in (construct.txt) do (
        set "old=!old!%%i"
    )

    set "old=!old!!item!|"
    
    echo !old! > construct.txt

 
    endlocal
exit /b

:check_rt
    setlocal

    set "name=%~1"

    set construct=
    if exist construct.txt (
        for /f "tokens=1 delims=|" %%i in (construct.txt) do (
            set "construct=%%i"
        )
    )


    if "!name!" equ " " (
        set "construct= "
    )


rem ERRORS\RECONSTRUCT\REALTIME
    if "!construct!" neq "!name!" (
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        echo REAL TIME CONSTRUCT ERROR: constructed name vs input name
        echo "!construct!" 
        ECHO VS 
        ECHO "!name!"
    )

    endlocal
exit /b