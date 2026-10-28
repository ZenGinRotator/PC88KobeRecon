setlocal EnableDelayedExpansion
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
    set "item=%~1"
    set "type=%~2"
    set "format=%~3"


    rem Block an item=" " in situations such as:
    rem Two neighboring closed labels, that are both indiv labels: (label 1)<space>(label 2)
    rem     and item=" " is a bridge, because we don't want 
    rem     to write item (" ") to bridges.txt file


    if "!item!" equ " " (
        if "!type!" equ "BRIDGE" (
            exit /b
        )
    )

    rem Need to exclude  bridges that need future recursion using DOIR# & DOIL#
    rem I might have an existing function that can be used to identify bridges matching these characteristics.
    set file=bridges.txt


   
    REM if "!type!" equ "2" (
    if "!type!" equ "INDIV" (
        set file=indivs.txt
    )


    rem use format argument
    
    if "!type!" equ "NESTED" (
        rem set file=nested.txt
        set file=nested_line.txt
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
    echo --------
rem     echo "!file!"
rem     echo type "!type!"
rem     echo Item "!item!"
rem     echo format "!format!"

    if "!format!" equ "BRDG" (
        
        rem " " in between two closed within nested set of labels
        if exist is_nested.txt (
            set /a same_line+=1
        )
    )

    rem last label of nested
    if "!format!" equ "OPN_STRTD" (
        echo "!format!"
        set /a same_line+=1
        set old=
        
        rem getting items from the temp file

        for /f "tokens=1 delims=|" %%i in (!file!) do (
            set "old=!old!%%i"
        )
        set "old=!old!!item!|"
        set "blank=|"
         echo !blank! > !file!
        rem del !file!
       
        rem getting items from primary file
        set nest_old=
        if exist nested.txt (
        for /f "tokens=1 delims=|" %%i in (nested.txt) do (
            set "nest_old=!nest_old!!brk!%%i"
        )
        )

        if "!nest_old!" equ "ECHO is off." (
            set "nest_old="
        )
        ECHO NEST OLD "!nest_old!"
        rem add temp items to primary file
        set "old=!nest_old!!brk!!old!|"
        echo !old! > nested.txt
exit /b
         
    )

    
    rem source of same line nested labels within nested.txt
    if "!format!" equ "CLSD" (
        
        rem closed within nested set of labels
        if exist is_nested.txt (
            set /a same_line+=1
        )
    )
    if "!same_line!" neq "0" (
        set "separator="
    )

    rem echo SAME-LINE "!same_line!"
    rem echo SEPARATOR "!separator!"


    set old=
    set with_brk=
    
    for /f "tokens=1 delims=|" %%i in (!file!) do (
        set "old=!old!!separator!%%i"
        set "with_brk=!with_brk!!brk!%%i"
    )
    
    rem if "!format!" equ "OPN_STRTD" (
        rem set "old=!old!!item!"
        rem SET "old=!old!|"
        rem ECHO !old! > nested.txt
        rem echo "" > !file!
        rem exit /b
    rem )

    
        
    
    set "old=!old!!separator!!item!|"
    



    
    echo *OLD "!old!"
    rem if "!old!" equ "ECHO is"

    rem if "!format!" neq "OPN_STRTD" (
    echo !old! > "!file!"
    rem )



    endlocal
exit /b