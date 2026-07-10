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

@ call "funcs_list.bat" :list "%args%" "%lm%"

if exist "%lm%" (
    echo NEED TO CHANGE UNDERSCOREED TITLES AND FILES
    echo NEED TO SEARCH FOR EMPTY DIRS IN UNDERSCORES & BRACKETS

)

echo END OF MAIN
pause
goto :eof




:make_dir
    md "%~1"
    echo > "%~1\%~2"
exit /b


