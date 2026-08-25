setlocal EnableDelayedExpansion

set hep=has_encaps_pnth.txt
set hec=has_encaps_curl.txt
set hes=has_encaps_sqr.txt

set inp=is_nested_pnth.txt
set inc=is_nested_curl.txt
set ins=is_nested_sqr.txt

set grptxt=group.txt
set delimtxt=delimited.txt
set toktxt=tokens.txt
set encptd=encapsulated.txt
set onstxt=ones.txt
set brgtxt=bridges.txt
set brk=^



call %*

goto :eof

rem The directory or file name may have 0, 1, 2, or 3 encapsulated groups of words.
rem Need to gather directory or file names by keywords encapsulated wthinin each group,
rem     and not collected by a category specified by the combination of all encapsulated 
rem     words from all groups within the directory or file name.

rem For each directory or file name
rem 1. determine if it has a nested or non-nested encapsulator and write status to file
rem 2. read its nested/non-nested state from file
rem 3. extract keywords from Groups 1, 2, 3, using the non-nested status of the 
rem     directory or file name
rem 4. sort directory or file names by Groups 1, 2, 3, or none (when there are no groups in the name)

rem need d88 t88 or .cmt file extensions only -- use counter > 0 accept, equ 0 -> reject


rem ROM_KEYWORDS
REM /INDIV_GROUP/LISTED_ONLY/<label 1, 2, or 3> **
REM /INDIV_GROUP/LSITED_AND_FILE/<label 1, 2, or 3>/<disk with <label 1, 2, or 3>> -- required to determine label of highest priority


REM /COMBO_GROUP/LISTED_ONLY/<label 1 and label 2 || label1 label2 label3>
REM /COMBO_GROUP/LISTED_AND_FILE/<label 1 and label 2 || label1 label2 label3>/<disk with <label1> <label2> <label3>> -- required to determine label of highest priority
rem ** partially done


rem Save by individual group (list of names and categorized names containing files)
rem save by all groups combined together

rem Need to find music in name title that is non-encapsulated





rem determine whether file is .d88, .cmt, or .t88
:find_rom

    call :del_all
    set "name=%~1"
    set "prim_dirs=%~2"
    set "sec_dirs=%~3"
    rem set "dest_dir=%~3"
    set "ext=%~4"
    set /a ct=0

    set f=disk_ext_qty.txt
  
    call :disk_count_ "!ext!" "!f!"
  
    for /f "tokens=*" %%i in (!f!) do (
        set /a "ct=%%i"
    )

   


    echo "!brk!"
    echo  NAME "!name!" CT "!ct!" ****************************
    del "!f!"
  
    if !ct! equ 0 (
        exit /b
    )

    call :name_ "!name!" "!prim_dirs!" "!sec_dirs!"

    
    
exit /b


:del_all
    call :del_indiv "%hep%"
    call :del_indiv "%hec%"
    call :del_indiv "%hes%"
    call :del_indiv "%inp%"
    call :del_indiv "%inc%"
    call :del_indiv "%ins%"
exit /b

:del_indiv
    set "file=%~1"
    if exist "!file!" (
        del "!file!"
    )
exit /b

rem determine whether file and directory name has (), {}, [], or does not have encapsulator


:name_
    set "name=%~1"
    set "prim_dirs=%~2"
    set "sec_dirs=%~3"

    set prnth=
    set sqr_brkt=
    set curl_brkt=
    set rkeywd=
    for /f "tokens=3 delims=|" %%i in ("!prim_dirs!") do (
        set "prnth=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!prim_dirs!") do (
        set "sqr_brkt=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("!prim_dirs!") do (
        set "curl_brkt=%%i"
    )


    for /f "tokens=11 delims=|" %%i in ("!sec_dirs!") do (
        set "rkeywd=%%i"
    )

    

    rem use to identify whether we need to skip file or directory name when
    rem     the name has no encapsulators


    rem nested flag
    call :encaps_check "(" ")" "!name!" "%hep%" "%inp%"
    call :encaps_check "{" "}" "!name!" "%hec%" "%inc%"
    call :encaps_check "[" "]" "!name!" "%hes%" "%ins%"

    set ptail=
    set ctail=
    set stail=

    for /f "tokens=*" %%i in (%hep%) do (
        set "ptail=%%i"
    )
    for /f "tokens=*" %%i in (%hec%) do (
        set "ctail=%%i"
    )
    for /f "tokens=*" %%i in (%hes%) do (
        set "stail=%%i"
    )

    echo ONE TAIL "!ptail!" **********************************
    rem blank = ECHO is off.
    set "blnk=ECHO is off."
    rem echo start "!name!"
    rem echo parnet "!ptail!"
    rem echo curly "!ctail!"
    rem echo square "!stail!"

    del "%hep%"
    del "%hec%"
    del "%hes%"

    set /a qty=0
    if "!ptail!" equ "!blnk!" (
        set /a qty+=1
    )
    if "!ctail!" equ "!blnk!" (
        set /a qty+=1
    )
    if "!stail!" equ "!blnk!" (
        set /a qty+=1
    )
    if !qty! equ 3 (
        rem echo NO ENCAPSULATORS
        exit /b
    )



    if "!ptail!" neq "!blnk!" (
        call :delim_it "!name!" "(" ")" "!prim_dirs!" "!sec_dirs!"
    )

    if "!ctail!" neq "!blnk!" (
        call :delim_it "!name!" "{" "}" "!prim_dirs!" "!sec_dirs!"
    )

    if "!stail!" neq "!blnk!" (
        call :delim_it "!name!" "[" "]" "!prim_dirs!" "!sec_dirs!"
    )

    

exit /b



