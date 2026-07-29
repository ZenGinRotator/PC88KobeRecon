setlocal EnableDelayedExpansion
rem all
@ rem "path" "title of dir/file"
:parenths
    set "name=%~2"
    set "list_dirs=%~1"
    @ call :encapsulated_word "(" ")" "%~1" "!name!"
exit /b

rem all
:curly_brackets
    set "list_dirs=%~1"
    set "name=%~2"
    @ call :encapsulated_word "{" "}" "%~1" "!name!"
exit /b


rem all
:sqr_brackets
    set "list_dirs=%~1"
    set "name=%~2"
    @ call :encapsulated_word "[" "]" "%~1" "!name!"
exit /b

rem all
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
    set "name=%~4"
	for /f "tokens=2 delims=%~1" %%i in ("!name!") do (
		@ set "wrd_tail=%%i"
	)
	for /f "tokens=1 delims=%~2" %%i in ("!wrd_tail!") do (
		@ set "wrd=%%i"
	)


    for /f "tokens=3 delims=%~1" %%i in ("!name!") do (
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
        @ call "funcs_no_make.bat" :file_into_dir "%~3\!combo_wrd!" "!name!"
    )
exit /b

