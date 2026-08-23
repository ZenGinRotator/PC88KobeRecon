@ echo off
@ setlocal EnableDelayedExpansion
set "equ_border=****************************************************************************************************************************************************************************"
rem need nested [] () and {}
rem need indiv [] () and {} - single and multi-word?

set none_blank=
set "none_full=file name without labels"

set "nest_pare_one=(this is (a nested) (par set) one)"
set "nest_pare_two=(this is (a nested) (par set) two)"
set "nest_pare_three=(this is (a nested) (par set) three)"

set "nest_curl_one={this is {a nested} {curl set} one}"
set "nest_curl_two={this is {a nested} {curl set} two}"
set "nest_curl_three={this is {a nested} {curl set} three}"

set "nest_sqr_one=[this is [a nested] [sqr set] one]"
set "nest_sqr_two=[this is [a nested] [sqr set] two]"
set "nest_sqr_three=[this is [a nested] [sqr set] three]"

set "indiv_pare_one=(indiv pare one)"
set "indiv_pare_two=(indiv pare two)"
set "indiv_pare_three=(indiv pare three)"

set "indiv_curl_one={indiv curl one}"
set "indiv_curl_two={indiv curl two}"
set "indiv_curl_three={indiv curl three}"


set "indiv_sqr_one=[indiv sqr one]"
set "indiv_sqr_two=[indiv sqr two]"
set "indiv_sqr_three=[indiv sqr three]"


set "brid_one=bridge 1"
set "brid_two=bridge 2"
set "brid_three=bridge 3"
set "brid_four=bridge 4"

set brk=^




rem GROUPER can be:
rem 1. PARENTHESES
rem 2. CURLY_BRACKETS
rem 3. SQUARE_BRACKETS

rem OBJECT can be:
rem 1. FILE
rem 2. DIR


rem More directories
rem ENCAPSULATOR/OBJECT/PRELIM_LABELS
rem ENCAPSULATOR/OBJECT/QUANTITY/ENCAPSULATOR
rem ENCAPSULATOR/OBJECT/QUANTITY/ENCAPSULATED

REM GROUPER/OBJECT/KEYWORDS/


@ rem Use as arguments
@ rem src: Need to traverse directory when making list and
@ rem      when identifying directories without extracted files
@ rem      An empty directory is an indicator of a bug when creating
@ rem      a list.
@ rem u_score: Traverse this directory to remove underscores
@ rem          from directory and file names

@ set "src=..\ARCHV_RECON2"
@ set "u_scor=UNDERSCORES"
@ set "prnth=PARENTHESES2"
@ set "sqr_brkt=SQUARE_BRACKETS2"
@ set "curl_brkt=CURLY_BRACKETS2"
@ set "exts=EXTENSIONS"
@ set "cmpltd=COMPLETE"
set "quan=QUANTITIES"
set "zeros=NONES"
set "singl=SINGLES"
set "doubl=DOUBLES"
set "tripl=TRIPLES"
set "encaptor=ENCAPSULATOR"
set "encapted=ENCAPSULATED"
set "labl=LABELS"
set "prelm=PRELIMINARY"
set "akeywd=ALL_KEYWORDS"
set "rkeywd=ROM_KEYWORDS"
set "lst_o=LISTED_ONLY"
set "lst_anfl=LISTED_AND_FILE"
set "indv_grp=INDIV_GROUP"
set "cmbo_grp=COMBO_GROUP"
rem parentheses/quantity
    rem file
        rem singles 
        rem doubles
        rem triples
        rem largest_x.txt
    rem dir
        rem singles 
        rem doubles
        rem triples
        rem largest_x.txt

REM
@ set "args=%src%|%u_scor%|%prnth%|%sqr_brkt%|%curl_brkt%|%exts%|%cmpltd%"
set "args2=%quan%|%zeros%|%singl%|%doubl%|%tripl%|%encaptor%|%prelm%|%labl%|%encapted%|%akeywd%|%rkeywd%|%lst_o%|%lst_anfl%|%indv_grp%|%cmbo_grp%"
@ set "lm=LIST_MADE"
@ set "ers=ERRORS"
set "no_encaps=NO_ENCAPSULATED"

