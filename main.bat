@ setlocal EnableDelayedExpansion

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

echo PRINTING MESSAGE
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
echo hi
@ call "funcs_msg.bat" :before_list "%args%"
pause
@ rem @ call "funcs_list.bat" :list_gen "%args%" "%lm%"
@ call "funcs_msg.bat" :after_list "%args%"
pause
echo > "%lm%"
    @ goto :eof
)

echo NEED MORE MESSAGES

    @ rem  NEED TO SEARCH FOR EMPTY DIRS IN UNDERSCORES & BRACKETS
    @ rem @ call "funcs_analyze.bat" :empty_check "%sqr_brkt%" "%ers%"
    @ rem @ call "funcs_analyze.bat" :empty_check "%curl_brkt%" "%ers%"
    @ rem @ call "funcs_analyze.bat" :empty_check "%prnth%" "%ers%"

    @ rem Change underscored file first, then change directories
    @ rem ... to use incorrect directories as look up method in src.

    @ rem call "funcs_analyze.bat" :underscore_file "%src%" "%u_scor%\FILE"
    @ rem call "funcs_analyze.bat" :underscore_dir "%src%" "%u_scor%\DIR"



echo END OF MAIN
pause
goto :eof


:ers_check

if exist "%ers%" (
    ECHO FOUND AN EMPTY
) else (
    echo NO EMPTIES
)
exit /b

:mofo
    echo BYE
exit /b