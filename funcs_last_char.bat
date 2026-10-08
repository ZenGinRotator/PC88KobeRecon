set delimtxt=delimited.txt
set brk=^



call %*

goto :eof






rem SAMPLE_FILE_NAMES_INDIV_START\*
:exe
    setlocal
    echo EXE
    set /a q=0
    for %%i in ("SAMPLE_FILE_NAMES_PRIME\*") do (
        REM echo "%%i"
        set itm=
        set /a q+=1
        echo "!brk!"
        echo !q!
        for /f "tokens=2 delims=\" %%j in ("%%i") do (
            echo "%%j"
            rem call "funcs_first_char.bat" :find_first_char "%%j" ""
            call :find_last_char "%%j"
        )
    )
    endlocal
exit /b

:find_last_char
    setlocal
    set "phrase=%~1"

    echo ---------------- Phrase "!phrase!" ------------------

    rem Need this to indicate the end of a file (with .cmt, .d88, or .t88 extension)
    rem     or to indicate the end of a bridge
    rem In both instances, we need to find the last character in the name/bridge
    rem Using the end_mark will force the algorithm to yield the end_mark or a bridge
    rem     appearing after the last encapsulating character (with the end_mark included)
    rem     within the file name.

    
    set "end_mark=\"
    set "phrase=!phrase!!end_mark!"
    rem set "phrase=!phrase!"
    
    
    
    rem Delete file from previous run of the algorithm
    if exist old_item.txt ( del old_item.txt )
    if exist token.txt ( del token.txt )


    rem Assume ")" is the last character in the file name

    rem These will be token values for identifying the last
    rem     item within the file name when using
    rem     parentheses, square and/or curly brackets.
    set /a p_token=0
    set /a c_token=0
    set /a s_token=0

    rem These will be used to store bridges (non-encapsulated text) that 
    rem appear after the last character in the file name.
    set p_bridge=
    set c_bridge=
    set s_bridge=

    set read_item=
    set last_char=
    set empty_old_item=

    call :recurse_to_end "1" ")" "!phrase!" "!empty_old_item!" "!end_mark!"
    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "read_item=%%i"
    )

    for /f "tokens=1 delims=|" %%i in (token.txt) do (
        set /a p_token=%%i
    )

    if exist token.txt ( del token.txt )


    set "p_bridge=!read_item!"
    set /a empty=0
    if "!p_bridge!" equ "!phrase!" (
        set /a empty+=1
    )



rem item no. 48 has incorrect classification of last character because
rem a bridge proceeds after the last encapsulator

    call :recurse_to_end "1" "}" "!read_item!" "!empty_old_item!" "!end_mark!"

    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "read_item=%%i"
    )
    for /f "tokens=1 delims=|" %%i in (token.txt) do (
        set /a c_token=%%i
    )

    if exist token.txt ( del token.txt )


    set "c_bridge=!read_item!"
    if "!c_bridge!" equ "!phrase!" (
        set /a empty+=1
    )




    call :recurse_to_end "1" "]" "!read_item!" "!empty_old_item!" "!end_mark!"
    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "read_item=%%i"
    )

    for /f "tokens=1 delims=|" %%i in (token.txt) do (
        set /a s_token=%%i
    )

    if exist token.txt ( del token.txt )
   

    set "s_bridge=!read_item!"
    if "!s_bridge!" equ "!phrase!" (
        set /a empty+=1
    )

    if "!empty!" equ "3" (
        echo NONE 
        exit /b
    )





    set "last_char=)"
    set "last_bridge=!p_bridge!"
    set "old_bridge=!c_bridge!"
    set "last_token=!p_token!"
    call :recurse_to_end "1" "}" "!p_bridge!" "!empty_old_item!" "!end_mark!"
    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "c_bridge=%%i"
    )

    if "!c_bridge!" neq "!p_bridge!" (
        set "last_char=}"
        set "last_bridge=!old_bridge!"
        set "last_token=!c_token!"
    )

    set "old_bridge=!s_bridge!"
    call :recurse_to_end "1" "]" "!last_bridge!" "!emtpy_old_item!" "!end_mark!"
    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "s_bridge=%%i"
    )

    if "!s_bridge!" neq "!last_bridge!" (
        set "last_char=]"
        set "last_bridge=!s_bridge!"
        set "last_token=!s_token!"
    )


    echo LAST char "!last_char!"
    echo Last bridge "!last_bridge!"
    echo LAST TOKEN "!last_token!"
    CALL :verify_3 "!phrase!" "!last_char!" "!last_bridge!" "!last_token!" "!end_mark!"
    

    endlocal
exit /b


:verify_3
    setlocal
    set "phrase=%~1"
    set "last_char=%~2"
    set "last_bridge=%~3"
    set "last_token=%~4"
    set "end_mark=%~5"


    call :primary_and_optn_chars "!last_char!"

    rem collects primary encapsulators and option 1 and 2 encapsulators
    
    rem Option chars
    set o1_right=
    set o2_right=

   
    for /f "tokens=4 delims=|" %%i in (chars.txt) do (
        set "o1_right=%%i"
    )
    
    for /f "tokens=6 delims=|" %%i in (chars.txt) do (
        set "o2_right=%%i"
    )


    set o1_right_t=
    set o2_right_t=
    call "funcs_rom_keywords.bat" :delim_with_char "1" "!o1_right!" "PAD!last_bridge!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "o1_right_t=%%i"
    )
    

    call "funcs_rom_keywords.bat" :delim_with_char "1" "!o2_right!" "PAD!last_bridge!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "o2_right_t=%%i"
    )

    set /a eqty=0

    if "!o1_right_t!" neq "PAD!last_bridge!" (
        set /a eqty+=1
    )
    if "!o2_right_t!" neq "PAD!last_bridge!" (
        set /a eqty+=1
    )

    if "!eqty!" neq "0" (
        echo LAST CHAR, FAIL, DIFF LAST CHAR
        PAUSE
        EXIT /B
    )
    ECHO LAST CHAR "!last_char!" --- PASS
    echo O1 RIGHT "!o1_right!" 
    ECHO O2 RIGHT "!o2_right!"
    echo LAST BRIDGE     "!last_bridge!"
    echo PAD LAST BRIDGE "PAD!last_bridge!"
    echo O1_RIGHT_T      "!o1_right_t!"
    echo 02_RIGHT_T      "!o2_right_t!"


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



:recurse_to_end
    setlocal
    set "token=%~1"
    set "right_c=%~2"
    set "phrase=%~3"
    set "old_item=%~4"
    set "end_mark=%~5"

    rem Possibly a stopping point for a file name without an encapsulating character.
    rem if "!phrase!" equ "" (
     rem    exit /b
    rem )

    set item=
    call "funcs_rom_keywords.bat" :delim_with_char "!token!" "!right_c!" "!phrase!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )
     


    if "!item!" equ " " (
        set "old_item=!old_item!|"
        echo !old_item! > "old_item.txt"
        set /a temp=!token!-1
        echo !temp! > "token.txt"
        exit /b
    )
     



    set /a token+=1
    call :recurse_to_end "!token!" "!right_c!" "!phrase!" "!item!" "!end_mark!"
    endlocal
exit /b

