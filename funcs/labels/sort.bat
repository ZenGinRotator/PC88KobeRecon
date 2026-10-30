setlocal EnableDelayedExpansion
set "space_saver=#"
set "end_mark=|"
set brk=^




call %*

goto :eof



rem !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
rem This function needs revisions to account for situations
rem     where the BRIDGE is actually a ROM name.

rem How do we implement this and have it working correctly,
rem     despite our test data not having a ROM descriptor
rem     within the file name.
rem !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
rem Use this function to save bridges, indivs, or nested labels
:sort_label
    setlocal

    rem partially or fully encapsulated label, OR BRIDGE
    set "item=%~1"

    rem type= BRIDGE, INDIV, or NESTED
    set "type=%~2"

    rem open-started OPN_STRTD, open-ended OPN_ENDD, closed, BRDG?
    set "format=%~3"
    
    
   
    set "orig_item=!item!"

    
    

    SET "is_blank="
    call :is_item_all_spaces "!item!"
    for /f "tokens=1 delims=|" %%i in (return.txt) do (
        set "is_blank=%%i"
    )
    rem echo "!is_blank!"

    rem Need to exclude  bridges that need future recursion using DOIR# & DOIL#
    rem I might have an existing function that can be used to identify bridges matching these characteristics.
    set file=bridges.txt


   
    REM if "!type!" equ "2" (
    if "!type!" equ "INDIV" (
        set file=indivs.txt
    )


    if "!type!" equ "NESTED" (
        set file=nested_line.txt
    )


    if "!is_blank!" neq " " (
        set file=spaces.txt
        if exist is_nested.txt (
            set file=nested_line.txt
        )
    )




    call :prep_item_with_spaces "!type!" "!format!" "!is_blank!" "!orig_item!"
    for /f "tokens=1 delims=|" %%i in (return.txt) do (
        set "item=%%i"
    )
    set "item=!item!!end_mark!"
    



    if not exist "!file!" (       
        echo !item! > "!file!"

        rem To account for space-derived bridge
        

        REM stop add to position.txt when we enter the first label
        rem     belonging to the first instance of a nested set of labels
        if "!type!" neq "NESTED" (
            call :label_list "!type!" "1" "!item!" "!is_blank!"
        )
        exit /b
    )


    rem DECOUPLE into functions
    rem reading file, needs:
    rem     if exists condition
    rem     qty counter
    rem     separator for joining previously read contents
    rem     print statement?: echo ? for showing errors 
    rem     print errors:
    rem         mismatching file names,
    rem         other related errors

    rem --------------------------------------------
    rem last label of nested
    if "!format!" equ "OPN_STRTD" (
        
        set old=
        
        rem getting items from the temp file
        for /f "tokens=1 delims=|" %%i in (!file!) do (
            set "old=!old!%%i"
        )
        set "old=!old!!item!|"
        set "blank=|"
        echo !blank! > !file!
        

        rem getting items from primary file
        set nest_old=
        set copy=
        rem quantity for the label of the same type
        set /a qty=0


        if exist nested.txt (
            for /f "tokens=1 delims=|" %%i in (nested.txt) do (
                set "nest_old=!nest_old!%%i!brk!"
                set /a qty+=1
            )
        )

        rem add temp items to primary file

        set "old=!nest_old!!old!!item!|"
        echo !old! > nested.txt

        set /a qty+=1
        call :label_list "!type!" "!qty!" "!item!" "!is_blank!"
        exit /b
         
    )
    rem --------------------------------------------



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
    set copy_=
    set with_brk=
    set /a qty=0
    for /f "tokens=1 delims=|" %%i in (!file!) do (
        rem set "old=!old!!separator!%%i"
        set "old=!old!%%i!separator!"
        set /a qty+=1
    )
         
   
    
    rem set "old=!old!!separator!!item!"
    set "old=!old!!item!"
    echo !old! > "!file!"



    rem block counter for number of nested lables,
    rem     We determine this quantity when finding open_started label

    rem quantity for the label of the same type
    set /a qty+=1
    if "!type!" neq "NESTED" (
        call :label_list "!type!" "!qty!" "!item!" "!is_blank!"
    )

    endlocal
exit /b




:label_list
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

    if "!type!" equ "NESTED" (
        set "alpha=N"
    )

    rem Now is single spaced item
   
    if "!is_blank!" neq " " (
        set "alpha=S"
    )


    set file=positions.txt
    
    set "code=!alpha!.!qty!|"
    rem echo CODE: !code! ITEM "!item!"
    
    rem EXIT /B

    if not exist !file! (
        rem echo START WITH CODE "!code!"
        echo !code! > !file!
        exit /b
    )

    set old=
    for /f "tokens=1 delims=|" %%i in (!file!) do (
        set "old=!old!%%i!brk!"
        rem echo echoing "%%i"
    )
    

    set "old=!old!!code!"
   
   
    rem echo Positions: OLD 
    rem echo "!old!"
    
    rem echo end of old
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
            set "use=!item!!space_saver!"
        )
    )



    if "!is_blank!" neq " " (
        set "use=!space_saver!!item!!end_mark!"
        if exist is_nested.txt (
            set "use=!item!!end_mark!"
        )
    )

    set "use=!use!!end_mark!"
    echo !use! > return.txt
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
    echo !return! > return.txt
    endlocal
exit /b


:read_file
    setlocal



    endlocal
exit /b