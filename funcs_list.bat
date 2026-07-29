@ setlocal EnableDelayedExpansion



@ call %*
@ goto :eof






:list_gen

set "prim_dirs=%~1"
set "secnd_dirs=%~2"
@ set src=
@ set u_scor=
@ set prnth=
@ set sqr_brkt=
@ set curl_brkt=
@ set exts=
@ set compl=
set encap=

for /f "tokens=1 delims=|" %%i in ("!prim_dirs!") do (
    @ set "src=%%i"
)
for /f "tokens=2 delims=|" %%i in ("!prim_dirs!") do (
    @ set "u_scor=%%i"
)
for /f "tokens=3 delims=|" %%i in ("!prim_dirs!") do (
    @ set "prnth=%%i"
)
for /f "tokens=4 delims=|" %%i in ("!prim_dirs!") do (
    @ set "sqr_brkt=%%i"
)
for /f "tokens=5 delims=|" %%i in ("!prim_dirs!") do (
    @ set "curl_brkt=%%i"
)
for /f "tokens=6 delims=|" %%i in ("!prim_dirs!") do (
    @ set "exts=%%i"
)
for /f "tokens=7 delims=|" %%i in ("!prim_dirs!") do (
    @ set "compl=%%i"
)

set quan=
set prelim=
set label=
for /f "tokens=1 delims=|" %%i in ("!secnd_dirs!") do (
    set "quan=%%i"
)
for /f "tokens=6 delims=|" %%i in ("!secnd_dirs!") do (
    set "encap=%%i"
)

for /f "tokens=7 delims=|" %%i in ("!secnd_dirs!") do (
    set "prelim=%%i"
)

for /f "tokens=8 delims=|" %%i in ("!secnd_dirs!") do (
    set "label=%%i"
)

set "prelim_label=!prelim!_!label!"




for /d %%i in ("!src!\*") do (

    rem call :underscores "!u_scor!\DIR" "%%~nxi"

    set "pl_dir=%prelim_label%\DIR"
    set "pare_pl_d=!prnth!\!pl_dir!"
    set "sqr_pl_d=!sqr_brkt!\!pl_dir!"
    set "curl_pl_d=!curl_brkt!\!pl_dir!"
    rem echo "!pare_pl_d!"
    rem echo "!sqr_pl_d!"
    rem echo "!curl_pl_d!"
    rem echo "^"
   
    

    rem call "funcs_prelim_labels.bat" :parenths "!pare_pl_d!" "%%~nxi"
    rem call "funcs_prelim_labels.bat" :sqr_brackets "!sqr_pl_d!" "%%~nxi"
    rem call "funcs_prelim_labels.bat" :curly_brackets "!curl_pl_d!" "%%~nxi"

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


        set "pl_file=%prelim_label%\FILE"

        set "pare_pl_f=!prnth!\!pl_file!"
        set "sqr_pl_f=!sqr_brkt!\!pl_file!"
        set "curl_pl_f=!curl_brkt!\!pl_file!"


        rem echo "!pare_pl_f!"
        rem echo "!sqr_pl_f!"
        rem echo "!curl_pl_f!"
        rem pause

        rem call "funcs_prelim_labels.bat" :parenths "!pare_pl_f!" "%%~nxj"
        rem call "funcs_prelim_labels.bat" :sqr_brackets "!sqr_pl_f!" "%%~nxj"
        rem call "funcs_prelim_labels.bat" :curly_brackets "!curl_pl_f!" "%%~nxj"


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
    rem call :p_word_qty "%~1"
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

   

    call :p_word_qty "%~3" "!is_nested!"

exit /b



rem Collect all parenthesized words within dir or file name
rem     and show the entire collection words as a string.
rem Need this function because we wish to determine if one
rem     of the collected words is "demo", "Demo", "disk",
rem     "Disk", "Music", or "music" and to categorize 
rem     those dirs or files 
rem     for EmulationStation:


:p_word_qty

    rem File or directory name
    set "name=%~1"
    set "is_nested=%~2"

    rem A file or directory name can have 0 or up to 3
    rem     groups of parenthesized words, where each
    rem     group can contain 1 or more words.

    rem 3 groups of words and combine the groups to find
    rem     the string of all parenthesized words.
    set one=
    set two=
    set three=

    rem The group of words and any other words
    rem     (grouped or ungrouped) that follow words in the
    rem     group of interest.
    rem "Followed words" will be separated from the group,
    rem     leaving only the words belonging to the group
    rem     of interest.
    set one_tail=
    set two_tail=
    set three_tail=

    rem            Collecting Group 1
    for /f "tokens=2 delims=(" %%i in ("!name!") do (
        set "one_tail=%%i"
    )


    rem Account for circumstances when directory or file name
    rem     does not have parenthesized words in the name 
    rem     nor the delimiting character, and the for /f loop
    rem     returns teh  entire file name instead of the 
    rem     non-existing group of words.
    if "!one_tail!" equ "!name!" (
        set one_tail=
    )

    for /f "tokens=1 delims=)" %%i in ("!one_tail!") do (
        set "one=%%i"
    )

    for /f "tokens=1 delims=(" %%i in ("!one!") do (
        set "one=%%i"
    )








    rem          Find Group 2
    for /f "tokens=3 delims=(" %%i in ("!name!") do (
        set "two_tail=%%i"
    )

    rem Account for circumstances where the previous 
    rem     delimiting character is non-existent and we
    rem     we get the entirety of one_tail when determining
    rem     two_tail.
    if "!two_tail!" equ "!name!" (
        set two_tail=
    )

    for /f "tokens=1 delims=)" %%i in ("!two_tail!") do (
        set "two=%%i"
    )


    if "!is_nested!" equ "T" (
        set "name=(!name!"
    )

    
    rem                 Group 3
    for /f "tokens=4 delims=(" %%i in ("!name!") do (
        set "three_tail=%%i"
    )

    if "!is_nested!" equ "F" (
        set "three_tail=)!three_tail!"
    )
    

    for /f "tokens=2 delims=)" %%i in ("!three_tail!") do (
        set "three=%%i"
    )

    for /f "tokens=1 delims=)" %%i in ("!three_tail!") do (
        set "three=%%i"
    )


    echo "!name!"
    set "encaps=(!one!)   (!two!)    (!three!)"
    
    echo "!encaps!"
    set brk=^


    echo "!brk!"


exit /b