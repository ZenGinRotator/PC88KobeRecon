@ setlocal EnableDelayedExpansion
@ set brk=^


@ set "bar=###################################################################################################################!brk!"

@ call %*

@ goto :eof

:encapsulated


    @ set mem_flag=
    @ set encaps_flag=
    for /f "tokens=1 delims=\" %%i in ("%~2") do (
        @ set "encaps_flag=%%i"
    )

    for /f "tokens=2 delims=\" %%i in ("%~2") do (
        @ set "mem_flag=%%i"
    )

    @ set "encaps_type=curly brackets"
    if "!encaps_flag!" equ "SQUARE_BRACKETS" (
        @ set "encaps_type=square brackets"
    )

    if "!encaps_flag!" equ "PARENTHESES" (
        @ set "encaps_type=parentheses"
    )

    @ set "mem_type=directory"

    if "!mem_flag!" equ "FILE" (
        set "mem_type=file"
    )
    echo "%~1 - contains all !mem_type! names found in the %~1 directory, that include words encapuslated by !encaps_type!."
exit /b

:before_list
    @ set src=
    @ set u_scor=
    @ set prnth=
    @ set sqr_brkt=
    @ set curl_brkt=
    @ set exts=

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

    @ set "d=DIR"
    @ set "f=FILE"


@ rem Press any key to search the ARCHV_RECON directory and create the following directories, if data found in the ARCHIV_RECON directory is relevant:

@ rem CURLY_BRACKETS/DIR - contains all directory names found in the ARCHV_RECON direcotry, that include words encapuslated by curly brackets.
@ rem CURLY_BRACKETS/FILE - contains all file names that include words encapuslated by curly brackets.


@ rem SQUARE_BRACKETS/DIR - contains all directory names that include words encapuslated by square brackets.
@ rem SQUARE_BRACKETS/FILE - contains all file names that include words encapuslated by square brackets.

@ rem PARENTHESES/DIR - contains all directory names that include words encapuslated by parentheses.
@ rem PARENTHESES/DIR - contains all file names that include words encapuslated by parentheses.


@ rem UNDERSCORES/DIR - a directory containing all directory names that include an underscore, that must be removed in the future with this script.
@ rem UNDERSCORES/FILE: - a directory containing all file names that include an underscore, that must be removed in the future with this script.

@ rem EXTENSIOSN - contains the names of files found in the ARCHV_RECON direcotry, seperated into directories labeled by file extension type.



@ set "prs= * Press any key to search the !src! directory and create the following directories for its data:!brk!!brk!"
@ set "cbd=  1. !curl_brkt!\!d! - contains all directory names found in the !src! directory, that include words encapuslated by curly brackets.!brk!!brk!"
@ set "cbf=  2. !curl_brkt!\!f! - contains all file names found in the !src! directory, that include words encapuslated by curly brackets.!brk!!brk!"
@ set "sbd=  3. !sqr_brkt!\!d! - contains all directory names found in the !src! directory, that include words encapuslated by square brackets.!brk!!brk!"
@ set "sbf=  4. !sqr_brkt!\!f! - contains all file names found in the !src! directory, that include words encapuslated by square brackets.!brk!!brk!"
@ set "pd=  5. !prnth!\!d! - contains all directory names found in the !src! directory, that include words encapuslated by parentheses.!brk!!brk!"
@ set "pf=  6. !prnth!\!f! - contains all file names found in the !src! directory, that include words encapuslated by parentheses.!brk!!brk!"
@ set "ud=  7. !u_scor!\!d! - a directory containing all directory names found in the !src! directory that include an underscore, that must be removed in the future with this script.!brk!!brk!"
@ set "uf=  8. !u_scor!\!f! - a directory containing all file names found in the !src! directory that include an underscore, that must be removed in the future with this script.!brk!!brk!"
@ set "ext_=  9. !exts! - contains the names of files found in the !src! direcotry, seperated into directories labeled by file extension type.!brk!!brk!"

echo "!brk!!brk!!bar!!prs!!cbd!!cbf!!sbd!!sbf!!pd!!pf!!ud!!uf!!ext_!!bar!!brk!!brk!"

exit /b



@ rem Delete this function
:underscored
    @ set mem_flag=
    for /f "tokens=2 delims=\" %%i in ("%~2") do (
        @ set "flag=%%i"
    )

    @ set "mem_type=directory"

    if "!mem_flag!" equ "FILE" (
        set "mem_type=file"
    )
    echo "%~1 - a directory containing all !mem_type! names found in the %~1 directory that include an underscore, that must be removed in the future with this script."
exit /b

:extensioned
    echo "%~2 - contains the names of files found in the %~1 directory, seperated into directories labeled by file extension type."
exit /b