:delim_it
rem echo DELIM NAME "!name!" "%~2" "%~3"
    set "name=%~1"
    rem 2 = left bound encapsulator
    rem 3 = right bound encapsulator

    set "sec_dirs=%~5"

    set prnth=
    set sqr_brkt=
    set curl_brkt=
    for /f "tokens=3 delims=|" %%i in ("!prim_dirs!") do (
        set "prnth=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!prim_dirs!") do (
        set "sqr_brkt=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("!prim_dirs!") do (
        set "curl_brkt=%%i"
    )

    set rkeywd=
    set lst_o=
    set lst_anfl=
    set indv_grp=
    set cmbo_grp=

    for /f "tokens=11 delims=|" %%i in ("!sec_dirs!") do (
        set "rkeywd=%%i"
    )

    for /f "tokens=12 delims=|" %%i in ("!sec_dirs!") do (
        set "lst_o=%%i"
    )
    for /f "tokens=13 delims=|" %%i in ("!sec_dirs!") do (
        set "lst_anfl=%%i"
    )
    for /f "tokens=14 delims=|" %%i in ("!sec_dirs!") do (
        set "indv_grp=%%i"
    )
    for /f "tokens=15 delims=|" %%i in ("!sec_dirs!") do (
        set "cmbo_grp=%%i"
    )
    rem echo DEST DIR "!dest_dir!"

    

    set "dest_dir=!prnth!\!rkeywd!"
    set nested=%inp%
    rem !prnth!\!rkeywd!
    rem !curl_brkt!\!rkeywd!
    rem !sqr_brkt!\!rkeywd!
    if "%~2" equ "{" (
        set nested=%inc%
        set "dest_dir=!curl_brkt!\!rkeywd!"
    )
    if "%~2" equ "[" (
        set nested=%ins%
        set "dest_dir=!sqr_brkt!\!rkeywd!"
    )

    rem call :echo_dirs "!prim_dirs!" "!sec_dirs!"

    rem exit /b

    set is_nested=
    for /f "tokens=1" %%i in (!nested!) do (
        set "is_nested=%%i"
    )
    echo IS NESTED "!is_nested!"

    
    del "!nested!"

    set one=
    set two=
    set three=
    set one_tail=
    set two_tail=
    set three_tail=
    echo TEST METHOD

    echo  OUTCOME

    rem !!! NEED TO CHANGE DELIM CHARACTERS SO THEY ARE (, [, OR (

    rem Finding non-nested outcomes
    for /f "tokens=2 delims=(" %%i in ("!name!") do (
        set "one_tail=%%i"
    )

    echo ONE TAIL "!one_tail!" ****************************


    for /f "tokens=3 delims=(" %%i in ("!name!") do (
        set "two_tail=%%i"
    )

    set nested_threetail=
    for /f "tokens=4 delims=(" %%i in ("!name!") do (
        set "three_tail=%%i"
    )
    
    rem Change all to receive correct outputs for non-nested labels
    set "one_tail=)!one_tail!"
    set "two_tail=)!two_tail!"
    set "three_tail=)!three_tail!"
    

    for /f "tokens=1 delims=)" %%i in ("!one_tail!") do (
        set "one=%%i"
    )
    for /f "tokens=1 delims=)" %%i in ("!two_tail!") do (
        set "two=%%i"
    )
    for /f "tokens=1 delims=)" %%i in ("!three_tail!") do (
        set "three=%%i"
    )

 
    rem Finding nested outcomes
    set "two_tail=x)!two_tail!"
    
    for /f "tokens=3 delims=)" %%i in ("!two_tail!") do (
        set "nested_three=%%i"
    )
    echo FOUND NESTED THREE "!nested_three!"
    rem REQUIRED: need to make this blank if we receive a portion of file
    rem     name beyond one_tail (eg. "x) end of file name.d88")
    rem     or portion of file name beyond
    rem     two_tail (eg. "y) end of file name.d88")
    if "!is_nested!" equ "F" (
        set nested_three=
    )

    set "three=!nested_three!"
    echo !three! > "three.txt"
    for /f "tokens=1" %%i in (three.txt) do (
        set "three=%%i"
    )

    if "!three!" equ "ECHO" (
        set three=
    )


    echo one "!one!"
    echo two "!two!"
    echo three "!three!"
    echo nested three "!nested_three!"

    exit /b

    rem Guaranteed to have at least 1 group of labels
    
    rem 1-A
    for /f "tokens=2 delims=%~2" %%i in ("!name!") do (
        set "one_tail=%%i"
    )
    rem 1-B
    for /f "tokens=1 delims=%~3" %%i in ("!one_tail!") do (
        set "one=%%i"
    )
    rem 1-C
    for /f "tokens=1 delims=%~2" %%i in ("!one!") do (
        set "one=%%i"
    )


    call :save_group_and_file "!dest_dir!\!indv_grp!" "!lst_o!" "!lst_anfl!" "!one!" "!name!"
    
    
    
    


    rem 2-A
    for /f "tokens=3 delims=%~2" %%i in ("!name!") do (
        set "two_tail=%%i"
    )
        rem 2-B
    for /f "tokens=1 delims=%~3" %%i in ("!two_tail!") do (
        set "two=%%i"
    )

    rem echo TWO TAIL "!two_tail!"
    rem echo TWO "!two!"
    
    rem If two tail is empty, 
    rem save group 1,
    rem return
    REM echo ONE "!one!" TWO "!two!"
    if "!two!" equ "" (
        exit /b
    )
     
    call :save_group_and_file "!dest_dir!\!indv_grp!" "!lst_o!" "!lst_anfl!" "!two!" "!name!"


    if "!is_nested!" equ "T" (
        set "name=(!name!"
    )




    rem 3-A
    for /f "tokens=4 delims=%~2" %%i in ("!name!") do (
        set "three_tail=%%i"
    )

    rem 3-B
    if "!is_nested!" equ "F" (
        set "three_tail=X)!three_tail!"
    )
    rem 3-C
    if "!is_nested!" equ "T" (
        set "three_tail=!two_tail!"
    )

    rem 3-D
    for /f "tokens=2 delims=%~3" %%i in ("!three_tail!") do (
        set "three=%%i"
    )





    rem echo THREE TAIL "!three_tail!"
    rem echo THREE "!three!"
    rem If three tail is empty,
    rem     save group 2
    rem     return 
    if "!three!" equ "" (
        REM echo COMBO ON ONE AND TWO
        set "combo=!one! !two!"
        call :save_group_and_file "!dest_dir!\!cmbo_grp!" "!lst_o!" "!lst_anfl!" "!combo!" "!name!"
        exit /b
    )

    
    rem Remove space before three (eg: " this is a third label with a starting empty space")
    set "three=!three!|"
    echo !three! > "disk.txt"
    for /f "tokens=*" %%i in (disk.txt) do (
        set "three=%%i"
    )
    for /f "tokens=1 delims=|" %%i in ("!three!") do (
        set "three=%%i"
    )

   
   
    call :save_group_and_file "!dest_dir!\!indv_grp!" "!lst_o!" "!lst_anfl!" "!three!" "!name!"
    REM ECHO COMBO ON ONE, TWO, AND THREE


    set "combo=!one! !two! !three!"
    if "!is_nested!" equ "T" (
        set "combo=!one!!two! !three!"
    )

    call :save_group_and_file "!dest_dir!\!cmbo_grp!" "!lst_o!" "!lst_anfl!" "!combo!" "!name!"
    
    


exit /b















:is_or_not_nested   
    setlocal
    rem * has to be incremented
    set "left_token=%~1"
    set "left_char=%~2"
    set "right_char=%~3"


    set "right_token=1"
    
    set "phrase=%~4"
    
    set tail=
    call :delim_with_char "!left_token!" "!left_char!" "!phrase!"
    for /f "tokens=1 delims=|" %%i in (delimited.txt) do (
        set "tail=%%i"
    )
     echo TAIL "!tail!"
    if "!tail!" equ " " (
        exit /b
    )
    call :delim_with_char "!right_token!" "!right_char!" "!tail!"
    set head=
    for /f "tokens=1 delims=|" %%i in (delimited.txt) do (
        set "head=%%i"
    )

    set "is_nested=T"
    rem echo HEAD "!head!" 
    rem echo head "!head!"
    rem echo tail "!tail!"
    if "!head!" neq "!tail!" (
        set "is_nested=F"
    )

    echo !is_nested! > "is_nested.txt"
    set nxt=
    for /f "tokens=1 delims=|" %%i in (ones.txt) do (
        set "nxt=%%i"
    )
    echo "!nxt!" IS NESTED "!is_nested!"
    endlocal
exit /b

:new_token_val
    setlocal
    set /a token=%~1
    rem echo Orig val "!token!"

    set is_nested=
    for /f "tokens=1" %%i in (is_nested.txt) do (
        set "is_nested=%%i"
    )

    if "!is_nested!" equ "F" (
        set /a token+=1
        echo !token! > "token_val.txt"
        exit /b
    )
    set /a token+=2
    rem echo newval "!token!"
    echo !token! > "token_val.txt"
    endlocal
exit /b





























:delete_txts
    setlocal
        if exist "%grptxt%" (
            del "%grptxt%"
        )
        if exist "%delimtxt%" (
            del "%delimtxt%"
        )
        if exist "%toktxt%" (
            del "%toktxt%"
        )
        if exist "%encptd%" (
            del "%encptd%"
        )
        if exist "%onstxt%" (
            del "%onstxt%"
        )
        if exist "%brgtxt%" (
            del "%brgtxt%"
        )
        if exist "change.txt" (
            del "change.txt"
        )



    endlocal
exit /b

:other_encapped_check
    setlocal
    set "primary_left=%~1"
    set "bridge=%~2"

    set "opt1L=["
    set "opt1R=]"

    set "opt2L={"
    set "opt2R=}"

    if "!primary_left!" equ "{" (
        set "opt1L=["
        set "opt1R=]"

        set "opt2L=("
        set "opt2R=)"

    )
    if "!primary_left!" equ "[" (
        set "opt1L=("
        set "opt1R=)"

        set "opt2L={"
        set "opt2R=}"
        
    )
    rem echo - "!primary_left!"
    rem echo - "!opt1L!"
    rem  echo - "!opt2L!"


    echo PRIMARY "!primary_left!"
    echo OPT 1 "!opt1L! !opt1R!"
    echo OPT 2 "!opt2L! !opt2R!"
    REM echo BRIDGE "!bridge!"
    call :at_init_bridge "1" "!opt1L!" "!opt1R!" "!bridge!" "!opt2L!" "!opt2R!"
    del "%encptd%"
    REM call :at_init_bridge "1" "!opt2L!" "!opt2R!" "!bridge!" "!opt1L!" "!opt1R!"


    endlocal
exit /b


:at_init_bridge
    setlocal
    set "token=%~1"
    set "left_char=%~2"
    set "right_char=%~3"
    set "name=%~4"
    set "opt_left_char=%~5"
    set "opt_right_char=%~6"

    rem set "optn_left_char=%~5"
    rem set "optn_right_char=%~6"
     rem echo AT INIT BRIDGE "!name!"

    rem echo FOUR "!name!" should be bridge
    set next_encapped=
    for /f "tokens=1 delims=|" %%i in (%encptd%) do (
        set "next_encapped=%%i"
    )
   

    REM delimit next from any secondary left_chars
    call :delim_with_char "1" "!left_char!" "!next_encapped!"
     for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
          set "next_encapped=%%i"
     )
    rem echo "next encapped -> " "!next_encapped!"
     
     if "!next_encapped!" equ "DONE" (
         rem echo done
         exit /b
    )



    rem NEED BOTH OPTION 1 AND 2
    call :delimit_bridge "!token!" "!left_char!" "!right_char!" "!name!" "!opt_left_char!" "!opt_right_char!"
    rem ECHO BEFORE INCREMENT TOKEN "!token!"
    set /a token+=1
    rem ECHO AFTER INCREMENT TOKEN "!token!"
    call :at_init_bridge "!token!" "!left_char!" "!right_char!" "!name!" "!opt_left_char!" "!opt_right_char!"
    
    endlocal
exit /b



:delimit_bridge

    setlocal

    rem %~1 = 1
    set "token=%~1" 
    set "left_char=%~2"
    set "right_char=%~3"
    set "name=%~4"
    set "opt_left_char=%~5"
    set "opt_right_char=%~6"
    

    REM ECHO DELIM BRIDGE --- "!bridge!"
    rem !left_char! !right_char! !opt_left_char! !opt_right_char!"



    set "right_token=1"
    rem echo DELIM BRIDGE 
    rem echo LEFT CHAR "!left_char!"
    rem echo RIGHT CHRA "!right_char!"
    rem echo TOKEN "!token!"
    rem echo NAME "!name!"
    call :delim_with_char "!token!" "!right_char!" "!name!"
    set temp_head=
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "temp_head=%%i"
    )
    rem echo TEMP HEAD BEFORE "!temp_head!"
    
    set "temp_head_before=!temp_head!"
    set "temp_head=!temp_head!!left_char!"
    rem echo TEMP HEAD AFTER "!temp_head!"
    set flag=
    call :delim_with_char "1" "!left_char!" "!temp_head!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "flag=%%i"
    )
    rem echo flag "!flag!"

    set head=
    call :delim_with_char "1" "!left_char!" "!temp_head!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "head=%%i"
    )


    rem Move this to a different function?
    rem echo TEMP HEAD BEFORE "!temp_head_before!"
    set in=
    set out=
    call :delim_with_char "1" "!left_char!" "!temp_head_before!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "out=%%i"
    )

    call :delim_with_char "2" "!left_char!" "!temp_head_before!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "in=%%i"
    )

    
    set "this=!out!"
    
