@ setlocal EnableDelayedExpansion



@ call %*
@ goto :eof






:list_gen

@ set src=
@ set u_scor=
@ set prnth=
@ set sqr_brkt=
@ set curl_brkt=
@ set exts=
@ set compl=

for /f "tokens=1 delims=|" %%i in ("%~1") do (
    @ set "src=%%i"
)
for /f "tokens=2 delims=|" %%i in ("%~1") do (
    @ set "u_scor=%%i"
)
for /f "tokens=3 delims=|" %%i in ("%~1") do (
    @ set "prnth=%%i"
)
for /f "tokens=4 delims=|" %%i in ("%~1") do (
    @ set "sqr_brkt=%%i"
)
for /f "tokens=5 delims=|" %%i in ("%~1") do (
    @ set "curl_brkt=%%i"
)
for /f "tokens=6 delims=|" %%i in ("%~1") do (
    @ set "exts=%%i"
)
for /f "tokens=7 delims=|" %%i in ("%~1") do (
    @ set "compl=%%i"
)


for /d %%i in ("!src!\*") do (

    rem call :underscores "!u_scor!\DIR" "%%~nxi"
    rem call :parenths "!prnth!\DIR" "%%~nxi"
    rem call :sqr_brackets "!sqr_brkt!\DIR" "%%~nxi"
    rem call :curly_brackets_test "!curl_brkt!\DIR" "%%~nxi"

    rem call :no_encaps_test "%~3\DIR" "%%~nxi"
    rem echo "%%~nxi"


    for %%j in ("%%i\*") do (

       rem call :underscores "!u_scor!\FILE\%%~nxi" "%%~nxj"
       rem call :parenths "!prnth!\FILE" "%%~nxj"
       rem call :sqr_brackets "!sqr_brkt!\FILE" "%%~nxj"
       rem call :curly_brackets "!curl_brkt!\FILE" "%%~nxj"
       rem call :extensions "!exts!\%%~xj" "%%~nxj"
       rem call :completed "!compl!\%%~nxi" "%%~nxj" 
       rem call :no_encaps_test "%~3\FILE" "%%~nxj"
       call :parenth_pair_qty "%%~nxj"
    )

)

@ rem %~2 = LIST_MADE
rem  echo > "%~2"
exit /b

:completed
    @ call "funcs_no_make.bat" :file_into_dir "%~1" "%~2"
exit /b


:underscores

    @ set part=
    for /f "tokens=1 delims=_" %%i in ("%~2") do (
        @ set "part=%%i"
    )

    
    
    @ rem @ goto :eof
    if "%~2" neq "!part!" (
        @ call "funcs_no_make.bat" :file_into_dir "%~1" "%~2"
    )
exit /b



@ rem "path" "title of dir/file"
:parenths
    @ call :encapsulated_word "(" ")" "%~1" "%~2"
exit /b


:curly_brackets
    @ call :encapsulated_word "{" "}" "%~1" "%~2"
exit /b

:sqr_brackets
    @ call :encapsulated_word "[" "]" "%~1" "%~2"
exit /b


rem Portions of this function intended to parse an encapsulated 
rem .... word are going to change after we derive method for
rem ... identifying which file names have the greatest number of
rem ... () pairs in the file name
:encapsulated_word
    
    @ rem a (word)
    @ rem a (word1 word2 ... word N)
    @ rem a (word1 (nested) word2 ...word N)
    @ set uniq=
	@ set wrd_tail=
	@ set wrd=
    @ set nested_tail=
    @ set nested=
	for /f "tokens=2 delims=%~1" %%i in ("%~4") do (
		@ set "wrd_tail=%%i"
	)
	for /f "tokens=1 delims=%~2" %%i in ("!wrd_tail!") do (
		@ set "wrd=%%i"
	)


    for /f "tokens=3 delims=%~1" %%i in ("%~4") do (
        @ set "nested_tail=%%i"
    )

    for /f "tokens=1 delims=%~2" %%i in ("!nested_tail!") do (
        @ set "nested=%%i"
       
    )

    for /f "tokens=2 delims=%~2" %%i in ("!nested_tail!") do (
        @ set "nested=!nested! %%i"
    )

    if "!nested!" neq "" (
        @ set "wrd=!wrd! !nested!"
    )


   
    @ rem This excludes second word beyond the space
    @ rem Remove the last char from word that might be a space character
    @ rem ...To fix error directory is created with a space at the end
    @ rem ... of the title of the directory (cannot delete this using windows 10)
    @ set one=
    @ set two=
    @ set three=
    @ set four=
    @ set five=
    @ set six=
    @ set sevn=
    @ set eight=
    @ set nine=
    @ set ten=
    for /f "tokens=1 delims= " %%i in ("!wrd!") do (
        @ set "one=%%i"
    )

    for /f "tokens=2 delims= " %%i in ("!wrd!") do (
        @ set "two=%%i"
        if "!two!" neq "" (
            @ set "two= !two!"
        )
    )
    for /f "tokens=3 delims= " %%i in ("!wrd!") do (
        @ set "three=%%i"
        if "!three!" neq "" (
            @ set "three= !three!"
        )

    )
    for /f "tokens=4 delims= " %%i in ("!wrd!") do (
        @ set "four=%%i"
        if "!four!" neq "" (
            @ set "four= !four!"
        )

    )
    for /f "tokens=5 delims= " %%i in ("!wrd!") do (
        @ set "five=%%i"
        if "!five!" neq "" (
            @ set "five= !five!"
        )

    )
    for /f "tokens=6 delims= " %%i in ("!wrd!") do (
        @ set "six=%%i"
        if "!six!" neq "" (
            @ set "six= !six!"
        )

    )
    for /f "tokens=7 delims= " %%i in ("!wrd!") do (
        @ set "sevn=%%i"
        if "!sevn!" neq "" (
            @ set "sevn= !sevn!"
        )

    )

    for /f "tokens=8 delims= " %%i in ("!wrd!") do (
        @ set "eight=%%i"
        if "!eight!" neq "" (
            @ set "eight= !eight!"
        )

    )   
    for /f "tokens=9 delims= " %%i in ("!wrd!") do (
        @ set "nine=%%i"
        if "!nine!" neq "" (
            @ set "nine= !nine!"
        )

    )
    for /f "tokens=7 delims= " %%i in ("!wrd!") do (
        @ set "ten=%%i"
        if "!ten!" neq "" (
            @ set "ten= !ten!"
        )

    )
 

    @ set "combo_wrd=!one!!two!!three!!four!!five!!six!!sevn!"
 
    if "!combo_wrd!" neq "" (
        @ call "funcs_no_make.bat" :file_into_dir "%~3\!combo_wrd!" "%~4"
    )
