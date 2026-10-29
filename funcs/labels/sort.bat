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
    set "add_space=%~4"


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

        REM stop add to position.txt when we enter the first label
        rem     belonging to the first instance of a nested set of labels
        if "!type!" neq "NESTED" (
            call :label_list "!type!" "1" "!item!"
        )
        exit /b
    )

    rem make diffline and sameline version
    set old=
    set "separator=!brk!"




    set /a same_line=0
    REM echo -------- TYPE "!type!"
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
        

        rem getting items from primary file
        set nest_old=
        set copy=
        rem quantity for the label of the same type
        set /a qty=0


        if exist nested.txt (
            for /f "tokens=1 delims=|" %%i in (nested.txt) do (
                set "nest_old=!nest_old!!brk!%%i"
                set /a qty+=1


                
            )
        )

echo NEST OLD "!nest_old!"
        if "!nest_old!" equ "ECHO is off." (
            set "nest_old="
        )



        rem add temp items to primary file

        set "old=!nest_old!!brk!!old!|"

        if "!nest_old! " equ "!add_space!" (
            set "old=!add_space!"
        )
        echo NEST OLD "!nest_old!"


        echo !old! > nested.txt

        set /a qty+=1
        call :label_list "!type!" "!qty!" "!item!"
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

    set old=
    set copy_=
    set with_brk=
    set /a l_qty=0
    set /a qty=0
    for /f "tokens=1 delims=|" %%i in (!file!) do (
        set "old=!old!!separator!%%i"
        set /a qty+=1
    )
         
   
    
    set "old=!old!!separator!!item!|"
    
    echo !old! > "!file!"


    rem block counter for number of nested lables,
    rem     We determine this quantity when finding open_started label

    rem quantity for the label of the same type
    set /a qty+=1
    if "!type!" neq "NESTED" (
        call :label_list "!type!" "!qty!" "!item!"
    )

    endlocal
exit /b




:label_list
    setlocal

    set "type=%~1"
    set "qty=%~2"
    set "item=%~3"
    
    set "alpha=B"

    if "!type!" equ "INDIV" (
        set "alpha=I"
    )

    if "!type!" equ "NESTED" (
        set "alpha=N"
    )

    set file=positions.txt
    rem echo CODE: !alpha!.!qty!
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