rem echo IN "!in!" OUT "!out!"

    
    set read=
    if exist "change.txt" (
    for /f "tokens=1 delims=|" %%i in (change.txt) do (
        set "read=%%i"
    )
    )
    rem echo READ "!read!"

    set /a chng=0
    if "!read!" equ "T" (
        set /a chng+=1
    )

    if "!out!" neq " " (
        set /a chng+=1
    )

    if "!in!" equ " " (
        set /a chng+=1
    )

    if !chng! equ 3 (
        set "this=!in!"
    )

    

    set /a chng=0
    if "!out!" equ " " (
        set /a chng+=1
    )

    if "!in!" neq " " (
        set /a chng+=1
    )

    set "place=F|"
    if !chng! equ 2 (
        set "place=T|"
    )

    rem Make this a global constant
    echo !place! > "change.txt"

    rem echo OUT "!out!"
    rem echo IN "!in!"

    rem Need to add "this" to group by implementing a fix for it elsewhere
    rem     eg. write this to encptd.txt file
    rem echo THIS "!this!"
    rem call :write_bridge "!this!"

    rem call :at_init_bridge "1" "!left_char!" "!right_char!" "!this!"
    if "!temp_head_before!" equ " " (
        set "flag=DONE|"
    )

    



    set test=
     call :delim_with_char "1" "!opt_right_char!" "!this!"
     for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
         set "test=%%i"
     )
 rem )
    rem echo TEST ON THIS  "!test!" with opt right char "!opt_right_char!" "tok = 1"
    if "!test!" equ "!this!" (
         rem echo WROTE THIS "!this!"
        call :write_bridge "!this!"
        
    ) 

    if exist ef.txt (
    del "ef.txt"
    )
    if "!this!" neq "!test!" (
        REM APPLY OPTIONS ONTO "THIS"
    rem call :at_this "1" "!left_char!" "!right_char!" "!this!" "!opt_left_char!" "!opt_right_char!"
     call :at_this "1" "!opt_left_char!" "!opt_right_char!" "!this!" "!left_char!" "!right_char!"
     )
    rem echo THIS IS "!this!"
    
   
    rem A means to create an event that terminates the recursive function 
    echo !flag! > "%encptd%"

    endlocal
exit /b

