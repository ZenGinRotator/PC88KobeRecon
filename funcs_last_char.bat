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


rem ------------------------ Procedure -------------------------
rem Significant events of the algorithm:
rem 1. Attempt to recursively delimit the text of a file name using a pre-selected character, and the if 
rem     the portion of the file name is different than original text from the file name, 
rem     then the previously selected delimiting character exists within the file name.

rem 2. Designate an end-of-file-name character and append that character to the end of the 
rem     file name, which forces the algorithm to retrieve the last portion of the file name
rem     that appear after the end-of-file-name character, but possibly also includes portions
rem      of the file name that appear after the incorrectly chosen end-of-file-name character.


rem ---------------------- Algorithm -----------------------
rem     1. Choose 1 of 3 possible delimiting characters and use that character to recurse across
rem         the text of the file name to retrieve the portion of the file name that appears after the last
rem         instance of the selected delimiting character.

rem         a. If this portion of the file name is different than the original file name,
rem             * then the delimiting character exists within the file name,

rem         b. If this portion of the file name is the same as the original file name,
rem             * then the delimiting character does not exist within the file name
rem             * then increment a no encapsulator counter by 1

rem     2. Choose the 2nd of 3 possible limiting characters and use that character to recurse
rem         across the 1st end-portion of the file name, and retrieve the inner portion of that 
rem         1st end-portion, the latter of which appears after the last instance of the 1st chosen
rem         delimiting character within the file name,

rem         a. If this portion of the file name is different than the 2nd end-portion of file name,
rem             *then the 2nd delimiting character exists within the file name,

rem         b. If this portion of the file name is the same as the original file name,
rem             * then the delimiting character does not exist within the file name
rem             * then increment a no encapsulator counter by 1

rem     3. Choose the last of 3 possible limiting characters and use that character to recurse
rem         across the 2nd end-portion of the file name, and retrieve the inner-inner portion
rem         of the 1st end-portion, the latter of which appears after the last instance
rem         of the 1st chosen delimiting character within the file name.

rem         a. If this portion of the file name is different than the 3rd end-portion of file name,
rem             * then the 3rd delimiting character exists within the file name.

rem         b. If this portion of the file name is the same as the original file name,
rem             * then the delimiting character does not exist within the file name
rem             * then increment a no encapsulator counter by 1



rem     4. If the no encapsulator counter = 3
rem         * then the file name does not contain any of the 3 encapsulating characters
rem         * exit the function
rem     name is different than the file name, then that difference implies that the 
rem     delimiting character exists within the file name.

rem     5. The file name contains at least 1 of the 3 avaialble encapsulating characters, but
rem         we do not know which one of these characters is the last encapsuulating character.

rem     6. We have 3 portions of the end of file name, each of which corresponds
rem         to one of the 3 encapsulating characters previously used to recurse to the end of
rem         of the file name.

rem     7. Pick one of the 3 encapsulating characters and its corresponding portion to use as
rem         a starting point for determining which of the 3 characters is the last encapsulating
rem         character.

rem     8. Assume that your picked character is the last encapsulating character of the file name,
rem         and assume that its portion might contain one of the remaining 2 encapsulating characters
rem         from the file name.

rem     9. Use the 2nd encapsulating character to recurse across this portion of the file name 
rem         corresponding to the usage of the 1st character on  the file name.

rem         a. If resulting portion of the 1st recursed-end portion of the file name is smaller than
rem             than the 1st recursed end-portion of the file name
rem             * This smaller portion becomes the "newest" portion to use for the next recursive step.
rem             * then the 2nd character appears after the (assumed) 1st character in the file name
rem                 and could be the last character in the file name

rem         b. If this smaller portion  is the same as the 1st end portion of the file name,
rem             * then the 2nd character is not the last character, and the 1st character is possibly 
rem                 the last character in the file name


rem     10. Use the last of the 3 encapsulating characters to recurse across the "smallest"
rem         end portion of the file name 

rem         a. If this portion of the "smallest" portion of the file name (3rd end-portion) is
rem             smaller than the "smallest" end-portion of the file name,
rem             * then the 3rd encapsulating character appears after the  2nd encapsulating
rem                 characters within the file name (is the last character)