rem TESTING NO TOKENS TO FIND RESULT - RETURN ALL STATEMENT OR NOTHING?
REM call :print

REM call :out "something has"
set xxx=
for /f "tokens=1" %%i in (out.txt) do (
    set "xxx=%%i"
)
REM echo XXX "!xxx!"
set "tok=2"
set r=
for /f "tokens=2 delims= " %%i in ("something has") do (
    set "r=%%i"
)

REM echo r "!r!"
rem call :something_has "2"
set vvv=
    for /f "tokens=2 delims=(" %%i in ("some") do (
        echo  vvv "%%i"
        set "vvv=%%%i"
    )
     for /f "tokens=1 delims=(" %%i in ("some(") do (
       rem echo "%%i"
        set "t=%%i"
    )

    rem echo vvv "!vvv!"
    rem echo t "!t!"
    rem echo f
 pause
 rem call "funcs_rom_keywords.bat" :traverse "2" "(" ")" "x y z"
 rem pause
 rem goto :eof

 set "isp_bar=is|phrase"
set "isp_none=isphrase"
echo VERIFY DELIMITING USING 
call :v_bar "!isp_bar!"
call :v_bar "!isp_none!"
pause

rem call :all_bridges
rem call :no_bridges
rem call :neighb
call :samples
ECHO ---- DONE ----
  pause
goto :eof

set "a=hiby"
set aone=
set atwo=
for /f "tokens=1 delims=|" %%i in ("!a!") do (
    set "aone=%%i"
)
for /f "tokens=2 delims=|" %%i in ("!a!") do (
    set "atwo=%%i"
)
set "b=x|y"
set bone=
set btwo=
for /f "tokens=1 delims=|" %%i in ("!b!") do (
    set "bone=%%i"
)
for /f "tokens=2 delims=|" %%i in ("!b!") do (
    set "btwo=%%i"
)

rem echo A "!a!" "!aone!" "!atwo!"
rem echo B "!b!" "!bone!" "!btwo!"
rem pause
rem exit /b
rem set "ab= a b|"
rem set "ba=b a "

echo !ab! > "disk.txt"
for /f "tokens=*" %%i in (disk.txt) do (
    echo "%%i"
    set "ab=%%i"
)
for /f "tokens=1 delims=|" %%i in ("!ab!") do (
    set "ab=%%i"
)

echo "!ab!"
rem md "!ab!"
md "!ab!"
md "!ba!"
rem pause
rem goto :eof

