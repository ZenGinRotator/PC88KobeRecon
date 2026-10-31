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
rem inverted.txt

rem is_nested
rem labels
rem last_char.txt
rem longest_encaps_words.txt
rem name.txt
rem nested.txt
rem nums.txt
rem old_item.txt
rem ones.txt
rem optn_bridges.txt
rem reduced_bridge.txt
rem return.txt
rem sec_qty
rem sec_largest_qty
rem struct.txt

rem third_qty
rem third_largest_qty
rem three.txt
rem token.txt
rem type.txt
