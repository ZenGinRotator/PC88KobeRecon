setlocal EnableDelayedExpansion
set brk=^



call %*

goto :eof



:positions_list
    setlocal

    set "type=%~1"
    set "qty=%~2"
    set "item=%~3"
    set "is_blank=%~4"
    rem item = #<something>|, where something is label, bridge, or a space-bridge of unknown length
    
    set "alpha=B"

    if "!type!" equ "INDIV" (
        set "alpha=I"
    )

    if "!type!" equ "ROM" (
        set "alpha=R"
    )

    if "!type!" equ "NESTED" (
        set "alpha=N"
    )

    rem Now is single spaced item
   
    if "!is_blank!" neq " " (
        set "alpha=S"
    )


    set file=positions.txt
    
    set "code=!alpha!.!qty!|"
    
    
    rem EXIT /B

    if not exist !file! (
        echo !code! > !file!
        exit /b
    )

    set old=
    for /f "tokens=1 delims=|" %%i in (!file!) do (
        set "old=!old!%%i!brk!"
    )
    

    set "old=!old!!code!"
   
   
    echo !old! > !file!
    

    endlocal
exit /b



:item_separator
    setlocal

    rem encap style, can be:
    rem     {label 1
    rem     {label L}, 1 < L < n
    rem     {label n}

    set "encap=%~1"

    set /a same_line=0
    
    if not exist is_nested.txt (
        set "return=!same_line!!end_mark!"
        if exist return.txt ( del return.txt )
        echo !return! > return.txt
        exit /b
    )

    if "!encap!" equ "BRDG" (
        set /a same_line+=1
    )

    if "!encap!" equ "CLSD" (
        set /a same_line+=1
    )

    rem set "same_line=!same_line!!end_mark!"
    set "return=!same_line!!end_mark!"
    if exist return.txt ( del return.txt )
    echo !return! > return.txt
    endlocal
exit /b


:is_item_all_spaces
    setlocal

    rem is:
    rem     bridge of at least 1 character,
    rem     indiv {label 1},
    rem     part of nested group {label 1, {label 2}, {label 3 }, ... label n},
    rem     or bridge of 1 or more spaces (ex: " ", "          ")
    set "item_from_name=%~1"

    set /a space_qty=0

    call ".\funcs\utils.bat" :delim_with_char "1" " " "!item_from_name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        if "%%i" equ " " (
            set /a space_qty+=1
        )
    )

    set "is_blank="
    if "!space_qty!" equ "1" (
        set "is_blank=T"
    )

    set "is_blank=!is_blank!|"

    if exist return.txt ( del return.txt )

    echo !is_blank! > return.txt

    endlocal
exit /b




:prep_item_with_spaces
    setlocal
    rem object from name, can be:
    rem     NESTED
    rem     INDIV
    rem     BRIDGE
    set "obj=%~1"

    rem encap style, can be:
    rem     {label 1
    rem     {label L}, 1 < L < n
    rem     {label n}
    set "encap=%~2"
    rem boolean flag 
    set "is_blank=%~3"

    rem item from name
    set "item=%~4"

    set "use=!space_saver!!item!"

    if "!obj!" EQU "NESTED" (

        if "!encap!" equ "OPN_ENDD" (
            set "use=!space_saver!!item!"
        )

        if "!encap!" equ "CLSD" (
            set "use=!item!"
        )

        if "!encap!" equ "OPN_STRTD" (
            set "use=!item!"
        )
    )



    if "!is_blank!" neq " " (
        set "use=!space_saver!!item!!end_mark!"
        if exist is_nested.txt (
            set "use=!item!!end_mark!"
        )
    )

    set "use=!use!!end_mark!"

    if exist return.txt ( del return.txt )
    echo !use! > return.txt
    endlocal
exit /b