rem PAUSE
rem goto :eof
if not exist "%lm%" (

@ rem UNDERSCORES/DIR/*
@ REM UNDERSCORES/FILE/ROM_DIR/*
@ rem What if directory and its files both have underscores in the title?
@ rem Reasoning:
@ rem Make a list of all directories and files having underscores at the same time
@ rem ... is a problem
@ rem Need to remove underscores from every title before attempting to 
@ rem ... remove underscores from all files; especially files from directories 
@ rem ... that also have underscores

rem Need to implement references to quantitity directory within
rem ... messages.
@ call "funcs_msg.bat" :before_list "%args%"
pause
@ call "funcs_list.bat" :list_gen "%args%" "!args2!"
@ call "funcs_msg.bat" :after_list "%args%"
pause
echo > "%lm%"
    @ goto :eof
)

@ call "funcs_msg.bat" :before_analyze "%args%"
pause
call :pause


@ rem  NEED TO SEARCH FOR EMPTY DIRS IN UNDERSCORES & BRACKETS
call "funcs_analyze.bat" :empty_check "%sqr_brkt%" "%ers%"
call "funcs_analyze.bat" :empty_check "%curl_brkt%" "%ers%"
call "funcs_analyze.bat" :empty_check "%prnth%" "%ers%"




    @ rem Change underscored file first, then change directories
    @ rem ... to use incorrect directories as look up method in src.

call "funcs_analyze.bat" :underscore_file "%src%" "%u_scor%\FILE"
call "funcs_analyze.bat" :underscore_dir "%src%" "%u_scor%\DIR"
    

call "funcs_msg.bat" :after_analyze
echo END OF MAIN

pause
goto :eof

:pause
    echo .... PROCESSING. PLEASE WAIT.....
exit /b

:print
    echo PRINT
    if not exist "print.txt" (
        echo 0 > "print.txt"
    )

    set /a ct=0
    for /f "tokens=*" %%i in (print.txt) do (
        set /a ct=%%i
    )

    if !ct! equ 5 (
        echo FINISHED
        exit /b
    )
    set /a ct+=1
    echo !ct! > "print.txt"
    call :print
exit /b

:out
    echo %~1 > "out.txt"
exit /b

:something_has
    set r=
    for /f "tokens=%~1 delims= " %%i in ("soemthing has") do (
        set "r=%%i"
    )

    echo R "!r!"

exit /b

:samples
    setlocal
    rem call :none ""
    rem call :none ".d88"
    call :same ""
    call :same ".d88"
    REM call :alternating ""
    REM call :alternating ".d88"
    endlocal
exit /b

:none
    setlocal
    set "ext=%~1"
    call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "%none_blank%!ext!"
    call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "%none_full%!ext!"
    endlocal
exit /b

REM CAUSES AN ERROR
REM FILE "X (indiv pare one)(indiv pare two)"
REM PRIMARY "("
REM OPT 1 "[ ]"
REM OPT 2 "{ }"
REM --- GRUPS ----
REM indiv pare one indiv pare two (these need to be on separate lines in txt file)
:same
    setlocal
    set "ext=%~1"
    call :same_perms "%nest_pare_one%" "%nest_pare_two%" "%nest_pare_three%" "!ext!"

    call :same_perms "%indiv_pare_one%" "%indiv_pare_two%" "%indiv_pare_three%" "!ext!"

    call :same_perms "%nest_curl_one%" "%nest_curl_two%" "%nest_curl_three%" "!ext!"

    call :same_perms "%indiv_curl_one%" "%indiv_curl_two%" "%indiv_curl_three%" "!ext!"

    call :same_perms "%nest_sqr_one%" "%nest_sqr_two%" "%nest_sqr_three%" "!ext!"

    call :same_perms "%indiv_sqr_one%" "%indiv_sqr_two%" "%indiv_sqr_three%" "!ext!"
    endlocal
exit /b

:same_perms
    setlocal
    set "one=%~1"
    set "two=%~2"
    set "three=%~3"
    set "ext=%~4"

    call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "X !one!!ext!"
    call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "X !one!!two!!ext!"
    call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "X !one!!two!!three!!ext!"

    endlocal
exit /b

:alternating
    setlocal
    set "ext=%~1"

    rem LEADING NON-NESTED PARE, FOLLOW NESTED PARE
    call :lead_and_follow "%indiv_pare_one%" "%indiv_pare_two%" "%indiv_pare_three%" "%nest_pare_one%" "%nest_pare_two%" "!ext!"

    rem LEADING NON-NESTED PARE, FOLLOW NESTED CURL
    call :lead_and_follow "%indiv_pare_one%" "%indiv_pare_two%" "%indiv_pare_three%" "%nest_curl_one%" "%nest_curl_two%" "!ext!"

    REM LEADING NON-NESTED PARE, FOLLOW NESTED SQR
    call :lead_and_follow "%indiv_pare_one%" "%indiv_pare_two%" "%indiv_pare_three%" "%nest_sqr_one%" "%nest_sqr_two%" "!ext!"

    rem LEADING NON-NESTED CURL, FOLLOW NESTED PARE
    call :lead_and_follow "%indiv_curl_one%" "%indiv_curl_two%" "%indiv_curl_three%" "%nest_pare_one%" "%nest_pare_two%" "!ext!"
    
    REM LEADING NON-NESTED CURL, FOLLOW NESTED CURL
    call :lead_and_follow "%indiv_curl_one%" "%indiv_curl_two%" "%indiv_curl_three%" "%nest_curl_one%" "%nest_curl_two%" "!ext!"
    
    REM LEADING NON-NESTED CURL, FOLLOW NESTED SQR
    call :lead_and_follow "%indiv_curl_one%" "%indiv_curl_two%" "%indiv_curl_three%" "%nest_sqr_one%" "%nest_sqr_two%" "!ext!"
    
    rem LEADING NON-NESTED SQR, FOLLOW NESTED PARE
    call :lead_and_follow "%indiv_sqr_one%" "%indiv_sqr_two%" "%indiv_sqr_three%" "%nest_pare_one%" "%nest_pare_two%" "!ext!"

    REM LEADING NON-NESTED SQR, FOLLOW NESTED CURL
    call :lead_and_follow "%indiv_sqr_one%" "%indiv_sqr_two%" "%indiv_sqr_three%" "%nest_curl_one%" "%nest_curl_two%" "!ext!"

    REM LEADING NON-NESTED SQR, FOLLOW NESTED SQR
    call :lead_and_follow "%indiv_sqr_one%" "%indiv_sqr_two%" "%indiv_sqr_three%" "%nest_sqr_one%" "%nest_sqr_two%" "!ext!"

    rem LEADING NESTED PARE, FOLLOW NON-NESTED PARE
    call :lead_and_follow "%nest_pare_one%" "%nest_pare_two%" "%nest_pare_three%" "%indiv_pare_one%" "%indiv_pare_two%" "!ext!"

    rem LEADING NESTED PARE, FOLLOW NON-NESTED CURL
    call :lead_and_follow "%nest_pare_one%" "%nest_pare_two%" "%nest_pare_three%" "%indiv_curl_one%" "%indiv_curl_two%" "!ext!"

    rem LEADING NESTED PARE, FOLLOW NON-NESTED SQR
    call :lead_and_follow "%nest_pare_one%" "%nest_pare_two%" "%nest_pare_three%" "%indiv_sqr_one%" "%indiv_sqr_two%" "!ext!"

    REM LEADING NESTED CURL,  FOLLOW NON-NESTED PARE
    call :lead_and_follow "%nest_curl_one%" "%nest_curl_two%" "%nest_curl_three%" "%indiv_pare_one%" "%indiv_pare_two%" "!ext!"

    REM LEADING NESTED CURL, FOLLOW NON-NESTED CURL
    call :lead_and_follow "%nest_curl_one%" "%nest_curl_two%" "%nest_curl_three%" "%indiv_curl_one%" "%indiv_curl_two%" "!ext!"

    REM LEADING NESTED CURL, FOLLOW NON-NESTED SQR
    call :lead_and_follow "%nest_curl_one%" "%nest_curl_two%" "%nest_curl_three%" "%indiv_sqr_one%" "%indiv_sqr_two%" "!ext!"

    REM LEADING NESTED SQR,  FOLLOW NON-NESTED PARE
    call :lead_and_follow "%nest_sqr_one%" "%nest_sqr_two%" "%nest_sqr_three%" "%indiv_pare_one%" "%indiv_pare_two%" "!ext!"

    REM LEADING NESTED SQR, FOLLOW NON-NESTED CURL
    call :lead_and_follow "%nest_sqr_one%" "%nest_sqr_two%" "%nest_sqr_three%" "%indiv_curl_one%" "%indiv_curl_two%" "!ext!"

    REM LEADING NESTED SQR, FOLLOW NON-NESTED SQR
    call :lead_and_follow "%nest_sqr_one%" "%nest_sqr_two%" "%nest_sqr_three%" "%indiv_sqr_one%" "%indiv_sqr_two%" "!ext!"
    endlocal
exit /b

:lead_and_follow
    setlocal
    set "lead_one=%~1"
    set "lead_two=%~2"
    set "lead_three=%~3"
    set "middle_one=%~4"
    set "middle_two=%~5"
    set "ext=%~6"

    call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "X!lead_one!!middle_one!!lead_two!!ext!"
    call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "X!lead_one!!middle_one!!lead_two!!middle_two!!lead_three!!ext!"


    endlocal
exit /b



:all_bridges
setlocal
 set "a1=(a a (b b) c c)"
 set "d1=(double)"
 set "s1=(single)"
 set "e1=(e e (f f) (g g) h h)"

echo "%equ_border%"
call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z z y [x] S T { c c } { d d } FART {e e} [x] [m m [n n] [o o] [p p] q q] BRO  {fix it} !a1! [E E]"
echo "%equ_border%"
 rem goto :eof
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z [x] [x] [m m [n n] [o o] [p p] q q]  [m m [n n] [o o] [p p] q q] !a1!"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z[m m [n n] [o o] [p p] q q] BRO !a1! C !d1! [E] !s1! [Belly] B !e1!.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z [x] [x] [m m [n n] [o o] [p p] q q] BRO [m m [n n] [o o] [p p] q q] !a1!"
echo "%equ_border%"
  call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr  "Y Z !a1! C !d1! E !s1! B !e1!X.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr  "Y Z !a1! C !d1! E !e1! B !s1!.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !a1! C !d1! E !e1! B !s1!X.d88"
echo "%equ_border%"
call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr  "Y Z !d1! C !a1! E !s1! B !e1!.d88"
echo "%equ_border%"
call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !d1! C !a1! E !s1! B !e1!X.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !d1! C !a1! E !e1! B !s1!.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !d1! C !a1! E !e1! B !s1!X.d88"
echo "%equ_border%"

endlocal
exit /b

:no_bridges
setlocal
 set "a1=(a a (b b) c c)"
 set "d1=(double)"
 set "s1=(single)"
 set "e1=(e e (f f) (g g) h h)"
 echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !a1!  !d1! !s1! !e1!.d88"
echo "%equ_border%"
  call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !a1!  !d1! !s1! !e1!X.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !a1!  !d1! !e1! !s1!.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !a1!  !d1! !e1! !s1!X.d88"
echo "%equ_border%"
call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !d1!  !a1! !s1! !e1!.d88"
echo "%equ_border%"
call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !d1!  !a1! !s1! !e1!X.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !d1!  !a1! !e1! !s1!.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !d1!  !a1! !e1! !s1!X.d88"
echo "%equ_border%"

endlocal
exit /b

:neighb

setlocal
 set "a1=(a a (b b) c c)"
 set "d1=(double)"
 set "s1=(single)"
 set "e1=(e e (f f) (g g) h h)"

echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !d1! !s1! !e1! !a1!.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !d1! !s1! !e1! !a1!X.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !a1! C !e1! E !d1! B !s1!.d88"
echo "%equ_border%"
 call "funcs_rom_keywords.bat" :trav_parenth_curl_sqr "Y Z !a1! C !e1! E !d1! B !s1!X.d88"
echo "%equ_border%"

endlocal
exit /b 

:border_and_file
    setlocal
    set "file=%~1"
    echo "%equ_border%"
    call "funcs_rom_keywords.bat" : trav_parenth_curl_sqr "!file!"
    endlocal
exit /b    


:v_bar
    setlocal
    set "phrase=%~1"
    set token1=
    set tokn2=
    
    for /f "tokens=1 delims=|" %%i in ("!phrase!") do (
        set "token1=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!phrase!") do (
        set "token2=%%i"
    )

    echo ORIGIN "!phrase!"
    echo TOKEN = 1 "!token1!"
    echo TOKEN = 2 "!token2!"


    endlocal
exit /b
