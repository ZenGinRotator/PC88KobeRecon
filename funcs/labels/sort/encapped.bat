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
:labels
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
    call ".\funcs\labels\sort\utils.bat" :is_item_all_spaces "!item!"
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





    call ".\funcs\labels\sort\utils.bat" :prep_item_with_spaces "!type!" "!format!" "!is_blank!" "!orig_item!"
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
        call ".\funcs\labels\sort\utils.bat" :positions_list "!type!" "!qty!" "!line!" "!is_blank!"
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
        call ".\funcs\labels\sort\utils.bat" :positions_list "!type!" "!qty!" "!new_nested!" "!is_blank!"
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

    rem Might be opportunity to re-use this portion as its own function,
    rem     so that function will be used for encapsulated and
    rem     non-encapsulated labels found in the file name.
    rem This function requires that file names are declared as global variables.
    rem set "separator=!brk!"

    rem set /a same_line=0

    rem call ".\funcs\labels\sort\utils.bat" :item_separator "!format!"
    rem for /f "tokens=1 delims=|" %%i in (return.txt) do (
    rem     set "same_line=%%i"
    rem )
    
    rem if "!same_line!" neq "0" (
    rem     set "separator="
    rem )

    rem set old=

    rem set /a qty=0
    rem for /f "tokens=1 delims=|" %%i in (!file!) do (
    rem     set "old=!old!%%i!separator!"
    rem     set /a qty+=1
    rem )


    rem set "old=!old!!item!"
    
    
    rem set /a qty+=1
    

    rem echo !old! > "!file!"
rem End of portion re-use

    set /a qty=0
    call ".\funcs\labels\sort\utils.bat" :ti "!item!" "!format!" "!code!"
    for /f "tokens=*" %%i in (return.txt) do (
        set /a qty=%%i
    )

    if "!type!" neq "NESTED" (
        call ".\funcs\labels\sort\utils.bat" :positions_list "!type!" "!qty!" "!item!" "!is_blank!"
   )


    endlocal
exit /b