REM USE THE OPTIONS ONTO THIS
:at_this
    setlocal
    set "token=%~1"
    set "left_char=%~2"
    set "right_char=%~3"
    set "name=%~4"
    set "opt_left_char=%~5"
    set "opt_right_char=%~6"
    
    if "!name!" equ " " (
        exit /b
    )
   
    
    set next_encapped=
    if exist ef.txt (
    for /f "tokens=1 delims=|" %%i in (ef.txt) do (
        set "next_encapped=%%i"
    )
    )
   rem ECHO ----- "NXT ENC" "!next_encapped!"

    REM delimit next from any secondary left_chars
    REM call :delim_with_char "1" "!left_char!" "!next_encapped!"
    REM for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
    REM     set "next_encapped=%%i"
    REM )
    rem echo "next encapped -> " "!next_encapped!"
    rem When this does not include left_char
    

    rem "Y Z[x] { c c } { d d } FART {e e} [x] [m m [n n] [o o] [p p] q q] BRO  {fix it}  [ ]"
    rem Possibilities for next_encapped
    rem return the entirety of this when left_char does not exist
    rem type 1: nc=Y Z, using lc=[ with token=1


    rem return the entirety of this when left_char does exist,
    rem type 2: nc=d d } FART, using lc={ with token=3

    rem type 3: nc= " " or "ECHO is off." when iterated token cannot find any more partitions of name

    rem     but token still needs to iterate through this
    rem return next encapped as the token continuosly increases
    rem return a next_encapped=" " or ECHO is off.

     if "!next_encapped!" equ "ECHO is off." (
        
         exit /b
     )

     rem if "!next_encapped!" equ "" (
     rem   exit /b
     rem )
     rem if "!next_encapped!" equ "X" (
     rem     exit /b
     rem )
     rem echo ** WRITING ** "!next_encapped!"
    rem echo DO AN ALTERNATIVE THIS RECURSIVE SEARCH ON NEXT_ENCAPPED
    rem ECHO THEN WRITE THE OUTCOME TO BRIDGES --- NEED TO CHECK FOR AN EXISTING FILE IN A SAMPLE DIR
    
    REM DELIMIT WITH OPTIONS
    rem do the test here for existence of right option
    
    set test=
     call :delim_with_char "1" "!right_char!" "!next_encapped!"
     for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
         set "test=%%i"
     )
     rem echo VS TEST "!test!" vs "!next_encapped!" NEXT ENCP  RIGHT CHAR "!left_char!"
     
     set use=
     if "!test!" equ "!next_encapped!" (
        set "use=!next_encapped!"
    
     )

     rem echo WRITING USE 1 "!use!"
    call :write_bridge "!use!"
     call :delim_with_char "2" "!right_char!" "!next_encapped!"
     for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "test=%%i"
     )

     rem echo NEW VS TEST "!test!" WITH next encp "!next_encapped!"

    if "!test!" neq "!next_encapped!" (
        set "use=!test!"
    )

    rem echo WRITING USE  2 "!use!"
    call :write_bridge "!use!"

    if exist fg.txt (
    del "fg.txt"
    )
  


    call :delimit_this "!token!" "!left_char!" "!right_char!" "!name!"
    set /a token+=1
    call :at_this "!token!" "!left_char!" "!right_char!" "!name!" "!opt_left_char!" "!opt_right_char!"
    endlocal
exit /b

:delimit_this
    setlocal
    set "token=%~1"
    set "left_char=%~2"
    set "right_char=%~3"
    set "name=%~4"

    call :delim_with_char "!token!" "!left_char!" "!name!"
    set temp_head=
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "temp_head=%%i"
    )
    REM echo ==================================TEMP HEAD "!temp_head!" "!token!" "!left_char!"
    REM echo -------------- THIS "!name!"

    if "!temp_head!" equ "!name!" (
        echo !name! > "ef.txt"
        exit /b
    )

    echo !temp_head! > "ef.txt"


    endlocal
exit /b


REM THE OPTIONS ARE LEFT & RIGHT CHARS
:at_prelim
    setlocal
    set "token=%~1"
    set "left_char=%~2"
    set "right_char=%~3"
    set "prelim=%~4"
    echo AT PRELIM "!prelim!" LEFT CHAR IS  "!left_char!" TOKEN = "!token!"

    set next=
    for /f "tokens=1 delims=|" %%i in (fg.txt) do (
        set "next=%%i"
    )
 echo NEXT "!next!"
 REM TEST FOR THE EXISTENCE OF RIGHT OPTION = "}"
 REM IF IT EXISTS DONT' SAVE NEXT


    if "!next!" equ "ECHO is off." (
         exit /b
    )
rem call :write_bridge "!next!"
    if "!next!" equ "DONE" (
        exit /b
    )
    call :delim_prelim "!token!" "!left_char!" "!right_char!" "!prelim!"
    set /a token+=1
    call :at_prelim "!token!" "!left_char!" "!right_char!" "!prelim!"
    endlocal
exit /b

:delim_prelim
    setlocal
    set "token=%~1"
    set "left_char=%~2"
    set "right_char=%~3"
    set "prelim=%~4"
    

    call :delim_with_char "!token!" "!left_char!" "!prelim!"
    set t_head=
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "t_head=%%i"
    )
    echo T_HEAD "!t_head!" LEFT CHAR = "!left_char!" PRELIM "!prelim!" TOKN "!token!"
    REM DO A TEST FOR RIGHT OPTION ON T_HEAD
    call :delim_with_char "1" "!right_char!" "!t_head!"
   

  
    rem if "!t_head!" neq "!prelim!" (
    rem     echo diff "!t_head!" vs "!prelim!"
    rem )
    REM if "!t_head!" equ "!prelim!" (
    REM     echo !prelim! > "fg.txt"
    REM     exit /b
    REM )

    rem if "!t_head!" equ "blank" (
    rem     echo "blank" > "fg.txt"
    rem )

    echo !t_head! > "fg.txt"
    endlocal
exit /b



:trav_parenth_curl_sqr
    set "name=%~1"
    echo FILE "!name!"
    call :traverse "2" "(" ")" "!name!"
    call :traverse "2" "{" "}" "!name!"
    call :traverse "2" "[" "]" "!name!"
exit /b 



:traverse
    setlocal

    call :delete_txts
    set "token=%~1"
    set "left_char=%~2"
    set "right_char=%~3"
    set "name=%~4"

    echo NAME "!name!"

    

    rem Need to call traverse separately with "(, )", "[, ]", and "{, }"
    rem Collecting first part of file name that preceeds the first set of encapsulated words
    rem eg. BRIDGE WORDS APPEAR BEFORE (this group) in the file name.
    call :delim_with_char "1" "!left_char!" "!name!"
    set init_bridge=
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "init_bridge=%%i"
    )

    rem echo INIT BRIDGE "!init_bridge!"
    

   
    rem THIS REM BLOCK WORKS!! KEEP THIS
     set "a=A"
     echo !a! > "%encptd%"
     call :other_encapped_check "!left_char!" "!init_bridge!"
    REM echo ----- FINISHED OTHER CHECK --------

    






    
    echo !a! > "%encptd%"
    call :at_group "!token!" "!left_char!" "!right_char!" "!name!"
    call :print_group "!name!" "!left_char!"
    echo "!brk!"
    rem call :print_bridge
    
    
    

    echo END TRAVERSE 
    echo -----------------------------
    PAUSE
    echo "!brk!"
    endlocal
exit /b



:at_group
    setlocal
    set "token=%~1"
    set "left_char=%~2"
    set "right_char=%~3"
    set "name=%~4"
    rem echo AT_GROUP FOR PRIMARY CHAR token "!token!"
    



    set next_encapped=
    rem echo MINE AT GROUP NAME "!name!" LEFT CHAR "!left_char!"
    
    rem if !token! gtr 1 (
    for /f "tokens=1 delims=|" %%i in (%encptd%) do (
        set "next_encapped=%%i"
    )
    rem )
   


    if "!next_encapped!" equ " " (
        exit /b
    )

    rem Write tokens for encapsulators
    rem call :write_tokens "!token!"


  
    call :delimit_group2 "!token!" "!left_char!" "!right_char!" "!name!"
   
    set /a token+=1 
    call :at_group "!token!" "!left_char!" "!right_char!" "!name!"

    endlocal
exit /b




:delimit_group2
    setlocal
    set "token=%~1"
    set "left_char=%~2"
    set "right_char=%~3"
    set "name=%~4"
    set "primary_left=%~5"
    set "right_token=1"
    
    call :delim_with_char "!token!" "!left_char!" "!name!"
    set one_tail=
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "one_tail=%%i"
    )

    set "one_tail=!right_char!!one_tail!"
    

    call :delim_with_char "1" "!right_char!" "!one_tail!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "one=%%i"
    )
