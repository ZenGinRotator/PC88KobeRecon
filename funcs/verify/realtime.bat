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