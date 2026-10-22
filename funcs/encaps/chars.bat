setlocal EnableDelayedExpansion

call %*

goto :eof


:start_n_ends
    setlocal
    set "name=%~1"
    set "show_out=%~2"
    echo "!brk!" NAME: -- "!name!" ---
   

    if exist first_char.txt ( del first_char.txt )
    if exist last_char.txt ( del last_char.txt )

    set no_output=
    set "show_output=\"
    call "funcs_first_char.bat" :find_first_char "!name!" "!show_out!"
    for /f "tokens=1 delims=|" %%i in (first_char.txt) do (
        set "left=%%i"
        if "!left!" equ "@" (
            set left=
        )
    )

    call "funcs_last_char.bat" :find_last_char "!name!" "!show_out!"
    
    for /f "tokens=1 delims=|" %%i in (last_char.txt) do (
        set "right=%%i"
        if "!right!" equ "@" (
            set right=
        )
    )

    echo **** "!left!" "!right!"

    endlocal
exit /b


:primary_and_optn_chars
    setlocal
    set "right_char=%~1"

    set left_char=

    if "!right_char!" equ "" (
        set "left_char=@"
        set "right_char=@"
        set "optn_one_left=@"
        set "optn_one_right=@"
        set "optn_two_left=@"
        set "optn_two_right=@"
    )

    if "!right_char!" equ ")" (
        set "left_char=("
    
        set "optn_one_left={"
        set "optn_one_right=}"

        set "optn_two_left=["
        set "optn_two_right=]"

    )

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


rem     within the bridge identified by the found last character.
rem Bridge determined by the found last character can either
rem     be a fore-bridge (when finding first character)
rem     or an aft-bridge (when finding the last character)
:optns_in_last_char_bridge
    setlocal

    rem phrase is:
    rem * !fore_bridge! (finding first char), or
    rem * PAD!aft_bridge! (finding last char)
    set "bridge=%~1"

    set "optn1_char=%~2"
    set "optn2_char=%~3"

    set o1_bridge=
    set o2_bridge=
    call ".\funcs\utils.bat" :delim_with_char "1" "!optn1_char!" "!bridge!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "o1_bridge=%%i"
    )

    call ".\funcs\utils.bat" :delim_with_char "1" "!optn2_char!" "!bridge!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "o2_bridge=%%i"
    )

    set /a diff_bridges=0
    if "!o1_bridge!" neq "!bridge!" (
        set /a diff_bridges+=1
    ) 
    if "!o2_bridge!" neq "!bridge!" (
        set /a diff_bridges+=1
    )

    if exist reduced_bridge.txt (
        del reduced_bridge.txt
    )
    set "db=!diff_bridges!|!o1_bridge!|!o2_bridge!|"
    rem echo DB "!db!" bridge "!bridge!"
    echo !db! > reduced_bridge.txt
    endlocal
exit /b