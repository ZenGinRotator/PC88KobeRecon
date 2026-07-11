@ setlocal EnableDelayedExpansion

@ call %*

@ goto :eof


@ rem For brackets & parentheses directories
@ rem 3 layer directory
:empty_check
    

    for /d %%i in ("%~1\*") do (
        
        for /d %%j in ("%%i\*") do (
        
            @ set /a qty=0
        
            for %%k in ("%%j\*") do (
                @ set /a qty+=1
                echo "%%k"
                @ rem pause
            )
            if !qty! equ 0 (
                echo NEED TO REPORT THIS DIRECTORY THAT CONTAINS NO FILES
                pause
                @ call "funcs_no_make.bat" :no_dir_make "%~2"
                @ call "funcs_no_make.bat" :no_file_make "%~2\%%~nxi"
            )
        )
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