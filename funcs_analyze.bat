@ setlocal EnableDelayedExpansion
@ set brk=^



@ call %*

@ goto :eof


@ rem For brackets & parentheses directories
@ rem 3 layer directory
:empty_check
    set list=
    

    if not exist "nums.txt" (
        
        @ set "list=!brk!       DIRECTORY                  # OF FILES              GREATER THAN ZERO        STATUS!brk!"
    ) else (
        for /f "tokens=*" %%i in (nums.txt) do (
            set "list=!list!!brk!%%i"
        )
    )
    
    
    @ rem %~1 = X_BRACKETS OR PARENTHESES
    for /d %%i in ("%~1\*") do (
        @ set /a empty_qty=0
        @ set "list=!brk!!list!%~1\%%~nxi"
        @ set "gtz=NO"
        @ set "pass=FAIL"

        
        @ REM i = FILE OR DIR
        for /d %%j in ("%%i\*") do (

       
          
            @ set /a item_qty=0
            @ set file=


            @ set "src=%~1"
            @ set "type=%%~nxi"
            @ set "encaps_wrd=%%~nxj"
            @ rem set "file_name=%%~nxk"

            @ rem this is the item to list within ERRORS directory
            @ set "err_item=!src!_!type!_!encaps_wrd!"

          

            @ rem J = encapsulated word
            for %%k in ("%%j\*") do (
                @ set /a qty+=1
            )

            if !qty! equ 0 (
                @ call "funcs_no_make.bat" :no_dir_make "%~2"
                @ call "funcs_no_make.bat" :no_file_make "%~2\!err_item!"
                set "list=!list!           !empty_qty!         !gtz!       !pass!"
                exit /b
            )

            @ set /a empty_qty=!qty!
            
            set "gtz=YES"
            set "pass=PASS"
            
   
        )
        set "line=           !empty_qty!                  !gtz!             !pass!!brk!"
        set "list=!list!!line!"
        echo !list! > "nums.txt"
    )


exit /b

@ rem For every item in the argumented directory
@ rem ... use the item to lookup that item in src directory
@ rem ... then remove the underscore from the name of that item
@ rem ... within the src directory.
:underscore_dir
    for %%i in ("%~2\*") do (
        @ call :remove "%~1" "" "%%~nxi" "\"
    )

exit /b

:underscore_file
    for /d %%i in ("%~2\*") do (
        for %%j in ("%%i\*") do (
    
            @ call :remove "%~1" "%%~nxi\" "%%~nxj" ""
        )
    )
exit /b



@ rem Remove underscore line from name of directory or file
:remove
   
    @ set "path=%~1\%~2%~3%~4"
    
    
    @ rem If underscored title (of dir or file) does not exist in the src directory, 
    @ rem ... then exit.
    if not exist "!path!" (
        exit /b
    )


    @ set first=
    @ set last=
    for /f "tokens=1 delims=_" %%i in ("%~3") do (
        @ set "first=%%i"
    )
    for /f "tokens=2 delims=_" %%i in ("%~3") do (
        @ set "last=%%i"
    )

    @ rem If no underscores in the title, then exit
    if "!first! !last!" equ "%~3" (
        exit /b
    )

   
    @ ren "!path!" "!first! !last!"
   

exit /b