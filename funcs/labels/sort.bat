setlocal EnableDelayedExpansion

call %*

goto :eof


rem Use this function to save bridges, indivs, or nested labels
:sort_label
    setlocal
    set "item=%~1"
    set "type=%~2"
    set "format=%~3"

   

    rem Need to exclude  bridges that need future recursion using DOIR# & DOIL#
    rem I might have an existing function that can be used to identify bridges matching these characteristics.
    set file=bridges.txt


   
    REM if "!type!" equ "2" (
    if "!type!" equ "INDIV" (
        set file=indivs.txt
    )


    rem use format argument
    rem if "!type!" equ "3" (
    if "!type!" equ "NESTED" (
        set file=nested.txt
    )


    rem bridges


    rem file could exist

    if not exist "!file!" (
        REM echo OLD "!item!" into "!file!"
        set "item=!item!|"
        echo !item! > "!file!"
        exit /b
    )

    rem make diffline and sameline version
    set old=
    set "separator=!brk!"




    set /a same_line=0

    rem if "!format!" equ "0" (
    if "!format!" equ "BRDG" (
        if exist is_nested.txt (
            set /a same_line+=1
        )
    )

    rem if "!format!" equ "2" (
    if "!format!" equ "OPN_STRTD" (
        set /a same_line+=1
    )

    REM if "!format!" equ "3" (
    if "!format!" equ "CLSD" (
        if exist is_nested.txt (
            set /a same_line+=1
        )
    )
    if "!same_line!" neq "0" (
        set "separator="
    )

    rem echo SAME-LINE "!same_line!"
    rem echo SEPARATOR "!separator!"




    for /f "tokens=1 delims=|" %%i in (!file!) do (
        set "old=!old!!separator!%%i"
    )

    
    set "old=!old!!separator!!item!|"
    
    
    
    echo !old! > "!file!"
    endlocal
exit /b