exit /b



:extensions
    @ call "funcs_no_make.bat" :file_into_dir "%~1" "%~2"
exit /b

:no_encaps_test

    echo "%~2"
    set no_sqr_brkt=
    set no_curl_brkt=
    set no_parenth=
    for /f "tokens=1 delims=[" %%i in ("%~2") do (
        set "no_sqr_brkt=%%i"
    )
    for /f "tokens=1 delims={" %%i in ("%~2") do (
        set "no_curl_brkt=%%i"
    )

    for /f "tokens=1 delims=(" %%i in ("%~2") do (
        set "no_parenth=%%i"
    )
    rem ECHO "!no_sqr_brkt!" "%~2"
    rem pause
    if "!no_sqr_brkt!" neq "%~2" (
        exit /b
    )
    if "!no_curl_brkt!" neq "%~2" (
        exit /b
    )
    if "!no_parenth!" neq "%~2" (
        exit /b
    )
    call "funcs_no_make.bat" :file_into_dir "%~1" "%~2"
    
exit /b

:no_encap
exit /b

:parenth_pair_qty
    set one=
    set two=
    set three=
    set four=
    set five=
    set six=
    for /f "tokens=1 delims=(" %%i in ("%~1") do (
        set "one=%%i"
    )
    for /f "tokens=2 delims=(" %%i in ("%~1") do (
        set "two=%%i"
    )

    for /f "tokens=3 delims=(" %%i in ("%~1") do (
        set "three=%%i"
    )
    for /f "tokens=4 delims=(" %%i in ("%~1") do (
        set "four=%%i"
    )
    for /f "tokens=5 delims=(" %%i in ("%~1") do (
        set "five=%%i"
    )
    for /f "tokens=6 delims=(" %%i in ("%~1") do (
        set "six=%%i"
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
    rem echo one "!one!"
    rem echo two "!two!"
    rem echo three "!three!"
    rem echo four "!four!"
    rem echo five "!five!"
    rem echo six "!six!"
    echo NAME "%~1" QTY "!qty!"
    rem pause
    rem echo QTY !qty!
    set /a file_qty=0
    for /f "tokens=*" %%i in (largest_parenth_qty.txt) do (
        set /a file_qty=%%i
    )

    if !qty! gtr !file_qty! (
        echo !qty! > "largest_parenth_qty.txt"
        echo "%~1" > "largest_parenth.txt"
    )

    rem parse single () pair
    rem Parse double () pair
    rem Parse Yakyuudou (Utility (Taisen) disk).d88
    rem Parse triple () pair
    call :parse_three_parenth "%~1" "!qty!"
exit /b


:parse_three_parenth
    set one=
    set two=
    set three=
    set words=
    for /f "tokens=2 delims=(" %%i in ("%~1") do (
        set "one=%%i"
    )
    for /f "tokens=3 delims=(" %%i in ("%~1") do (
        set "two=%%i"
    )
    for /f "tokens=4 delims=(" %%i in ("%~1") do (
        set "three=%%i"
    )
    set "words=!one!!two!!three!"

    for /f "tokens=1 delims=)" %%i in ("!words!") do (
        set "one=%%i"
    )
    for /f "tokens=2 delims=)" %%i in ("!words!") do (
        set "two=%%i"
    )
    for /f "tokens=3 delims=)" %%i in ("!words!") do (
        set "three=%%i"
    )

    rem Sometimes appends the file extension to the end of 
    rem .... the encapsulated words.
    set "words=!one!!two!!three!"
   
    if "%~2" equ "0" (
        echo "%~1 =  !words!" > "zero.txt"
    )

    if "%~2" equ "1" (
        echo "%~1 = !words!" > "one.txt"
    )
    if "%~2" equ "2" (
        echo "%~1 = !words!" > "two.txt"
    )
    if "%~2" equ "3" (
        echo "%~1 = !words!" > "three.txt"
    )
    if "%~1" equ "Yakyuudou (Utility (Taisen) disk).d88" (
        echo "%~1 = !words!" > "four.txt"
    )

exit /b