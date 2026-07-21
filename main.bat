@ echo off
@ setlocal EnableDelayedExpansion
set brk=^



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

@ set "args=%src%|%u_scor%|%prnth%|%sqr_brkt%|%curl_brkt%|%exts%|%cmpltd%"
@ set "lm=LIST_MADE"
@ set "ers=ERRORS"
set "no_encaps=NO_ENCAPSULATED"

set /a q=0

echo PRINTING MESSAGE

rem pause
rem goto :eof
@ rem call "funcs_msg.bat" :after_list "%args%"
@ rem pause
@ rem goto :eof


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
@ call "funcs_msg.bat" :before_list "%args%"
pause
@ call "funcs_list.bat" :list_gen "%args%" "%lm%" "%no_encaps%"
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