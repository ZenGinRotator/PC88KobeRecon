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
@ set "brkt=BRACKETS"

@ set "args=%src%|%u_scor%|%prnth%|%brkt%"
@ set "lm=LIST_MADE"
@ set "ers=ERRORS"
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
@ call "funcs_list.bat" :list_gen "%args%" "%lm%"
    @ goto :eof
)

    echo NEED TO CHANGE UNDERSCOREED TITLES AND FILES
    echo NEED TO SEARCH FOR EMPTY DIRS IN UNDERSCORES & BRACKETS
    @ call "funcs_analyze.bat" :empty_check "%brkt%" "%ers%"
    @ call "funcs_analyze.bat" :empty_check "%prnth%" "%ers%"

    @ rem Change underscored file first, then change directories
    @ rem ... to use incorrect directories as look up method in src.

    @ call "funcs_analyze.bat" :underscore_file "%src%" "%u_scor%\FILE"
    @ call "funcs_analyze.bat" :underscore_dir "%src%" "%u_scor%\DIR"



echo END OF MAIN
pause
goto :eof