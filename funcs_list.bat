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

    @ call :underscores "!u_scor!\DIR" "%%~nxi"
    @ call :parenths "!prnth!\DIR" "%%~nxi"
    @ call :sqr_brackets "!sqr_brkt!\DIR" "%%~nxi"
    @ call :curly_brackets "!curl_brkt!\DIR" "%%~nxi"


    for %%j in ("%%i\*") do (

       @ call :find_underscore "!u_scor!\FILE\%%~nxi" "%%~nxj"
       @ call :parenths "!prnth!\FILE" "%%~nxj"
       @ call :sqr_brackets "!sqr_brkt!\FILE" "%%~nxj"
       @ call :curly_brackets "!curl_brkt!\FILE" "%%~nxj"
       @ call :extensions "!exts!\%%~xj" "%%~nxj"
       @ call :completed "!compl!\%%~nxi" "%%~nxj"
    )

)

@ rem %~2 = LIST_MADE
echo > "%~2"
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
        echo FFFF "%%i"
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