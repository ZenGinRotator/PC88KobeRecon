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