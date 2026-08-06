@ echo off
@ setlocal EnableDelayedExpansion
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

@ set "src=..\ARCHV_RECON"
@ set "u_scor=UNDERSCORES"
@ set "prnth=PARENTHESES"
@ set "sqr_brkt=SQUARE_BRACKETS"
@ set "curl_brkt=CURLY_BRACKETS"
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
set "args2=%quan%|%zeros%|%singl%|%doubl%|%tripl%|%encaptor%|%prelm%|%labl%|%encapted%|%akeywd%"
@ set "lm=LIST_MADE"
@ set "ers=ERRORS"
set "no_encaps=NO_ENCAPSULATED"

rem TESTING NO TOKENS TO FIND RESULT - RETURN ALL STATEMENT OR NOTHING?
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

echo A "!a!" "!aone!" "!atwo!"
echo B "!b!" "!bone!" "!btwo!"
rem pause
rem exit /b

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