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


   
    if "!type!" equ "2" (
        set file=indivs.txt
    )


    rem use format argument
    if "!type!" equ "3" (
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

    if "!format!" equ "0" (
        if exist is_nested.txt (
            set /a same_line+=1
        )
    )

    if "!format!" equ "2" (
        set /a same_line+=1
    )

    if "!format!" equ "3" (
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