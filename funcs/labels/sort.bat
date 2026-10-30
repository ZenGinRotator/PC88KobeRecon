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

    rem partially or fully encapsulated label, OR BRIDGE
    set "item=%~1"

    rem type= BRIDGE, INDIV, or NESTED
    set "type=%~2"

    rem open-started OPN_STRTD, open-ended OPN_ENDD, closed, BRDG?
    set "format=%~3"
    rem set "item=%~4"
    
    

    rem Block an item=" " in situations such as:
    rem Two neighboring closed labels, that are both indiv labels: (label 1)<space>(label 2)
    rem     and item=" " is a bridge, because we don't want 
    rem     to write item (" ") to bridges.txt file

   rem exclude bridges having only 1 or more spaces,
    REM     but save those single spaces in between pair of
    rem     neighboring, nested labels
    set "append=!item!"
    set test=
    set "orig_item=!item!"
    rem echo APPEND "!append!"
    rem echo test from APPEND "!test!"
    
    call ".\funcs\utils.bat" :delim_with_char "1" " " "!append!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "test=%%i"
        rem echo TEST "!test!"
    )

    set /a is_bridge=0
    set /a blank_qty=0
    call ".\funcs\utils.bat" :delim_with_char "1" " " "!item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        rem set "test=%%i"
        rem echo TEST2 "!test2!"
        if "%%i" NEQ " " (
            SET /A is_bridge+=1
        )
        if "%%i" equ " " (
            set /a blank_qty+=1            
        )
    )
    call ".\funcs\utils.bat" :delim_with_char "2" " " "!item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        rem set "test=%%i"
        rem echo TEST2 "!test2!"
        if "%%i" neq " " (
            set /a is_bridge+=1
        )
        if "%%i" equ " " (
            set /a blank_qty+=1            
        )


    )

    SET "is_blank="

    if "!blank_qty!" equ "2" (
        set "is_blank=T"
        echo IS BLANK
        echo ORIG_ITEM "!orig_item!" "!type!" "!format!"
    )

    rem Need to exclude  bridges that need future recursion using DOIR# & DOIL#
    rem I might have an existing function that can be used to identify bridges matching these characteristics.
    set file=bridges.txt


   
    REM if "!type!" equ "2" (
    if "!type!" equ "INDIV" (
        set file=indivs.txt
    )


    if "!type!" equ "NESTED" (
        rem set file=nested.txt
        set file=nested_line.txt
    )


    if "!is_blank!" neq "" (
        set file=spaces.txt
    )

    


    rem echo FFFFIIIIILLLLLEEEEEEE "!file!"
    rem test can equal " " when:
    
    rem token=2, then token=1, delims=" "
    rem                     2
    rem     bridge = " A BRIDGE WITH SPACE\"

    rem     bridge = "BRIDGE with space \"
    rem     bridge = " BRIDGE WITH SPACE\"
    rem     bridge = " BRIDGE WITH SPACE \"

    rem                 2= " ", 1=BRIDGE
    REM     bridge = "BRIDGE\"
    rem     bridge = " BRIDGE\"
    rem     bridge = "BRIDGE \"
    REM     bridge = " BRIDGE \"

    rem     bridge = " ", "     ", or something else?
   
   
    
    set "item=#!item!|"

    if "!type!" equ "NESTED" (
        rem set "item=|!orig_item!#"
        
        rem OPN_ENDD
        if "!format!" equ "OPN_ENDD" (
            set "item=#!orig_item!|"
        )
        
        REM CLSD
        if "!format!" equ "CLSD" (
            set "item=!orig_item!|"
        )

        rem OPN_STRTD
        if "!format!" equ "OPN_STRTD" (
            set "item=!orig_item!#"
        )

        if "!is_blank!" neq "" (
            set file=nested_line.txt
        )

    )


        if "!is_blank!" neq "" (
            set "item=!orig_item!|"
            if not exist is_nested.txt (
                set "item=#!item!"
            )
        )
        rem BRDG

    echo ****** "!item!" into FILE "!file!"
    rem file could exist

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

    rem make diffline and sameline version
    set old=
    set "separator=!brk!"

    set /a same_line=0
  
  
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
         
   
    
    set "old=!old!!separator!!item!"
    echo SEPARATOR: "!separator!"
    echo FILE : !file!
    echo OLD: "!old!"
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
    rem echo "LABLE LIST ITEM" "!item!" "!type!" "!is_blank!"
    if "!is_blank!" neq "" (
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
    if "!alpha!" equ "S" (
REM echo OLD "!old!"
    )
    echo Positions: OLD 
    echo "!old!"
    
    rem echo end of old
    echo !old! > !file!
    

    endlocal
exit /b