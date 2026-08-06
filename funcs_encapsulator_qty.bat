setlocal EnableDelayedExpansion

call %*

goto :eof

rem largest values -> max # of encapsulators, 3
rem {}: dir -> 0
rem {}: file -> 0

rem []}: dir -> 0
rem []]: file -> 2

rem (): dir -> 2
rem (): file -> 3





rem                    (1           (2          (3
rem                    ----         ----        -----
rem (x) (y) (z)         x)          y)          z)
rem (x (y) z)           x           y) z)       --

:square
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"

    call :encapsulator_qty "[" "]" "!name!" "!sec_dirs!" "!dest_dir!"
exit /b

:curly
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"

    call :encapsulator_qty "{" "}" "!name!" "!sec_dirs!" "!dest_dir!"
exit /b


:parenth
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"

    call :encapsulator_qty "(" ")" "!name!" "!sec_dirs!" "!dest_dir!"
exit /b


:encapsulator_qty
    set "lft_chr=%~1"
    set "right_chr=%~2"
    set "name=%~3"
    set "sec_dirs=%~4"
    set "dest_dir=%~5"

    rem echo "!lft_chr!" "!name!"
    
    rem pause 
    rem exit /b
    
    set one=
    set two=
    set three=
    set four=
    set five=
    set six=

    set one_nest=
    set two_nest=
    set three_nest=
    set four_nest=
    for /f "tokens=1 delims=%~1" %%i in ("!name!") do (
        set "one=%%i"
    )
    for /f "tokens=2 delims=%~1" %%i in ("!name!") do (
        set "two=%%i"
    )

    for /f "tokens=3 delims=%~1" %%i in ("!name!") do (
        set "three=%%i"
    )
    for /f "tokens=4 delims=%~1" %%i in ("!name!") do (
        set "four=%%i"
    )
    for /f "tokens=5 delims=%~1" %%i in ("!name!") do (
        set "five=%%i"
    )
    for /f "tokens=6 delims=%~1" %%i in ("!name!") do (
        set "six=%%i"
    )

    for /f "tokens=1 delims=%~2" %%i in ("!two!") do (
        set "two_nest=%%i"
    )
    for /f "tokens=1 delims=%~2" %%i in ("!three!") do (
        set "three_nest=%%i"
    )
    for /f "tokens=1 delims=%~2" %%i in ("!four!") do (
        set "four_nest=%%i"
    )

    
    set /a qty=5
    if "!six!" equ "" (
        set /a qty-=1        
    )
    if "!five!" equ "" (
        set /a qty-=1        
    )
    if "!four!" equ "" (
        set /a qty-=1        
    )
    if "!three!" equ "" (
        set /a qty-=1        
    )
    if "!two!" equ "" (
        set /a qty-=1        
    )
    if "!one!" equ "" (
        set /a qty-=1        
    )
   
    set /a file_qty=0


    set larg_qty_txt=largest_qty.txt

    if not exist %~5\!larg_qty_txt! (
        call "funcs_no_make.bat" :file_into_dir "!dest_dir!" "!larg_qty_txt!"
        echo -1 > !dest_dir!\!larg_qty_txt!
    )

    for /f "tokens=*" %%i in (!dest_dir!\!larg_qty_txt!) do (
        set /a file_qty=%%i
    )

   

    if !qty! gtr !file_qty! (
   
        call "funcs_no_make.bat" :file_into_dir "!dest_dir!" "!larg_qty_txt!"
        call "funcs_no_make.bat" :file_into_dir "!dest_dir!" "longest_encaps_words.txt"
        echo !qty! > "!dest_dir!\!larg_qty_txt!"
        echo "%~3" > "!dest_dir!\longest_encaps_words.txt"
        
    )

    rem parse single () pair
    rem Parse double () pair
    rem Parse triple () pair
    call :collect_encapsulator "!left_chr!" "!right_chr!" "!name!" "!sec_dirs!" "!dest_dir!" "!qty!"
exit /b









:collect_encapsulator
    rem echo parse_multi_encaps 1 "%~1"
    set "left_chr=%~1"
    set "right_chr=%~2"
    set "name=%~3"
    set "sec_dirs=%~4"
    set "dest_dir=%~5"
    set "qty=%~6"


    set one=
    set two=
    set three=
    set words=
    for /f "tokens=2 delims=%~1" %%i in ("!name!") do (
        set "one=%%i"
    )
    for /f "tokens=3 delims=%~1" %%i in ("!name!") do (
        set "two=%%i"
    )
    for /f "tokens=4 delims=%~1" %%i in ("!name!") do (
        set "three=%%i"
    )
    set "words=!one!!two!!three!"

    for /f "tokens=1 delims=%~2" %%i in ("!words!") do (
        set "one=%%i"
    )
    for /f "tokens=2 delims=%~2" %%i in ("!words!") do (
        set "two=%%i"
    )
    for /f "tokens=3 delims=%~2" %%i in ("!words!") do (
        set "three=%%i"
    )

    rem Sometimes appends the file extension to the end of 
    rem .... the encapsulated words.
    set "words=!one!!two!!three!"
   
    rem %~4 = quan|singl|doubl|tripl
    set none=
    set singl=
    set doubl=
    set tripl=

    for /f "tokens=2 delims=|" %%i in ("!sec_dirs!") do (
        set "none=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!sec_dirs!") do (
        set "singl=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!sec_dirs!") do (
        set "doubl=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("!sec_dirs!") do (
        set "tripl=%%i"
    )

    rem How to show that we parsed the encapsulated words and
    rem     the original fiile name containing those encapsulated
    rem     words.
    rem file name (encapsulated words)_encapsulated words
    rem echo path file_encapsulated "%~3_!words!" 

    set "path=!dest_dir!\!none!"
    if "!qty!" equ "1" (
        set "path=!dest_dir!\!singl!"
    )
    if "!qty!" equ "2" (
        set "path=!dest_dir!\!doubl!"
    )
    if "!qty!" equ "3" (
        set "path=!dest_dir!\!tripl!"
    )

    call "funcs_no_make.bat" :file_into_dir "!path!" "!name!___!words!____!qty!"

exit /b