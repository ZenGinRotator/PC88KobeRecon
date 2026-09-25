set delimtxt=delimited.txt
set brk=^



call %*

goto :eof



:find_last_delim_char
    setlocal
    rem set "left_char=%~1"
    set "right_char=%~1"
    set "name=%~2"
    rem set "optn_one_left=%~4"
    set "optn_one_right=%~3"
    rem set "optn_two_left=%~6"
    set "optn_two_right=%~4"

    
    set primary_item=
    call :recurse_to_ext "1" "!right_char!" "!name!" ""
    for /f "tokens=1 delims=|" %%i in (last_item.txt) do (
        set "primary_item=%%i"
    )
    
    call :parse_item_with_ext "!primary_item!" "!right_char!" "!optn_one_right!" "!optn_two_right!" "!name!"

    if exist has_paren.txt (
        exit /b
    )
    del last_item.txt
    
    
    
    set secondary_item=
    call :recurse_to_ext "1" "!optn_one_right!" "!primary_item!" ""
    for /f "tokens=1 delims=|" %%i in (last_item.txt) do (
        set "secondary_item=%%i"
    )

    call :parse_item_with_ext "!secondary_item!" "!optn_one_right!" "!optn_two_right!" "!right_char!" "!name!"
    if exist has_curl.txt (
        exit /b
    )
    del last_item.txt
    
    set tertiary_item=
    call :recurse_to_ext "1" "!optn_two_right!" "!secondary_item!" ""
    for /f "tokens=1 delims=|" %%i in (last_item.txt) do (
        set "tertiary_item=%%i"
    )
    
    call :parse_item_with_ext "!tertiary_item!" "!optn_two_right!" "!right_char!" "!optn_one_right!" "!name!"
    if exist has_square.txt (
        exit /b
    )
    del last_item.txt

    endlocal
exit /b



:char_to_barrier_file
    setlocal
    set "right_char=%~1"
    set "name=%~2"

    set hst=has_square.txt
    set hct=has_curl.txt
    set hpt=has_paren.txt

    set file=!hst!

    if "!right_char!" equ "}" (
        set file=!hct!
    )
    if "!right_char!" equ ")" (
        set file=!hpt!
    )

    set item=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!right_char!" "!name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )

    if "!item!" neq "!name!" (
        echo "" > !file!
    )

    endlocal
exit /b


:verify_last_char
    setlocal
    
    set "token=%~1"
    set "right_char=%~2"
    set "!name!=%~3"
    set "old_item=%~4"
    set "phrase=%~5"

    set item=
    call "funcs_rom_keywords.bat" :delim_with_char "!token!" "!right_char!" "!name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )

    if "!item!" equ " " (
        set "result=FAIL"
        if "!phrase!" equ "!old_item!" (
            set "result=PASS"
            REM echo  --- "!result!"
        )
        if "!result!" equ "FAIL" (
            echo !!!!!! FAIL


        )
        exit /b 
    )

    
    set /a token+=1
    call :verify_last_char "!token!" "!right_char!" "!name!" "!item!" "!phrase!"
    endlocal
exit /b


:recurse_to_ext
    setlocal
    set "token=%~1"
    set "right_char=%~2"
    set "name=%~3"
    set "old_item=%~4"
   
   
    set item=
    call "funcs_rom_keywords.bat" :delim_with_char "!token!" "!right_char!" "!name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )


    if "!item!" equ " " (
        set "old_item=!old_item!|"
        echo !old_item! > "last_item.txt"
        exit /b
    )



    set ext=
    call "funcs_rom_keywords.bat" :delim_with_char "2" "." "!item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "ext=%%i"
    )

    set /a ext_qty=0
    call "funcs_rom_keywords.bat" :ext_qty "!ext!"
    for /f "tokens=*" %%i in (ext_qty.txt) do (
        set /a ext_qty=%%i
    )

    set /a token+=1
    call :recurse_to_ext "!token!" "!right_char!" "!name!" "!item!"
    endlocal
exit /b


