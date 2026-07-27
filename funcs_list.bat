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
set encap=

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

set quan=

for /f "tokens=1 delims=|" %%i in ("%~4") do (
    set "quan=%%i"
)
for /f "tokens=6 delims=|" %%i in ("%~4") do (
    set "encap=%%i"
)




for /d %%i in ("!src!\*") do (

    rem call :underscores "!u_scor!\DIR" "%%~nxi"
    rem call :parenths "!prnth!\DIR" "%%~nxi"
    rem call :sqr_brackets "!sqr_brkt!\DIR" "%%~nxi"
    rem call :curly_brackets_test "!curl_brkt!\DIR" "%%~nxi"

    rem Call these functions one at a time because of the HUGE time penalty
    rem     when creating the directories and files.
    rem call :parenth_qty "%%~nxi" "%~4" "!prnth!\!quan!\DIR"
    rem call :square_qty "%%~nxi" "%~4" "!sqr_brkt!\!quan!\DIR"
    rem call :curly_qty "%%~nxi" "%~4" "!curl_brkt!" "!curl_brkt!\!quan!\DIR"

    rem need to isolate an encapsulated disk/Disk from parenthese...
    rem .... but need to have prior knowledge about the maximum number of encapsulated words
    rem .... within a found set of parentehesis



    rem call :no_encaps_test "%~3\DIR" "%%~nxi"
    rem echo " --- %%~nxi ---"
    


    for %%j in ("%%i\*") do (

        rem call :underscores "!u_scor!\FILE\%%~nxi" "%%~nxj"
        rem call :parenths "!prnth!\FILE" "%%~nxj"
        rem call :sqr_brackets "!sqr_brkt!\FILE" "%%~nxj"
        rem call :curly_brackets "!curl_brkt!\FILE" "%%~nxj"
        rem call :extensions "!exts!\%%~xj" "%%~nxj"
        rem call :completed "!compl!\%%~nxi" "%%~nxj" 


        rem call :parenth_qty "%%~nxj" "%~4" "!prnth!\!quan!\FILE"
        rem call :square_qty "%%~nxj" "%~4" "!sqr_brkt!\!quan!\FILE"
        rem call :curly_qty "%%~nxj" "%~4" "!curl_brkt!" "!curl_brkt!\!quan!\FILE"
        call :parenth_word_qty "%%~nj" "%~4" "!prnth!\!encap!_!quan!\FILE"

        rem call :no_encaps_test "%~3\FILE" "%%~nxj"
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




:square_qty
    call :encaps_pair_qty "[" "]" "%~1" "%~2" "%~3"
exit /b

:curly_qty
    call :encaps_pair_qty "{" "}" "%~1" "%~2" "%~3"
exit /b


:parenth_qty
    call :encaps_pair_qty "(" ")" "%~1" "%~2" "%~3"
exit /b


:encaps_pair_qty
    rem %~5 = DIR or FILE
    rem echo five "%~5"
    rem pause
    set one=
    set two=
    set three=
    set four=
    set five=
    set six=
    for /f "tokens=1 delims=%~1" %%i in ("%~3") do (
        set "one=%%i"
    )
    for /f "tokens=2 delims=%~1" %%i in ("%~3") do (
        set "two=%%i"
    )

    for /f "tokens=3 delims=%~1" %%i in ("%~3") do (
        set "three=%%i"
    )
    for /f "tokens=4 delims=%~1" %%i in ("%~3") do (
        set "four=%%i"
    )
    for /f "tokens=5 delims=%~1" %%i in ("%~3") do (
        set "five=%%i"
    )
    for /f "tokens=6 delims=%~1" %%i in ("%~3") do (
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
  
  
    set /a file_qty=0


    set larg_qty_txt=largest_qty.txt

    if not exist %~5\!larg_qty_txt! (
        call "funcs_no_make.bat" :file_into_dir "%~5" "!larg_qty_txt!"
        echo -1 > %~5\!larg_qty_txt!
    )

    for /f "tokens=*" %%i in (%~5\!larg_qty_txt!) do (
        set /a file_qty=%%i
    )

   

    if !qty! gtr !file_qty! (
   
        call "funcs_no_make.bat" :file_into_dir "%~5" "!larg_qty_txt!"
        call "funcs_no_make.bat" :file_into_dir "%~5" "longest_encaps_words.txt"
        echo !qty! > "%~5\!larg_qty_txt!"
        echo "%~3" > "%~5\longest_encaps_words.txt"
        
    )

    rem parse single () pair
    rem Parse double () pair
    rem Parse triple () pair
    call :parse_multi_encaps "%~1" "%~2" "%~3" "%~4" "%~5" "!qty!"
exit /b


:parse_multi_encaps
    rem echo parse_multi_encaps 1 "%~1"
    set one=
    set two=
    set three=
    set words=
    for /f "tokens=2 delims=%~1" %%i in ("%~3") do (
        set "one=%%i"
    )
    for /f "tokens=3 delims=%~1" %%i in ("%~3") do (
        set "two=%%i"
    )
    for /f "tokens=4 delims=%~1" %%i in ("%~3") do (
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

    for /f "tokens=2 delims=|" %%i in ("%~4") do (
        set "none=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("%~4") do (
        set "singl=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("%~4") do (
        set "doubl=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("%~4") do (
        set "tripl=%%i"
    )

    rem How to show that we parsed the encapsulated words and
    rem     the original fiile name containing those encapsulated
    rem     words.
    rem file name (encapsulated words)_encapsulated words
    rem echo path file_encapsulated "%~3_!words!" 

    set "path=%~5\!none!"
    if "%~6" equ "1" (
        set "path=%~5\!singl!"
    )
    if "%~6" equ "2" (
        set "path=%~5\!doubl!"
    )
    if "%~6" equ "3" (
        set "path=%~5\!tripl!"
    )

    call "funcs_no_make.bat" :file_into_dir "!path!" "%~3___!words!____%~6"

exit /b

rem                             file_name   bundled-dirs    root
:parenth_word_qty
    rem call :encaps_word_qty "()" ")" "%~1" "%~2" "%~3"
    call :has_nested_parenth "" "" "%~1"
exit /b

:encaps_word_qty
    rem echo parse_multi_encaps 1 "%~1"
    set one=
    set two=
    set three=
    set words=
    for /f "tokens=2 delims=%~1" %%i in ("%~3") do (
        set "one=%%i"
    )
    for /f "tokens=3 delims=%~1" %%i in ("%~3") do (
        set "two=%%i"
    )
    for /f "tokens=4 delims=%~1" %%i in ("%~3") do (
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
    set "words=!one!!two!!three!"
    echo FIRST WORD "!words!"

   
    set first=
    set sec=
    set third=
    set fourth=
    set fifth=
    set sixth=
    set seventh=
    set eighth=
    set ninth=
    set tenth=
    set eleventh=
    set twelfth=
    set thirteenth=
    set fourteenth=
    set fifteenth=
    set sixteenth=
    set seventeenth=
    set eighteenth=
    set nineteenth=
    set twentieth=

    for /f "tokens=1 delims= " %%i in ("!words!") do (
        set "first=%%i"

    )
    for /f "tokens=2 delims= " %%i in ("!words!") do (
        set "sec=%%i"

    )
    for /f "tokens=3 delims= " %%i in ("!words!") do (
        set "third=%%i"

    )
    for /f "tokens=4 delims= " %%i in ("!words!") do (
        set "fourth=%%i"
    )
    for /f "tokens=5 delims= " %%i in ("!words!") do (
        set "fifth=%%i"

    )
    for /f "tokens=6 delims= " %%i in ("!words!") do (
        set "sixth=%%i"

    )
    for /f "tokens=7 delims= " %%i in ("!words!") do (
        set "seventh=%%i"

    )
    for /f "tokens=8 delims= " %%i in ("!words!") do (
        set "eighth=%%i"

    )
    for /f "tokens=9 delims= " %%i in ("!words!") do (
        set "ninth=%%i"

    )
    for /f "tokens=10 delims= " %%i in ("!words!") do (
        set "tenth=%%i"
    )
    for /f "tokens=11 delims= " %%i in ("!words!") do (
        set "eleventh=%%i"
    )
    for /f "tokens=12 delims= " %%i in ("!words!") do (
        set "twelfth=%%i"
    )
    for /f "tokens=13 delims= " %%i in ("!words!") do (
        set "thirteenth=%%i"
    )
    for /f "tokens=14 delims= " %%i in ("!words!") do (
        set "fourteenth=%%i"
    )
    for /f "tokens=15 delims= " %%i in ("!words!") do (
        set "fifteenth=%%i"
    )
    for /f "tokens=16 delims= " %%i in ("!words!") do (
        set "sixteenth=%%i"
    )
    for /f "tokens=17 delims= " %%i in ("!words!") do (
        set "seventeenth=%%i"
    )
    for /f "tokens=18 delims= " %%i in ("!words!") do (
        set "eighteenth=%%i"
    )
    for /f "tokens=19 delims= " %%i in ("!words!") do (
        set "nineteenth=%%i"
    )
    for /f "tokens=20 delims= " %%i in ("!words!") do (
        set "twentieth=%%i"
    )



   
    
    set /a qty=0


    if "!first!" neq "" (
        set /a qty+=1
    )
    if "!sec!" neq "" (
        set /a qty+=1
    )

    if "!third!" neq "" (
        set /a qty+=1        
    )
    if "!fourth!" neq "" (
        set /a qty+=1        
    )
    if "!fifth!" neq "" (
        set /a qty+=1        
    )
    if "!sixth!" neq "" (
        set /a qty+=1        
    )
    if "!seventh!" neq "" (
        set /a qty+=1        
    )
    if "!eighth!" neq "" (
         set /a qty+=1       
    )
    if "!ninth!" neq "" (
        set /a qty+=1        
    )
    if "!tenth!" neq "" (
        set /a qty+=1
    )
    if "!eleventh!" neq "" (
        set /a qty+=1
    )
    if "!twelfth!" neq "" (
        set /a qty+=1
    )
    if "!thirteenth!" neq "" (
        set /a qty+=1
    )
    if "!fourteenth!" neq "" (
        set /a qty+=1
    )
    if "!fifteenth!" neq "" (
        set /a qty+=1
    )
    if "!sixteenth!" neq "" (
        set /a qty+=1
    )
    
    if "!seventeenth!" neq "" (
        set /a qty+=1
    )
    if "!eighteenth!" neq "" (
        set /a qty+=1
    )
    if "!nineteenth!" neq "" (
        set /a qty+=1
    )
    
    if "!twentieth!" neq "" (
        set /a qty+=1
    )

    


 rem echo ORIGINAL "%~3"
 rem echo WORDS "!words!"  !qty!
 rem echo ONE "!one!" TWO "!two!" THREE "!three!"
 rem echo FIVE "%~5"
 rem pause
 rem qty !qty! "!words!"
 
 echo "!first! !sec! !third! !fourth! !fifth! !sixth! !seventh! !eighth! !ninth! !tenth! !eleventh! !twelfth! !thirteenth! !fourteen! !fifteenth! !sixteenth! !seventeenth! !eighteenth! !nineteenth! !twentieth!"
 
 



    set larg_qty_txt=largest_qty.txt

    if not exist %~5\!larg_qty_txt! (
        call "funcs_no_make.bat" :file_into_dir "%~5" "!larg_qty_txt!"
        echo -1 > %~5\!larg_qty_txt!
    )

    for /f "tokens=*" %%i in (%~5\!larg_qty_txt!) do (
        set /a file_qty=%%i
    )

    
    if !qty! gtr !file_qty! (
   
        call "funcs_no_make.bat" :file_into_dir "%~5" "!larg_qty_txt!"
        call "funcs_no_make.bat" :file_into_dir "%~5" "longest_encaps_words.txt"
        echo !qty! > "%~5\!larg_qty_txt!"
        echo "%~3" > "%~5\longest_encaps_words.txt"
        
    )



exit /b


:has_nested_parenth

    set one=
    set two=
    for /f "tokens=2 delims=(" %%i in ("%~3") do (
        set "one=%%i"
    )

    if "!one!" equ "%~3" (
        set one=
    )

    for /f "tokens=1 delims=)" %%i in ("!one!") do (
        set "two=%%i"
    )

    set is_nested="T"

    rem When file name contains no parentheses at all.
    if "!two!" equ "" (
        set "is_nested=F"
    )

    if "!two!" neq "!one!" (
        set "is_nested=F"
    )

    if "!is_nested!" equ "F" (
        echo NOT NESTED "%~3"
    ) else (
        echo IS NESTED "%~3"
    )

exit /b