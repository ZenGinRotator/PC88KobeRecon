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
:sort_struct_label
    setlocal

    
    rem partially or fully encapsulated label, OR BRIDGE
    set "item=%~1"
rem echo ITEM --- "!item!"
    rem type= BRIDGE, INDIV, or NESTED
    set "type=%~2"

    rem open-started OPN_STRTD, open-ended OPN_ENDD, closed, BRDG?
    set "format=%~3"
    
    
   
    set "orig_item=!item!"

    rem ECHO item "!item!"
    

    SET "is_blank="
    call :is_item_all_spaces "!item!"
    for /f "tokens=1 delims=|" %%i in (return.txt) do (
        set "is_blank=%%i"
    )
    rem echo "!is_blank!"

    rem Need to exclude  bridges that need future recursion using DOIR# & DOIL#
    rem I might have an existing function that can be used to identify bridges matching these characteristics.
    set file=bridges.txt
    set "file_code=BRIDG"

   
    REM if "!type!" equ "2" (
    if "!type!" equ "INDIV" (
        set file=indivs.txt
        set "file_code=INDVS"
    )

    if "!type!" equ "ROM" (
        set file=rom.txt
        set "file_code=ROM"
    )

    if "!type!" equ "NESTED" (
        rem have alternate
        set file=nested_line.txt
        set "file_code=NSTD_LN"
    )


    if "!is_blank!" neq " " (
        set "file_code=SPCS"
        set file=spaces.txt
        

        rem have alternate
        if exist is_nested.txt (
            set file=nested_line.txt
            set "file_code=NSTD_LN"
        )
    )





    call :prep_item_with_spaces "!type!" "!format!" "!is_blank!" "!orig_item!"
    for /f "tokens=1 delims=|" %%i in (return.txt) do (
        set "item=%%i"
    )
    set "item=!item!!end_mark!"

    rem echo prepped ITEM "!item!"
    
    REM This, incorrectly, might include the first instance of a bridge
    rem within the file name, as a ROM descriptor when it should remain
    rem a bridge.
   
    
    

    rem echo ITME "!item!"
    set "rom="
    if exist rom.txt (
        
        for /f "tokens=1 delims=|" %%i in (rom.txt) do (
            set "rom=%%i"
        )
        if "!rom!|" equ "!item!" (
            exit /b
        )
    )

    rem Saving the first instace of a 
    if not exist "!file!" (       
        call :1st_instance_of_type "!type!" "!item!" "!is_blank!" "1" "!file_code!" "!item!"
        exit /b
    )


    rem last label of nested
    if "!format!" equ "OPN_STRTD" (
        call :is_opn_started "!file_code!" "!type!" "!is_blank!"
        exit /b
    )
    

    call :subsequents "!file_code!" "!format!" "!item!" "!type!" "!item!" "!is_blank!"

    endlocal
exit /b




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



:1st_instance_of_type
    setlocal
    set "type=%~1"
    set "write_this=%~2"
    set "is_blank=%~3"
    set "qty=%~4"
    set "code=%~5"
    set "line=%~6"

    
    if "!code!" equ "" ( exit /b )

    set "file="
    if "!code!" equ "BRIDG" (
        set file=bridges.txt
    )

    if "!code!" equ "ROM" (
        set file=rom.txt
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

    if "!file!" equ "" (
        exit /b
    )


    echo !write_this! > !file!

    if "!type!" NEQ "NESTED" (
        call :positions_list "!type!" "!qty!" "!line!" "!is_blank!"
    )

    endlocal
exit /b


:is_opn_started
    setlocal
    set "code=%~1"
    set "type=%~2"
    set "is_blank=%~3"

    if "!code!" equ "" ( exit /b )

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

    if "!file!" equ "" (
        exit /b
    )




    del is_nested.txt
    set "old_line="


        rem getting items from the nestd_line file
        for /f "tokens=1 delims=|" %%i in (!file!) do (
            set "old_line=!old_line!%%i"
        )

        rem add item to content from line file
        set "new_nested=!old_line!!item!|"
        
         
        set /a qty=0
        rem read all contents from nested file
        if exist nested.txt (
            set "old_nested="
            for /f "tokens=1 delims=|" %%i in (nested.txt) do (
                set "old_nested=!old_nested!%%i!brk!"
                set /a qty+=1
            )
        )


        rem add new nested line to existing content from nested file
        set "old_nested=!old_nested!!new_nested!"

        rem getting items from primary file
        rem quantity for the label of the same type
        
        del !file!



        set /a qty+=1

        echo !old_nested! > nested.txt
        call :positions_list "!type!" "!qty!" "!new_nested!" "!is_blank!"
    endlocal
exit /b

:subsequents
    setlocal

    set "code=%~1"
    set "format=%~2"
    set "item=%~3"
    rem echo item 1 "!item!"
    set "type=%~4"
    set "item=%~5"
    rem echo item 2 "!item!"
    set "is_blank=%~6"
    
    if "!code!" equ "" ( exit /b )

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

    if "!file!" equ "" (
        exit /b
    )

    rem 
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
    for /f "tokens=1 delims=|" %%i in (!file!) do (
        set "old=!old!%%i!separator!"
        set /a qty+=1
    )


    set "old=!old!!item!"
    
    
    set /a qty+=1
    
    rem echo FILE CODE "!file_code!"
  echo !old! > "!file!"
if "!type!" neq "NESTED" (
        call :positions_list "!type!" "!qty!" "!item!" "!is_blank!"
   )


    endlocal
exit /b