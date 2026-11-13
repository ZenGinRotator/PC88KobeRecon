setlocal EnableDelayedExpansion

set hep=has_encaps_pnth.txt
set hec=has_encaps_curl.txt
set hes=has_encaps_sqr.txt

set inp=is_nested_pnth.txt
set inc=is_nested_curl.txt
set ins=is_nested_sqr.txt

set grptxt=group.txt
set delimtxt=delimited.txt
set toktxt=tokens.txt
set encptd=encapsulated.txt
set onstxt=ones.txt
set brgtxt=bridges.txt


call %*
goto :eof


:del_txts
    setlocal
    if exist labels.txt ( del labels.txt)
    if exist nested.txt ( del nested.txt )
    if exist %delimtxt% ( del %delimtxt% )
    if exist %brgtxt% ( del %brgtxt% )
    if exist "is_nested.txt" ( del "is_nested.txt" )
    if exist "is_primary_nested.txt" ( del "is_primary_nested.txt" )
    if exist "is_secondary_nested.txt" ( del "is_secondary_nested.txt" )
    if exist "bridge.txt" ( del "bridge.txt" )
    if exist "has_square.txt" ( del "has_square.txt" )
    if exist "has_curl.txt" ( del "has_curl.txt" )
    if exist "has_paren.txt" ( del "has_paren.txt" )
    if exist "last_item.txt" ( del "last_item.txt" )
    if exist "chars.txt" ( del "chars.txt" )
    if exist nested.txt ( del nested.txt )
    if exist indivs.txt ( del indivs.txt )
    if exist bridges.txt ( del bridges.txt )
    if exist reduced_bridge.txt ( del reduced_bridge.txt )
    if exist first_char.txt ( del first_char.txt )
    if exist last_char.txt ( del last_char.txt )
    if exist construct.txt ( del construct.txt )
    if exist type.txt ( del type.txt )
    if exist struct.txt ( del struct.txt )
    if exist format.txt ( del format.txt )
    if exist token.txt ( del token.txt )
    if exist optn_bridges.txt ( del optn_bridges.txt )
    if exist nested_line.txt ( del nested_line.txt )
    if exist qty.txt ( del qty.txt )
    if exist name.txt ( del name.txt )
    if exist positions.txt ( del positions.txt )
    if exist spaces.txt ( del spaces.txt )
    if exist return.txt ( del return.txt )
    if exist rom.txt ( del rom.txt )
    rem if exist "ERRORS\" (
    rem     call :del_errors "ERRORS" "CHARS" "FIRST"
    rem     call :del_errors "ERRORS" "CHARS" "LAST"
    rem     call :del_errors "ERRORS" "RECONSTRUCT" "REALTIME"
    rem     call :del_errors "ERRORS" "RECONSTRUCT" "BY_LABEL"
    rem     pause
    rem )
    
    endlocal
exit /b


rem ERRORS\CHARS\FIRST
rem ERRORS\CHARS\LAST
rem ERRORS\RECONSTRUCT\BY_LABEL
rem ERRORS\RECONSTRUCT\REALTIME

:del_errors
    setlocal
    set "root=%~1"
    set "parent=%~2"
    set "dir=%~3"

    rem delete individual files in the sub-directory
    set "fpath=!root!\!parent!\!dir!"
    for /d %%i in ("!fpath!\*") do (
        echo I "%%i"
        for %%j in ("%%i\*") do (
            echo ECGI "%%j"
            del "%%j"
        )
        
        rd "%%i"
    )


    rem delete the sub-directory
    set "ppath=!root!\!parent!"
    if exist "!fpath!" (
        ECHO "!fpath!"
        rem rd "!ppath!\!dir!"'
        rd "!fpath!"
    )
    
    if exist "!root!" (
        rem rd "!root!"
    )
    
    rem delete the parent of the sub-directory - keep ERRORS\

    endlocal
exit /b