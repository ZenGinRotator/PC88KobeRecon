setlocal EnableDelayedExpansion
set brk=^




call %*

goto :eof


:labels
    setlocal

    set "item=%~1"
    set "status=%~2"
    set "code=LABEL_NESTED"

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

    if "!status!" equ "INDIV" (
        set "code=LABEL_INDIV"
    )

    call ".\funcs\labels\sort\utils.bat" :ti "!item!" "!status!" "!code!"

    endlocal
exit /b