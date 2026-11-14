setlocal EnableDelayedExpansion
set brk=^




call %*

goto :eof


:labels
    setlocal

    set "item=%~1"
    set "status=%~2"

    if "!item!" equ " " (
        exit /b
    )

    set /a keep=0

    if "!status!" equ "NESTED" (
        set /a keep+=1
    )
    if "!status!" equ "INDIV" (
        set /a keep+=1
    )

    if "!keep!" equ "0" (
        exit /b
    )


    set "code=LABEL_NESTED"
    if "!status!" equ "INDIV" (
        set "code=LABEL_INDIV"
    )

    call ".\funcs\labels\sort\utils.bat" :item_into_file "!item!" "!status!" "!code!"

    if "!code!" equ "LABEL_NESTED" (
        set "code=!code!2"
    )

    call ".\funcs\labels\sort\utils.bat" :item_into_file "!item!" "!status!" "!code!"

    endlocal
exit /b