rem echo ONE "!one!"
rem echo NON NESTED TEST "!non_nested_test!"
rem echo ONE TAIL "!one_tail!"
    if "!one!" equ " " (
        rem call :print_ones
        call :write_group
        set "one=!one!|" 
        echo !one! > "%encptd%"

        rem echo LAST TOKEN? "!token!"
        exit /b
    )


  
    echo !one! > "%encptd%"

    set "non_nested_test=!right_char!!one!!right_char!"
  


    
    rem Capturing non-nested groups (eg. "this is file has a (non-nested group) in its name )
    rem     from file names
    rem     "A file name with (non-nested group) in the file.d88" 
    
    if not exist %onstxt% (
       if "!non_nested_test! " equ "!one_tail!" (
            rem if "!left_char!" equ "!primary_left!" (
           call :write_ones "!one!"
           call :write_group
           exit /b
            rem )
       ) 
    )

            rem if "!left_char!" equ "!primary_left!" (
    call :write_ones "!one!"
            rem )
 




    rem Capturing labels within nested groups (eg. (This (is a) nested group))
    

    set last_nested=
    call :delim_with_char "2" "!right_char!" "!one_tail!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "last_nested=%%i"
    )
   

    rem Calling bridges here within encapsulated groups returns any encapsulated bridge
    REM     that appears after the last encapsulated grou words, but we want the 
    rem     the appended encapsulated bridge to be in included as
    rem Words that exist in between encapsulated groups of words
    rem eg. "This file name (has) BRIDGES (in between) THESE (groups) so save them."
    set bridge=
    call :delim_with_char "3" "!right_char!" "!one_tail!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "bridge=%%i"
    )

     rem call :write_bridge "!bridge!"
  
    rem echo ******************** last_nested "!last_nested!"
    if "!last_nested!" neq " " (
       
        rem Find any bridge words - words that exist in between groups of 
        rem     of encapsulated words
        rem     (eg. "This file (has) BRIDGE WORDS -- EXCLUDE THEM (in (between) groups) in the file")
        
        rem "This file has (a group with (word that are ) LAST_ENDED) in its name"
        call :delim_with_char "!token!" "!right_char!" "!name!"
        
        for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
            set "bridge=%%i"
        )

       
       
        call :delim_with_char "1" "!left_char!" "!bridge!"
        for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
            set "bridge=%%i"
        )

        rem A bridge word that appears after a non-nested group of words.
        rem eg. (non-nested group) APPEARS BEFORE THESE BRIDGE WORDS/LAST_ENDED -- EXCLUDE (another group)
        if "!bridge!" equ "!last_nested!" (
            set last_nested=


            rem Check the bridge to see if it is encapsulated
            rem     by other delimiting characters
            rem If so, then exclude ??
            rem save the bridges
                
            call :write_bridge "!bridge!"

        )
        
        call :write_ones "!last_nested!"
        call :write_group
    )
    
    endlocal
exit /b

:delim_with_char
    setlocal
    rem %~1: token
    rem %~2: delim char (eg. [, (, {, ], ), or })
    set "phrase=%~3"
     rem echo ---- DELIMITING "%~3"---- with "%~1" and "%~2"
    set d=
    for /f "tokens=%~1 delims=%~2" %%i in ("!phrase!") do (
        set "d=%%i"
    )

    set "d=!d!|"
    echo !d! > "%delimtxt%"
    endlocal
exit /b

:write_bridge
    setlocal
    set "bridge=%~1"

    rem echo  WRITING "!bridge!"
    set old=
    set /a item=0
    if exist %brgtxt% (

    
        for /f "tokens=*" %%i in (%brgtxt%) do (
            set "old=!old!!brk!%%i"
            set /a item+=1
        )
    )
  
    set "old=!old!!brk!!bridge!"
  
    echo !old! > "%brgtxt%"
    endlocal
exit /b


:write_nested
    setlocal
    set "nested=%~1"
    set old=
    if exist nested.txt (
        for /f "tokens=*" %%i in (nested.txt) do (
            set "old=!old! %%i"
        )
    )
    set "old=!old! !nested!"
    echo !old! > "nested.txt"
    endlocal
exit /b





:write_ones

    setlocal
    set "new=%~1"
    rem echo WRITING a NEW ONE "!new!"
    set old=
    if exist %onstxt% (
        for /f "tokens=*" %%i in (%onstxt%) do (
            set "old=!old!%%i"
        )
    )
    set "old=!old!!new!"
    rem echo ** OLD BEFORE ">" "!old!"
    echo !old! > "%onstxt%"
    endlocal
exit /b

:write_group
    setlocal
    
    set old_o=
    set /a item=0
    if exist %onstxt% (
        for /f "tokens=*" %%i in (%onstxt%) do (
            set "old_o=%%i"
        )
    )
    if exist %onstxt% (
        del "%onstxt%"
    )
    

    set old=
    if exist %grptxt% (
        for /f "tokens=*" %%i in (%grptxt%) do (
            set "old=!old!!brk!%%i"
            set /a item+=1
        )
    )
    
    rem if !item! equ 0 (
    rem     set "old=!old!!old_o!"
    rem ) else (
set "old=!old!!brk!!old_o!"
    rem )
    
    echo !old! > "%grptxt%"
    
    endlocal
exit /b

:write_tokens
    setlocal
    set "token=%~1"
   


    set old=
    if exist %toktxt% (
        for /f "tokens=*" %%i in (%toktxt%) do (
            set "old=!old!!brk!%%i"
        )
    )
    set "old=!old!!brk!!token!"
    echo !old! > "%toktxt%"
    endlocal
exit /b

:print_group
    setlocal
    set "name=%~1"
    set "primary_char=%~2"


    rem to get a pass
    rem option 1: group = ECHO is empty. & test = name (no delimiting character)
    rem option 2: group has labels (not = to ECHO is emtpy) & test not = name

    rem test must = name -> +1

    set /a n=0
    set "r=FAIL"

    call :delim_with_char "1" "!primary_char!" "!name!"
    set test=
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "test=%%i"
    )

    if "!test!" equ "!name!" (
        set /a n-=1
    ) else (
        set /a n+=1
    )

    if exist %grptxt% (
        set /a qty=0
        set grp=
        for /f "tokens=*" %%i in (%grptxt%) do (
            if !qty! equ 0 (
                set "grp=!grp!%%i"
            ) else (
                set "grp=!grp!!brk!%%i"
            )
            set /a qty+=1
        )
        
        echo --- GRUPS ----
        ECHO !grp!
        if "!grp!" equ "ECHO is off." (
            set /a n-=1
        ) else (
            set /a n+=1
        )
    )

    if !n! equ -2 (
        set "r=PASS"
    )

    if !n! equ 2 (
        set "r=PASS"
    )    
    ECHO ********************************************************************* "!r!"
    endlocal
exit /b


:print_bridge
    setlocal

    set brdg=
    if exist "%brgtxt%" (
        set /a qty=0
        for /f "tokens=*" %%i in (%brgtxt%) do (
            if !qty! equ 0 (
                set "brdg=!brdg!%%i"
            ) else (
                set "brdg=!brdg!!brk!%%i"
            )
            set /a qty+=1
        )
    )
    
    echo -- BRIDGES --
    echo !brdg!
    
    endlocal
exit /b

:print_ones
    setlocal
    set ons=
    if exist "%onstxt%" (
        set /a qty=0
        for /f "tokens=*" %%i in (%onstxt%) do (
            if !qty! equ 0 (
                set "ons=!ons!%%i" 
            ) else (
                set "ons=!ons!!brk!%%i"
            )
            set /a qty+=1
        )
    )

    echo -- ONES --
    echo !ons!
    endlocal
exit /b


rem Might not need this function, nor collecting tokens
:print_tokens
    setlocal
    set tokens_=
    for /f "tokens=*" %%i in (%toktxt%) do (
        set "tokens_=!tokens_!!brk!%%i"
    )

    endlocal
exit /b




:start
    setlocal

    if exist next.txt (
        del "next.txt"
    )
    endlocal