:parse_item_with_ext
    setlocal
    set "phrase=%~1"
    set "right_char=%~2"
    set "optn_one_right=%~3"
    set "optn_two_right=%~4"
    set "name=%~5"
    


    set opt1=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!optn_one_right!" "!phrase!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "opt1=%%i"
    )


    set opt2=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!optn_two_right!" "!phrase!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "opt2=%%i"
    )

    set /a qty=0
    if "!opt1!" neq "!phrase!" (
        set /a qty+=1
    )
    if "!opt2!" neq "!phrase!" (
        set /a qty+=1
    )

    if !qty! equ 0 (
        
        call :char_to_barrier_file "!right_char!"
        rem echo R "!phrase!" "!r!" "!right_char!" "!name!"
        rem echo Use right_char "!right_char!" to determine option 1 and 2 characters
        if exist "chars.txt" ( del "chars.txt" )
        call :primary_and_optn_chars "!right_char!"

        rem CALLING A FUNCTIONT TO VERIFY CORRECTNESS OF OUR DISCOVERED RIGHT_CHAR
        call :verify_last_char "1" "!right_char!" "!name!" "" "!phrase!"
    )
    
    rem echo PHRASE "!phrase!" RR "!r!" "!right_char!"
    endlocal
exit /b

:primary_and_optn_chars
    setlocal
    set "right_char=%~1"

    set left_char=
    if "!right_char!" equ ")" (
        set "left_char=("
    )

    set "optn_one_left={"
    set "optn_one_right=}"

    set "optn_two_left=["
    set "optn_two_right=]"

    if "!right_char!" equ "}" (
        set "left_char={"
        set "optn_one_left=["
        set "optn_one_right=]"
        set "optn_two_left=("
        set "optn_two_right=)"
    )
    if "!right_char!" equ "]" (
        set "left_char=["
        set "optn_one_left=("
        set "optn_one_right=)"
        set "optn_two_left={"
        set "optn_two_right=}"
    )

    set "prime=!left_char!|!right_char!"
    set "optn1=!optn_one_left!|!optn_one_right!"
    set "optn2=!optn_two_left!|!optn_two_right!"

    set "chars=!prime!|!optn1!|!optn2!|"
    echo !chars! > "chars.txt"

    endlocal
exit /b

:find_last_char
    setlocal
    set "delim_chars=%~1"
    set "phrase=%~2"


    set prime_l=
    set prime_r=
    set optn1_l=
    set optn1_r=
    set optn2_l=
    set optn2_r=
    for /f "tokens=1 delims=|" %%i in ("!delim_chars!") do (
        set "prime_l=%%i"
    )
    for /f "tokens=1 delims=|" %%i in ("!delim_chars!") do (
        set "prime_r=%%i"
    )
    for /f "tokens=1 delims=|" %%i in ("!delim_chars!") do (
        set "optn1_l=%%i"
    )
    for /f "tokens=1 delims=|" %%i in ("!delim_chars!") do (
        set "optn1_r=%%i"
    )
    for /f "tokens=1 delims=|" %%i in ("!delim_chars!") do (
        set "optn2_l=%%i"
    )
    for /f "tokens=1 delims=|" %%i in ("!delim_chars!") do (
        set "optn2_r=%%i"
    )
    REM echo "!brk!" "!brk!" "!brk!" "!brk!" "!brk!" "!brk!" --------------------------------------------NAME "!phrase!"----

    rem Need this to indicate the end of a file (with .cmt, .d88, or .t88 extension)
    rem     or to indicate the end of a bridge
    rem In both instances, we need to find the last character in the name/bridge
    set "end_mark=#"
    set "phrase=!phrase!!end_mark!"
    
    
    
    if exist old_item.txt ( del old_item.txt )




    set read_item=
    set last_char=
    call :recurse_to_end "1" ")" "!phrase!" "" "!end_mark!"
    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "read_item=%%i"
    )

    
    if "!old_item!" neq "!phrase!" (
        set "last_char=)"
    )





    call :recurse_to_end "1" "}" "!read_item!" "" "!end_mark!"
    set "old_item=!read_item!"
    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "read_item=%%i"
    )
    if "!read_item!" neq "!old_item!" (
        set "last_char=}"
    )




    set "old_item=!read_item!"
    call :recurse_to_end "1" "]" "!old_item!" "" "!end_mark!"
    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "read_item=%%i"
    )

    if "!read_item!" neq "!old_item!" (
        set "last_char=]"
    )




    rem showing the last char as output
    rem call :the_last "!last_char!"

    call :verify_lc "1" "!last_char!" "!phrase!" "!end_mark!" ""


    endlocal
exit /b