:after_list

    @ set src=
    @ set u_scor=
    @ set prnth=
    @ set sqr_brkt=
    @ set curl_brkt=
    @ set exts=

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

    @ set "d=DIR"
    @ set "f=FILE"
    @ rem The scanning of the ARCHIVE_RECON directory is now complete and the following directories have been created:
    @ rem - CURLY_BRACKETS/DIR,
    @ rem - CURLY_BRACKETS/FILE

    @ rem - UNDERSCORES/DIR
    @ rem - UNDERSCORES/FILE

    @ rem - SQUARE_BRACKETS/DIR
    @ rem - SQUARE_BRACKETS/FILE

    @ rem - PARENTHESES/DIR
    @ rem - PARENTHESES/FILE

    @ rem - EXTENSIONS

    @ rem - If you need to create these files again, delete the LIST_MADE file from the directory and re-run this script again.

    @ rem Otherwise run this script again to use the names of directories & files listed in the !u_scor! directory, to underscores in the names of those files and directories from the !src! directory.

    @ set "stment=* The scanning of the !src! directory is now complete and the following directories have been created:!brk!!brk!"
    @ set "cbd=  1. !curl_brkt!\!d! - contains all directory names found in the !src! directory, that include words encapuslated by curly brackets.!brk!!brk!"
    @ set "cbf=  2. !curl_brkt!\!f! - contains all file names found in the !src! directory, that include words encapuslated by curly brackets.!brk!!brk!"
    @ set "sbd=  3. !sqr_brkt!\!d! - contains all directory names found in the !src! directory, that include words encapuslated by square brackets.!brk!!brk!"
    @ set "sbf=  4. !sqr_brkt!\!f! - contains all file names found in the !src! directory, that include words encapuslated by square brackets.!brk!!brk!"
    @ set "pd=  5. !prnth!\!d! - contains all directory names found in the !src! directory, that include words encapuslated by parentheses.!brk!!brk!"
    @ set "pf=  6. !prnth!\!f! - contains all file names found in the !src! directory, that include words encapuslated by parentheses.!brk!!brk!"
    @ set "ud=  7. !u_scor!\!d! - a directory containing all directory names found in the !src! directory that include an underscore, that must be removed in the future with this script.!brk!!brk!"
    @ set "uf=  8. !u_scor!\!f! - a directory containing all file names found in the !src! directory that include an underscore, that must be removed in the future with this script.!brk!!brk!"
    @ set "ext_=  9. !exts! - contains the names of files found in the !src! directory, seperated into directories labeled by file extension type.!brk!!brk!"
    @ set "if=  *If you need to create these files within these directories again, delete the LIST_MADE file from the directory and re-run this script again.!brk!!brk!"
    @ set "concl=  *Otherwise run this script again to use the names of directories & files listed in the !u_scor! directory, to remove underscores found in the names of directories and files in the !src! directory.!brk!!brk!"
    echo "!brk!!brk!!bar!!stment!!cbd!!cbf!!sbd!!sbf!!pd!!pf!!ud!!uf!!ext_!!if!!concl!!bar!!brk!!brk!"
exit /b


:before_analyze

    @ rem Press any button to perform the following:
    @ rem 1. Make sure that the following directories all have files (are non-empty)
    @ rem 2. Remove any previously found underscores in the names of any directory and file listed within the UNDERSCORES directory.

    
    @ set src=
    @ set u_scor=
    @ set prnth=
    @ set sqr_brkt=
    @ set curl_brkt=
    @ set exts=

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

    @ set "d=DIR"
    @ set "f=FILE"

    @ set "p=Press any button to perform the following:!brk!!brk!"
    @ set "m=  1. Verify that the following directories all have files (each directory should be non-empty)!brk!"
    @ set "cbd=    a. !curl_brkt!\!d!!brk!"
    @ set "cbf=    b. !curl_brkt!\!f!!brk!"
    @ set "sbd=    c. !sqr_brkt!\!d!!brk!"
    @ set "sbf=    d. !sqr_brkt!\!f!!brk!"
    @ set "pd=    e. !prnth!\!d!!brk!"
    @ set "pf=    f. !prnth!\!f!!brk!"
    @ set "ud=    g. !u_scor!\!d!!brk!"
    @ set "uf=    h. !u_scor!\!f!!brk!"
    @ set "ext_=    i. !exts!!brk!!brk!"
    @ set "r=  2. Remove any previously found underscores in the names of any directory and file listed within the UNDERSCORES directory.!brk!"
    @ set "w=    a. We need to use underscores for a different purpose in the future.!brk!"


    echo "!brk!!brk!!!bar!!p!!m!!cbd!!cbf!!sbd!!sbf!!pd!!pf!!ud!!uf!!ext_!!r!!w!!bar!!brk!!brk!"
exit /b


:after_analyze
    @ rem You have successfully removed all underscores in the names of any directory and file listed within the UNDERSCORES directory!

    set "y= * You have successfully removed all underscores in the names of any directory and file listed within the UNDERSCORES directory!!brk!"
    set "h= * Here are some statistics:!brk!"
    set list=
    for /f "tokens=*" %%i in (nums.txt) do (
        set "list=!list!!brk!%%i"

    )
    del "nums.txt"

    echo "!brk!!brk!!bar!!y!!brk!!h!!list!!bar!!brk!!brk!"
exit /b