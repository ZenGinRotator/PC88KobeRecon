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
set brk=^




call %*

goto :eof



:delim_with_char
    setlocal
    rem %~1: token
    rem %~2: delim char 
    rem (eg. [, (, {, ], ), or })
    set "phrase=%~3"
     rem echo ---- DELIMITING "%~3"---- with "%~1" and "%~2"
    set d=
    for /f "tokens=%~1 delims=%~2" %%i in ("!phrase!") do (
        set "d=%%i"
    )

    set "d=!d!|"
    echo !d! > "%delimtxt%"
    endlocal
exit /b





rem Function to determine if any optional characters exist


:print
    setlocal
    echo HELLO WORLD
    endlocal
exit /b




rem bridge.txt
rem bridges.txt
rem change.txt
rem chars.txt
rem construct.txt
rem disk.txt
rem ef
rem encap.txt
rem ext_qty
rem fg
rem first_char.txt
rem first_qty
rem first_largest_qty
rem format.txt
REM indivs.txt INDVS
rem inverted.txt

rem is_nested
rem labels
rem last_char.txt
rem longest_encaps_words.txt
rem name.txt
rem nested.txt  "NESTED", NSTD
rem nested_line.txt "NSTD_LN"
rem nums.txt
rem old_item.txt
rem ones.txt
rem optn_bridges.txt
rem reduced_bridge.txt
rem return.txt
rem sec_qty
rem sec_largest_qty
rem spaces.txt SPCS
rem struct.txt

rem third_qty
rem third_largest_qty
rem three.txt
rem token.txt
rem type.txt


:content
    setlocal
    set "code=%~1"
    set "separator=%~2"
    rem echo SEPARATOR "!separator!"

    set "flag="
    rem set "separator_=!separator!"
    if "!separator!" equ "\" (
        set "separator=!brk!"
        set "flag=T"


    )

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

    if exist return.txt ( del return.txt )
    if exist return_qty.txt ( del return_qty.txt )

    set /a qty=0
    set "old="
    if exist !file! (
    for /f "tokens=1 delims=|" %%i in (!file!) do (
        set "old=!old!%%i"
        rem echo ****** "%%i"
        set /a qty+=1
    )
    )

    rem if "!flag!" neq "T" (
set "old=!old!|"
    rem )
    echo OLD "!old!"
    REM echo wrtingin "!old!"
    echo !old! > return.txt

    set "qty=!qty!|"
    echo !qty! > return_qty.txt
    
    
    endlocal
exit /b


:list_n_qty
    setlocal

    rem delete the return.txt file
    if exist return.txt ( del return.txt )

    rem call listify
    call :recurse_listify "1" "&" 

    endlocal
exit /b




:recurse_listify
    setlocal

    set "token=%~1"
    set "delim_chr=%~2"
    set "whole_str=%~3"

    set "item="
    rem delim char, set item
    call :delim_with_char "!token!" "!delim_chr!" "!whole_str!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )

    if "!item!" equ " " (
        
        
        
        exit /b
    )
    rem stop condition, item=" "

    set "d="
    rem if exist return_.txt ( del return.txt
    for /f "tokens=*" %%i in (return.txt) do (
        set "d=!d!%%i!brk!"
    )
    rem )


     set "d=!d!!item!"
    

    rem add the token to output before writing to file
    echo !d! > return_.txt

    set /a token+=1
    call :listify "!token!" "!delim_chr!" "!whole_str!"

    endlocal
exit /b


:compare_n_pause
    setlocal

        set "text=%~1"
        set "first=%~2"
        set "sec=%~3"

        if "!first!" neq "!sec!" (
            echo ERROR: !text! MISMATCH: 
            ECHO FIRST "!first!"
            echo SECND "!sec!"
        )

    endlocal
exit /b