rem         b. If this smaller of the 2nd end-portion of the file name is the same as the
rem             "smallest" end-portion of the file name
rem             * then the 3rd last character is not the last character of the file name and the
rem                 the 1st or 2nd character is the last character of the file name







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


    if exist token.txt ( del token.txt )


    set "p_bridge=!read_item!"
    set /a empty=0
    if "!p_bridge!" equ "!phrase!" (
        set /a empty+=1
    )




    call :recurse_to_end "1" "}" "!read_item!" "!empty_old_item!"

    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "read_item=%%i"
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


    if exist token.txt ( del token.txt )
   

    set "s_bridge=!read_item!"
    if "!s_bridge!" equ "!phrase!" (
        set /a empty+=1
    )

    if "!empty!" equ "3" (
        echo NONE 
        echo !last_char!
        rem return the empty last char
        rem emtpy char = ECHO is off.
        rem set "last_char=!last_char!|"
        echo !last_char! > last_char.txt
        exit /b
    )


    rem Assuming the last encapsulating character within the file name
    set "last_char=)"
    set "last_bridge=!p_bridge!"
    set "old_bridge=!c_bridge!"
    call :recurse_to_end "1" "}" "!p_bridge!" "!empty_old_item!"
    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "c_bridge=%%i"
    )

    if "!c_bridge!" neq "!p_bridge!" (
        set "last_char=}"
        set "last_bridge=!old_bridge!"
    )

    set "old_bridge=!s_bridge!"
    call :recurse_to_end "1" "]" "!last_bridge!" "!emtpy_old_item!"
    for /f "tokens=1 delims=|" %%i in (old_item.txt) do (
        set "s_bridge=%%i"
    )

    if "!s_bridge!" neq "!last_bridge!" (
        set "last_char=]"
        set "last_bridge=!s_bridge!"
    )



    CALL :verify_last_bridge "!phrase!" "!last_char!" "!last_bridge!" "!end_mark!" "!echo_verify!"
    

    endlocal
exit /b

rem Compare the bridge from the found last character, with the bridges 
rem     found with the optional characters

:verify_last_bridge
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
    set o1_bridge=
    set o2_bridge=
    set "pad_last_brdg=PAD!last_bridge!"


    call "funcs_rom_keywords.bat" :delim_with_char "1" "!o1_right!" "!pad_last_brdg!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "o1_bridge=%%i"
    )
    

    call "funcs_rom_keywords.bat" :delim_with_char "1" "!o2_right!" "!pad_last_brdg!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "o2_bridge=%%i"
    )

    
    
    rem primary bridge vs. each optional bridge
    set /a eqty=0

    if "!o1_bridge!" neq "!pad_last_brdg!" (
        set /a eqty+=1
    )
    if "!o2_bridge!" neq "!pad_last_brdg!" (
        set /a eqty+=1
    )






    set "los=!last_char!|!o1_right!|!o2_right!"
    set "lasts=!last_bridge!|!pad_last_brdg!"
    set "o_bridges=!o1_bridge!|!o2_bridge!"

    set "ops=!los!|!lasts!|!o_bridges!"

    set "last_chr_func=L"
    if "!eqty!" neq "0" (
        set fail=
        if "!echo_verify!" neq "" (
            call :out "!ops!" "!last_chr_func!" "!fail!"
        )

        rem return error
        PAUSE
        set "last_char=-!last_char!|"
        echo !last_char! > last_char.txt
        EXIT /B
    )
  

   
    set "pass=p"
    if "!echo_verify!" neq "" (
        call :out "!ops!" "!last_chr_func!" "!pass!"
    )

    set "last_char=!last_char!|"
    echo !last_char! > last_char.txt

    rem return the last char
    
    endlocal
exit /b


:out
    setlocal
    set "ops=%~1"
    set "char_type=%~2"
    set "pass_type=%~3"
   

    set last_char=
    set o1_right_chr=
    set o2_right_chr=
    set bridge=%~4
    set pad_bridge=
    rem set test_o1R=
    set o1_bridge=
    set o2_bridge=
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
        set "o1_bridge=%%i"
    )
    for /f "tokens=7 delims=|" %%i in ("!ops!") do (
        set "o2_bridge=%%i"
    )

    set "char_label=LAST"
    set "directn_type=RIGHT"

    if "!char_type!" neq "L" (
        set "char_label=FIRST"
        set "directn_type=LEFT"
    )

    set "is_fail=FAIL"
    set "is_incorr=WRONG"
    if "!pass_type!" equ "p" (
        set "is_fail=PASS"
        set "is_incorr=CORRECT"
    )

    rem ARGUMENTS: FIRST/LAST, LEFT/RIGHT
    rem arguements: PASS/FAIL, CORRECT/INCORRECT
    set "char_prompt=!char_label! CHAR TEST: !is_fail! (!is_incorr! !char_label! CHAR)"
    echo "!char_prompt!"
    
    
    set "char_type_prompt=!char_label! CHAR: !last_char!"
    echo "!char_type_prompt!"


    set "o1=OPTION 1 !directn_type!: !o1_right_chr!"
    echo "!o1!"


    set "o2=OPTION 2 !directn_type!: !o2_right_chr!"
    echo "!o2!"


    set "lst_b=!char_label! BRIDGE: !bridge!"
    echo "!lst_b!"

    set "lst_pb=PAD !char_label! BRIDGE: !pad_bridge!"
    echo "!lst_pb!"


    set "o1_b=OPTION 1 BRIDGE: !o1_bridge!"
    echo "!o1_b!"
    
    set "o2_b=OPTION 2 BRIDGE: !o2_bridge!"
    echo "!o2_b!"


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

