setlocal EnableDelayedExpansion
set delimtxt=delimited.txt

set "end_mark=|"
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


rem use this function for reconstruction-related funcs
rem use this function for label-indivs, and label-nested
:item_into_file
    setlocal
    set "item=%~1"
    set "format=%~2"
    set "code=%~3"

    
    set "file="
    if "!code!" equ "BRIDG" (
        set file=bridges.txt
    )
    if "!code!" equ "INDVS" (
        set file=indivs.txt
    )
    if "!code!" equ "NSTD" (
        set file=nested.txt
    )
    if "!code!" equ "NSTD_LN" (
        set file=nested_line.txt
    )
    if "!code!" equ "SPCS" (
        set file=spaces.txt
    )

    if "!code!" equ "NAME" (
        set file=name.txt
    )

    if "!code!" equ "LABEL_NESTED" (
        set file=label_nested.txt
    )

    if "!code!" equ "LABEL_INDIV" (
        set file=label_indiv.txt
    )

    if "!code!" equ "LABEL_NESTED2" (
        set file=label_nested2.txt
        rem change NESTED to NESTED2, to avoid line separator
        set "format=!format!2"
    )

    if "!file!" equ "" (
        exit /b
    )

    set "separator=!brk!"

    set /a same_line=0

    call :item_separator "!format!"
    for /f "tokens=1 delims=|" %%i in (return.txt) do (
        set "same_line=%%i"
    )


    
    if "!same_line!" neq "0" (
        set "separator="
    )

    set old=

    set /a qty=0
    if exist !file! (
        for /f "tokens=1 delims=|" %%i in (!file!) do (
            set "old=!old!%%i!separator!"
            set /a qty+=1
        )
    )




    set "returned="
    call :rec_remove_spaces "!code!" "!item!"
    for /f "tokens=1 delims=|" %%i in (return.txt) do (
      set "returned=%%i"
      if "!returned!" neq "F" (
        set "item=!returned!"
      )
        
    )

    set "old=!old!!item!"
    
    
    set /a qty+=1
    

    echo !old! > "!file!"

    echo !qty! > return.txt

    endlocal
exit /b

:rec_remove_spaces
    setlocal

    set "code=%~1"
    set "item=%~2"

    set /a do_it=0
    if "!code!" equ "LABEL_NESTED" (
        set /a do_it+=1
    )
    if "!code!" equ "LABEL_NESTED2" (
        set /a do_it+=1
    )

    set "return_this=F|"
    if "!do_it!" equ "0" (
        echo !return_this! > return.txt
        exit /b
    )

    set "mod="
    call :rec_blank "1" "!item!" ""
    for /f "tokens=1 delims=|" %%i in (return.txt) do (
        set "mod=%%i|"
    )

    echo !mod! > return.txt


    endlocal
exit /b

:rec_blank
    setlocal
    set "token=%~1"
    set "phrase=%~2"
    set "saved=%~3"

    set "item="
    call ".\funcs\utils.bat" :delim_with_char "!token!" " " "!phrase!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )

    if "!item!" equ " " (
        set "saved=!saved!|"
        echo !saved! > return.txt
        exit /b
    )

    if "!saved!" equ "" (
        set "saved=!item!"
    ) else (
        set "saved=!saved! !item!"
    )
    
    set /a token+=1
    call :rec_blank "!token!" "!phrase!" "!saved!"

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

    if "!encap!" equ "NESTED" (
        set /a same_line+=1
    )
    if "!encap!" equ "INDIV" (
        set /a same_line+=1
    )


    set "return=!same_line!!end_mark!"
    if exist return.txt ( del return.txt )
    echo !return! > return.txt
    endlocal
exit /b