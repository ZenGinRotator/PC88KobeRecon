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
            call :find_last_char "%%j" "\"
        )
    )
    endlocal
exit /b

:find_last_char
    setlocal
    set "phrase=%~1"
    set "echo_verify=%~2"
     
    

    echo ---------------- Phrase "!phrase!" ------------------

    rem Need this to indicate the end of a file (with .cmt, .d88, or .t88 extension)
    rem     or to indicate the end of a bridge
    rem In both instances, we need to find the last character in the name/bridge
    rem Using the end_mark will force the algorithm to yield the end_mark or a bridge
    rem     appearing after the last encapsulating character (with the end_mark included)
    rem     within the file name.

    
    set "end_mark=\"
    set "phrase=!phrase!!end_mark!"
    
    
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

    call :recurse_to_end "1" ")" "!phrase!" "!empty_old_item!"
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

    call :recurse_to_end "1" "}" "!read_item!" "!empty_old_item!"

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




    call :recurse_to_end "1" "]" "!read_item!" "!empty_old_item!"
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
        echo "!last_char!"
        exit /b
    )





    set "last_char=)"
    set "last_bridge=!p_bridge!"
    set "old_bridge=!c_bridge!"
    set "last_token=!p_token!"
    call :recurse_to_end "1" "}" "!p_bridge!" "!empty_old_item!"
    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "c_bridge=%%i"
    )

    if "!c_bridge!" neq "!p_bridge!" (
        set "last_char=}"
        set "last_bridge=!old_bridge!"
        set "last_token=!c_token!"
    )

    set "old_bridge=!s_bridge!"
    call :recurse_to_end "1" "]" "!last_bridge!" "!emtpy_old_item!"
    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "s_bridge=%%i"
    )

    if "!s_bridge!" neq "!last_bridge!" (
        set "last_char=]"
        set "last_bridge=!s_bridge!"
        set "last_token=!s_token!"
    )



    CALL :verify_3 "!phrase!" "!last_char!" "!last_bridge!" "!end_mark!" "!echo_verify!"
    

    endlocal
exit /b


:verify_3
    setlocal
    set "phrase=%~1"
    set "last_char=%~2"
    set "last_bridge=%~3"
    set "end_mark=%~4"
    set "echo_verify=%~5"

   
    rem Collecting option chars
    set o1_right=
    set o2_right=

    call :primary_and_optn_chars "!last_char!"
    for /f "tokens=4 delims=|" %%i in (chars.txt) do (
        set "o1_right=%%i"
    )
    
    for /f "tokens=6 delims=|" %%i in (chars.txt) do (
        set "o2_right=%%i"
    )
    rem Collecting tests for option characters
    set test_o1_r=
    set test_o2_r=
    set "pad_last_brdg=PAD!last_bridge!"


    call "funcs_rom_keywords.bat" :delim_with_char "1" "!o1_right!" "!pad_last_brdg!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "test_o1_r=%%i"
    )
    

    call "funcs_rom_keywords.bat" :delim_with_char "1" "!o2_right!" "!pad_last_brdg!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "test_o2_r=%%i"
    )

    set /a eqty=0

    if "!test_o1_r!" neq "!pad_last_brdg!" (
        set /a eqty+=1
    )
    if "!test_o2_r!" neq "!pad_last_brdg!" (
        set /a eqty+=1
    )

    if "!eqty!" neq "0" (
        if "!echo_verify!" neq "" (
            call :out_fail "!last_char!"
        )
        PAUSE
        EXIT /B
    )
  

    set "los=!last_char!|!o1_right!|!o2_right!"
    set "lasts=!last_bridge!|!pad_last_brdg!"
    set "tests=!test_o1_r!|!test_o2_r!"

    set "ops=!los!|!lasts!|!tests!"
   

    if "!echo_verify!" neq "" (
        call :out_pass "!ops!"
    )
    
    endlocal
exit /b

:out_fail
    setlocal
    set "last=%~1"

    echo LAST CHAR TEST: FAIL 
    echo "!last!": WRONG LAST CHAR

    endlocal
exit /b

:out_pass
    setlocal
    set "ops=%~1"

    set last_char=
    set o1_right_chr=
    set o2_right_chr=
    set bridge=%~4
    set pad_bridge=
    set test_o1R=
    set test_o2R=
    for /f "tokens=1 delims=|" %%i in ("!ops!") do (
        set "last_char=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!ops!") do (
        set "o1_right_chr=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!ops!") do (
        set "o2_right_chr=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!ops!") do (
        set "bridge=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("!ops!") do (
        set "pad_bridge=%%i"
    )
    for /f "tokens=6 delims=|" %%i in ("!ops!") do (
        set "test_o1R=%%i"
    )
    for /f "tokens=7 delims=|" %%i in ("!ops!") do (
        set "test_o2R=%%i"
    )


    echo LAST CHAR TEST: PASS (CORRECT LAST CHAR)
    echo LAST CHAR: "!last_char!"
    echo OPTION 1 RIGHT: "!o1_right_chr!"
    echo OPTION 2 RIGHT: "!o2_right_chr!"
    echo LAST BRIDGE: "!bridge!"
    echo PAD LAST BRIDGE: "!pad_bridge!"
    echo TEST OPTION 1 RESULT: "!test_o1R!"
    ECHO test OPTION 2 RESULT: "!test_o2R!"
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
    call :recurse_to_end "!token!" "!right_c!" "!phrase!" "!item!" 
    endlocal
exit /b