:verify_lc
    setlocal
    set "token=%~1"
    set "right_c=%~2"
    set "phrase=%~3"
    set "end_mark=%~4"
    SET "old_item=%~5"

    set item=
    call "funcs_rom_keywords.bat" :delim_with_char "!token!" "!right_c!" "!phrase!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )


    set end=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!end_mark!" "PAD!item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "end=%%i"
    )

    rem if "!end!" neq "!item!" (
    rem     echo END "!end!"
    rem )
    

    if "!item!" equ ".d88!end_mark!" (
        echo PASSED LAST CHAR "!right_c!"
        call :primary_and_optn_chars "!right_c!"
        exit /b
    )
    if "!item!" equ "!end_mark!" (
        rem unsure if calling this function is necessary
        call :primary_and_optn_chars "!right_c!"
        echo PASSED LAST CHAR "!right_c!"
        exit /b
    )

    if "!item!" equ " " (
        rem We traversed the entire phrase but need to evaluate whether
        rem     the previous item contains optional delimiting characters
        call :evalOI "!old_item!" "!right_c!"
        exit /b
    )

    set /a token+=1
    call :verify_lc "!token!" "!right_c!" "!phrase!" "!end_mark!" "!item!"

    endlocal
exit /b

:evalOI
    setlocal
    set "old_item=%~1"
    set "right_c=%~2"

    set optn1_r=
    set optn2_r=
    call :primary_and_optn_chars "!right_c!"
    for /f "tokens=4 delims=|" %%i in (chars.txt) do (
        set "optn1_r=%%i"
    )
    for /f "tokens=6 delims=|" %%i in (chars.txt) do (
        set "optn2_r=%%i"
    )

    

    set res1=
    set res2=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!optn1_r!" "!old_item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "res1=%%i"
    )

    call "funcs_rom_keywords.bat" :delim_with_char "1" "!optn2_r!" "!old_item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "res2=%%i"
    )

    set /a q=0

    if "!res1!" equ "!old_item!" (
        rem Returns the entire item when the optional delimiting 
        rem     character does not exist with the item.
        rem An item as defined as a string containing the end-mark 
        rem     character.
        set /a q+=1
    )

    if "!res2!" equ "!old_item!" (
        set /a q+=1
    )

    if !q! equ 2 (
        echo PASS

        call :primary_and_optn_chars "!right_c!"


    ) ELSE (
        ECHO FAIL
        pause
    )

    


    endlocal
exit /b

:the_last
    setlocal
    set "last_char=%~1"
    echo =================================================== LAST CHAR "!last_char!"
    endlocal
exit /b

:recurse_to_end
    setlocal
    set "token=%~1"
    set "right_c=%~2"
    set "phrase=%~3"
    set "old_item=%~4"
    set "end_mark=%~5"

    if "!phrase!" equ "" (
        exit /b
    )

    set item=
    call "funcs_rom_keywords.bat" :delim_with_char "!token!" "!right_c!" "!phrase!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )
     
    rem echo RIGHT_C "!right_c!"
    rem echo OLD ITEM "!old_item!"

    set "oi=!item!"
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!end_mark!" "!item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )
     rem echo OI "!oi!"
     rem echo read ITEM "!item!" 
     rem echo END MARK "!end_mark!"
    if "!item!" neq "!oi!" (
        rem echo NEQ "!right_c!"
        set "item=!item!!end_mark!"
        echo !item! > "old_item.txt"
        exit /b
    )
    

rem    if "!item!" equ " " (
        
  rem      echo BLANK "!right_c!"
     rem   set "old_item=!old_item!|"
       rem echo !old_item! > "old_item.txt"
       rem exit /b
   rem )
    rem if "!item!" equ "!phrase!" (
       
       rem echo PHRASE "!right_c!"
        rem ECHO ITEM IS "!item!"
       rem set "old_item=!item!|"
       rem echo !old_item! > "old_item.txt"
       rem exit /b
   rem )



    set /a token+=1
    call :recurse_to_end "!token!" "!right_c!" "!phrase!" "!item!" "!end_mark!"
    endlocal
exit /b


:exe
    setlocal
    echo EXE
    set /a q=0
    for %%i in ("SAMPLE_FILE_NAMES\*") do (
        REM echo "%%i"
        set itm=
        set /a q+=1
        echo !q!
        for /f "tokens=2 delims=\" %%j in ("%%i") do (
            echo "%%j"
            call :find_last_char "" "%%j"
            
        )
    )
    endlocal
exit /b