exit /b

:recurse_on_group
    setlocal
    if exist %delimtxt% ( del %delimtxt% )
    if exist qty.txt ( del qty.txt )
    set "token=%~1"
    set "left_char=%~2"
    set "right_char=%~3"
    set "name=%~4"
    

    set item=
    call :delim_with_char "!token!" "!right_char!" "!name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )

    if "!item!" equ " " ( exit /b )

    
    rem echo REG ITEM "!item!"
    set "pad_item=PAD !item!"
    if exist "is_nested.txt" (
        rem call :print_status "!label!" "!item!"
       
        
        call :delim_with_char "1" "!left_char!" "!item!"
        set test=
        for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
            set "test=%%i"
        )
       
        if "!item!" equ "!test!" (
            call :print_status "!test!" "!item!"
            del "is_nested.txt"
        )
    )
    
    
    call :recurse_nested_status "PAD !item!" "!left_char!" "2" "0"
    
    rem echo FOUND ITEM "!item!" "!token!"    
    set /a token+=1

   
    
    call :recurse_on_group "!token!" "!left_char!" "!right_char!" "!name!" 
    endlocal
exit /b


:recurse_nested_status
    setlocal
    set "item=%~1"
    set "left_char=%~2"
    set "token=%~3"
    set "lqty=%~4"
    
   
    
 rem echo ---- NESTED STATUS has item --- "!item!" "!left_char!" "!token!"
    
    rem set /a qty-=1

    set "orig_item=!item!"
    set "pad_item=PAD !item!"


    set label=
    call :delim_with_char "!token!" "!left_char!" "!orig_item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "label=%%i"
    )


    rem echo "FOUND item " "!item!" 
    rem echo  "label" "!label!"
    rem echo  Token "!token!"
     rem if "!label!" neq " " (
     rem call :print_status "!label!" "!item!"
     rem )
 
    if "!label!" equ " " ( 
        set /a lqty=!token!-2
        exit /b
    )   
    call :print_status "!label!" "!item!"

    set /a token+=1
    call :recurse_nested_status "!item!" "!left_char!" "!token!" "!lqty!"
    endlocal
exit /b



:print_status
    setlocal
    set "label=%~1"
    set "item=%~2"

    call :delim_with_char "3" "!left_char!" "!item!"
    set f=
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "f=%%i"
    )

    set "status=NON-NESTED"
    if "!f!" neq " " (
        set "status=NESTED"
        echo "" > "is_nested.txt"
    )

    if exist "is_nested.txt" (
        set "status=NESTED"
        call :write_nested "!label!"
    )



    echo "!label!" *** sttatus = "!status!"
    
    rem set saved=
    rem for /f "tokens=*" %%i in (save.txt) do (
    rem     set "saved=!saved!!brk!%%i"
    rem )
    rem set "saved=!saved!!brk!!label!"
    echo !saved! > "save.txt"
    if exist "save.txt" ( del "save.txt" )
    endlocal
exit /b




:nested_status
    setlocal
    set "item=%~1"
    set "left_char=%~2"

    set test=
    for /f "tokens=2 delims=%~2" %%i in ("!item!") do (
        set "test=%%i"
    )

    echo ITEM "!item!" TEST "!test!"
    set "status=NON-NESTED"

    endlocal
exit /b

:n_status
    setlocal
    endlocal
exit /b






































rem copy code begginging at line 290~
:delimit_group
    setlocal 
    set "token=%~1"
    set "left_char=%~2"
    set "right_char=%~3"
    set "name=%~4"
    set "right_token=1"
   
    call :delim_with_char "!token!" "!left_char!" "!name!"
    set one_tail=
    set two_tail=
    set three_tail=
    

    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "one_tail=%%i"
    )

    set /a token+=1
    call :delim_with_char "!token!" "!left_char!" "!name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "two_tail=%%i"
    )   


    set /a token+=1
    call :delim_with_char "!token!" "!left_char!" "!name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "three_tail=%%i"
    )   
    
    set "one_tail=)!one_tail!"
    set "two_tail=)!two_tail!"
    set "three_tail=)!three_tail!"

    if "!is_nested!" equ "T" (
        set "two_tail=X)!two_tail!"
    )

    call :delim_with_char "1" "!right_char!" "!one_tail!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "one=%%i"
    )
    call :delim_with_char "1" "!right_char!" "!two_tail!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "two=%%i"
    )
    call :delim_with_char "1" "!right_char!" "!three_tail!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "three=%%i"
    )


    set is_nested=
    for /f "tokens=1" %%i in (is_nested.txt) do (
        set "is_nested=%%i"
    )


    if "!one!" equ " " (
        set "one=!one!|"
        echo !one! > "%encptd%"
        exit /b
    )

    if "!is_nested!" equ "F" (
    rem if "!one!" equ "" (
        echo !head! > "head.txt"
        
        rem echo ------one "!one!"
        call :write_ones "!one!"
        rem echo ------two "!two!"
        rem echo ----three "!three!"
        exit /b
    )


    rem for finding third labels within the nested group
    set "two_tail=x)!two_tail!"

    call :delim_with_char "3" "!right_char!" "!two_tail!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "three=%%i"
    )

    rem Removing unwanted portions captured by three
    if "!is_nested!" equ "F" (
        set three=
    )
    
    rem echo ------one "!one!"
    rem echo ------two "!two!"
    rem echo ------three "!three!"

    
    echo !one! > "%encptd%"

    set "one=!one!!two!!three!"
    call :write_ones "!one!"
    endlocal
exit /b
















rem Delimit file or directory name with {, [, or (
rem if not delimited, skip the file or directory name
rem otherwise save group 1, 2, and possibly 3 in the directory or file name

:encaps_check
    rem 1: left bound char
    rem 2: token
    rem 3: name
    set "name=%~3"
    set "has_encaps_file=%~4"
    set "is_nested_file=%~5"
    set one_tail=

    rem determine if we have an encapsulator in the name or just skip it 
    for /f "tokens=2 delims=%~1" %%i in ("!name!") do (
        rem echo "%%i"
        set "one_tail=%%i"
    )
    rem echo FIRST ONE TAIL "!one_tail!"
    echo !one_tail! > "!has_encaps_file!"
    
    
    
    rem stop this function but does not stop iteration on the current name
    rem does the name have or have not at least 1 encasulated group
    if "!one_tail!" equ "" (
        rem echo EXITED
        exit /b
        rem goto :eof
    )
    
    rem echo !one_tail! > "!has_encaps_file!"


    if "!one_tail!" equ "!name!" (
        set one_tail=
    )


    rem This is a  test for checking nested encapsulators in first group
    rem Should revise so that we check for nested encapsulators among all groups.
    rem Should move this nested/non-nested test elsewhere
    set test=
    for /f "tokens=1 delims=%~2" %%i in ("!one_tail!") do (
        set "test=%%i"
    )

    rem echo TEST "!test!" FROM ONE TAIL "!one_tail!"

    set "is_nested=T"


    rem I think this was a remant of an original test
    rem     to identify name that has no encapsulators
    rem if "!test!" equ "" (
    rem     set "is_nested=F"
    rem )

    if "!test!" neq "!one_tail!" (
        set "is_nested=F"
    )

    
    echo !is_nested! > "!is_nested_file!"
exit /b


:disk_count_
    set "ext=%~1"
    rem set "dest_dir=%~2"
    set "file=%~2"
    set /a ct=0

    if "!ext!" equ ".d88" (
        set /a ct+=1
    )
    if "!ext!" equ ".t88" (
        set /a ct+=1
    )
    if "!ext!" equ ".cmt" (
        set /a ct+=1
    )

    echo !ct! > "!file!"
exit /b





:save_group_and_file
    set "root=%~1"
    set "l_only=%~2"
    set "l_anfl=%~3"
    set "group=%~4"
    set "name=%~5"
    echo ------------------------------------------------------------------------------------
    echo "!root!\!l_only!" has "!group!"
    if not exist "!root!\!l_only!\!group!" (
        echo "!root!\!l_anfl!\!group!" has "!name!"
    )

    rem echo SAVE THE INDIV "!indiv_this!" LIST ONLY AT  "!root_dir!\!indv_grp!\!lst_o!"
    exit /b    
    rem call "funcs_no_make.bat" :file_into_dir "!dest_dir!" "!group!"
exit /b


:save_combo_group
    set "dest_dir=%~1"
    set ""
exit /b


:target_in_group
    set "group=%~1"


    set /a qty=0
    set a1=
    set a2=
    set a3=
    set a4=
    set a5=
    set a6=
    set a7=
    set a8=
    set a9=
    set a10=

    for /f "tokens=1 delims= " %%i in ("!labels!") do (
        set "a1=%%i"
    )
    for /f "tokens=2 delims= " %%i in ("!labels!") do (
        set "a2=%%i"
    )
    for /f "tokens=3 delims= " %%i in ("!labels!") do (
        set "a3=%%i"
    )
    for /f "tokens=4 delims= " %%i in ("!labels!") do (
        set "a4=%%i"
    )
    for /f "tokens=5 delims= " %%i in ("!labels!") do (
        set "a5=%%i"
    )
    for /f "tokens=6 delims= " %%i in ("!labels!") do (
        set "a6=%%i"
    )
    for /f "tokens=7 delims= " %%i in ("!labels!") do (
        set "a7=%%i"
    )
    for /f "tokens=8 delims= " %%i in ("!labels!") do (
        set "a8=%%i"
    )
    for /f "tokens=9 delims= " %%i in ("!labels!") do (
        set "a9=%%i"
    )
    for /f "tokens=10 delims= " %%i in ("!labels!") do (
        set "a10=%%i"
    )



exit /b


:echo_dirs
    set "prim_dirs=%~1"
    set "sec_dirs=%~2"

    set prnth=
    set sqr_brkt=
    set curl_brkt=
    for /f "tokens=3 delims=|" %%i in ("!prim_dirs!") do (
        set "prnth=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!prim_dirs!") do (
        set "sqr_brkt=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("!prim_dirs!") do (
        set "curl_brkt=%%i"
    )

    set rkeywd=
    set lst_o=
    set lst_anfl=
    set indv_grp=
    set cmbo_grp=

    for /f "tokens=11 delims=|" %%i in ("!sec_dirs!") do (
        set "rkeywd=%%i"
    )

    for /f "tokens=12 delims=|" %%i in ("!sec_dirs!") do (
        set "lst_o=%%i"
    )
    for /f "tokens=13 delims=|" %%i in ("!sec_dirs!") do (
        set "lst_anfl=%%i"
    )
    for /f "tokens=14 delims=|" %%i in ("!sec_dirs!") do (
        set "indv_grp=%%i"
    )
    for /f "tokens=15 delims=|" %%i in ("!sec_dirs!") do (
        set "cmbo_grp=%%i"
    )

    echo DEST DIR "!dest_dir!"
    echo RKEYWORD "!rkeywd!"
    echo L only "!lst_o!"
    echo LAF "!lst_anfl!"
    echo INDV GRP "!indv_grp!"
    echo COMBO GRP "!cmbo_grp!"
exit /b

















































rem we CAN DELETE ALL OF THE CODE BELOW

:curl
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"
    set "ext=%~4"
    set /a ct=0

    rem echo "!name!"
    set f=accepted_disk_ext_qty.txt
    call "funcs_no_make.bat" :file_into_dir "!dest_dir!" "!f!"
    call :disk_count "!ext!" "!dest_dir!" "!f!"


    for /f "tokens=*" %%i in (!dest_dir!\!f!) do (
        set /a "ct=%%i"
    )
  
    if !ct! equ 0 (
        rem echo ZERO
        exit /b
    )

    call :kywd "{" "}" "%~1" "!sec_dirs!" "!dest_dir!"

exit /b


:sqr
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"
    set /a ct=0

    rem echo "!name!"
    set f=accepted_disk_ext_qty.txt
    call "funcs_no_make.bat" :file_into_dir "!dest_dir!" "!f!"
    call :disk_count "!ext!" "!dest_dir!" "!f!"


    for /f "tokens=*" %%i in (!dest_dir!\!f!) do (
        set /a "ct=%%i"
    )
    del "!dest_dir!\!f!"
    rem echo ct "!ct!"

    rem exit /b
  
    if !ct! equ 0 (
        exit /b
    )
    call :kywd "[" "]" "%~1" "!sec_dirs!" "!dest_dir!"

exit /b

:parenths
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"

    set /a ct=0

    rem echo "!name!"
    set f=accepted_disk_ext_qty.txt
    call "funcs_no_make.bat" :file_into_dir "!dest_dir!" "!f!"
    call :disk_count "!ext!" "!dest_dir!" "!f!"


    for /f "tokens=*" %%i in (!dest_dir!\!f!) do (
        set /a "ct=%%i"
    )
    del "!dest_dir!\!f!"
    rem echo ct "!ct!"

    rem exit /b
  
    if !ct! equ 0 (
        exit /b
    )
    call :kywd "(" ")" "%~1" "!sec_dirs!" "!dest_dir!"

exit /b




:disk_count
    set "ext=%~1"
    set "dest_dir=%~2"
    set "file=%~3"
    set /a ct=0

    if "!ext!" equ ".d88" (
        set /a ct+=1
    )
    if "!ext!" equ ".t88" (
        set /a ct+=1
    )
    if "!ext!" equ ".cmt" (
        set /a ct+=1
    )

    echo !ct! > "!dest_dir!\!file!"
exit /b



:kywd
    set "name=%~3"
    set "sec_dirs=%~4"
    set "dest_dir=%~5"

    rem Definitions:
    rem left bound delimiter: eg. "(", "[", or "{"
    rem right bound delimiter: eg ")" "]", or "}"
    
    rem Variables to store any groups of encapsulated words
    rem     found in the directory or file name
    set one=
    set two=

    rem Using a "left bound" delimiting character (eg. "(", "[", or "{")
    rem     to find the first group of
    rem     encapsulated words in the directory or file name,
    rem     along with any other words that appear after that group
    rem     of encapsulated words.
    rem "This is a file name (with label L).txt" -> "with label L).txt" 
    for /f "tokens=2 delims=%~1" %%i in ("!name!") do (
        set "one=%%i"
    )


    rem To account for directory or file names that do not contain
    rem     any encapsulated words within the title.
    rem We receive the entire directory or file name when no
    rem     encapsulated words are found when using the 
    rem     delimiting character to partion the directory or file
    rem     name.
    rem If we receive an exact copy of the origina file namme, delete
    rem     that copy from memory.
    rem "This is a file name without a label L.txt" -> "This is a file name without a label L.txt" -> ""
    if "!one!" equ "%~3" (
        set one=
    )

    rem Using a right-bound delimiting character to partition
    rem     the outcome of using the initial left-bound delimiting character
    rem     on the file name.
    rem "with label L).txt" -> "with label L"
    for /f "tokens=1 delims=%~2" %%i in ("!one!") do (
        set "two=%%i"
    )

    rem Assume the directory or file name contains a set of nested
    rem     delimiting characters.
    set "is_nested=T"

    rem To account for a directory or file name with at least 1 group 
    rem     of encapsulated words, such as:
    rem         1. "file (with a label).txt",
    rem         2. "file (with) two (labels).txt,
    rem         3. "file (with) three (different) (labels).txt")
    rem         4. "file with no lables.txt"
    rem         All do not contain any nested delimiters (encapsulated words)



    rem To account for a directory or file name with no delimiting charcters
    rem     (eg. "This is a file or directory name without lables.txt")
    rem         All do not contain any nested delimiters (encapsulated words)
    if "!two!" equ "" (
        set "is_nested=F"
    )


    rem To account for a directory or file name with at least 1 group 
    rem     of encapsulated words, such as:
    rem         1. "file (with a label).txt",
    rem         2. "file (with) two (labels).txt,
    rem         3. "file (with) three (different) (labels).txt")
    rem         All do not contain any nested delimiters (encapsulated words)

    rem "This is a file name (with label L).txt" -> "with label L).txt" -> "with label L"
    rem (eg. "with label L" is not equivalent to "with label L).txt")
    if "!two!" neq "!one!" (
        set "is_nested=F"
    )

    call :extract "%~1" "%~2" "!name!" "!sec_dirs!" "!dest_dir!" "!is_nested!"
exit /b

:extract

    set "name=%~3"
    set "sec_dirs=%~4"
    set "dest_dir=%~5"
    set "is_nested=%~6"
    

    rem A file or directory name can have 0 or up to 3
    rem     groups of encapsulated words, where each
    rem     encapsulated groups of words, can contain 1 or more words
    rem     within that encapsulated group.

    rem 3 groups of encapsulated words and combine the groups to find
    rem     the string of all encapsulated words, and use this string as 
    rem     the label associated with the directory or file name.
    set one=
    set two=
    set three=

    rem The group of encapsulated words and any other words
    rem     (labels and non-labels) that follow words in the
    rem     desired group of encapsulated words.
    set one_tail=
    set two_tail=
    set three_tail=

    rem Collecting Labels from Group 1 and possibly 
    rem     non-lables appearing before the next group of
    rem     encapsulated labels.
    for /f "tokens=2 delims=%~1" %%i in ("!name!") do (
        set "one_tail=%%i"
    )
    
 





    rem Account for a directory or file name
    rem     without encapsulated words because of the absence
    rem     of a left-bound delimiting character in the file name.
    rem We can end this function because the directory or file name
    rem     does not contain any labels.
    if "!one_tail!" equ "" (
        set one_tail=
        rem echo stop "!name!" the function here because there is no need to look for non-existent labels
        rem read the qty files
        rem delete the qty files,
        rem  and write the name, labels, and qtys in the list
        set "encaps=%~1!one!%~2 %~1!two!%~2 %~1!three!%~2"
        call :item "!one!" "!two!" "!three!" "!dest_dir!" "!name!"
        rem call :itemize "%~1" "%~2" "!name!" "!encaps!" "!g_qty_path!" "!dest_dir!" "LONG_AND_LARGE"
        exit /b
    )




rem This needs to be its own function
rem This function receives, 
rem     the intended group label (eg: 1, 2, or 3)
rem     Counts the number of delimited labels using the empty character
rem     Writes the lables for the intended group to a file
rem     Writes the number of all lables within this group to a separate file

rem After calling this function for each of the three groups,
rem     then need to use a different function to read all of these previosuly
rem     created files to create the file entry for the 
rem     filename ______ labels for all 3 groups ____ and their respective label quantities






    rem TEST TO SEE IF WE CAN EXIT THIS FUNCTION WHEN NO LABLES
    REM exist the directory and file name
    rem Then we can write the name to file as described below
    rem to shorten the scripts running time

    rem Finding the first group of labels (encapsulated words)
    rem     in the directory or file name.
    for /f "tokens=1 delims=%~2" %%i in ("!one_tail!") do (
        set "one=%%i"
    )


    rem To account if the first group of encapsulated words 
    rem     is an example of a set of nested encapsulators
    rem     (eg. "this is a file (with (a nested) label).txt")
    for /f "tokens=1 delims=%~1" %%i in ("!one!") do (
        set "one=%%i"
    )



    rem Write data for the first group only, to file
    rem call :save_word_count "%~1" "%~2" "1" "!one!" "!g_qty_path!"






    rem          Find Group 2
    for /f "tokens=3 delims=%~1" %%i in ("!name!") do (
        set "two_tail=%%i"
    )

    rem Account for circumstances where the file or directory
    rem     name only has 1 group of lables.
    rem If so, then read the label quantities for the 
    rem     first group (0 to n lables)
    rem     second group (always 0)
    rem     and the third group (always 0).
    
    rem Then terminate the function.
    if "!two_tail!" equ "" (
        rem set two_tail=
        rem STOP THE FUNCTION HERE
        set "encaps=%~1!one!%~2 %~1!two!%~2 %~1!three!%~2"
        call :item "!one!" "!two!" "!three!" "!dest_dir!" "!name!"

       
       

        rem call :itemize "%~1" "%~2" "!name!" "!encaps!" "!g_qty_path!" "!dest_dir!" "LONG_AND_LARGE"

        exit /b
    )

    for /f "tokens=1 delims=%~2" %%i in ("!two_tail!") do (
        set "two=%%i"
    )

    rem Account for a directory or file name that contains 
    rem     nested lables or non-nested lables, and change the name
    rem     so we can retrieve the third group of lables using
    rem     the same delimiting character and token value
    rem     for the intended partition of the string.
    if "!is_nested!" equ "T" (
        set "name=(!name!"
    )

    rem Saving for Group 2
    rem call :save_word_count "%~1" "%~2" "2" "!two!" "!g_qty_path!"






    
    rem                 Group 3
    for /f "tokens=4 delims=%~1" %%i in ("!name!") do (
        set "three_tail=%%i"
    )

    if "!three_tail!" equ "" (
        set "encaps=%~1!one!%~2 %~1!two!%~2 %~1!three!%~2"
        rem call :itemize "%~1" "%~2" "!name!" "!encaps!" "!g_qty_path!" "!dest_dir!" "LONG_AND_LARGE"
        call :item "!one!" "!two!" "!three!" "!dest_dir!" "!name!"


        exit /b
    )

    rem Adjust the string to account for directory or
    rem     file names with or without nested lables,
    rem     both of which are unchanged, would require using differnet
    rem     token numbers to partition three_tail with the same 
    rem     delimiting character.
    if "!is_nested!" equ "F" (
        set "three_tail=X)!three_tail!"
    )
   

    if "!is_nested!" equ "T" (
         set "three_tail=!two_tail!"
    )
    
    for /f "tokens=2 delims=%~2" %%i in ("!three_tail!") do (
        set "three=%%i"
    )


    rem call :save_word_count "%~1" "%~2" "3" "!three!" "!g_qty_path!"


    set "encaps=%~1!one!%~2 %~1!two!%~2 %~1!three!%~2"
    call :item "!one!" "!two!" "!three!" "!dest_dir!" "!name!"

    rem call :itemize "%~1" "%~2" "!name!" "!encaps!" "!g_qty_path!" "!dest_dir!" "LONG_AND_LARGE"
    rem NEED TO EXIT THE FUNCTION 

exit /b

:item
    set "one=%~1"
    set "two=%~2"
    set "three=%~3"
    set "dest_dir=%~4"
    set "name=%~5"
    call :do_ "!dest_dir!" "!one!" "!name!"
    call :do_ "!dest_dir!" "!two!" "!name!"
    call :do_ "!dest_dir!" "!three!" "!name!"
   
exit /b

:do_
    set "dest_dir=%~1"
    set "group=%~2"
    set "name=%~3"
    
    
    if "!group!" neq "" (
        call "funcs_no_make.bat" :file_into_dir "!dest_dir!\!group!" "!name!"
    )
exit /b