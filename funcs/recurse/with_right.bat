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


:DOIR_BRIDGE
    setlocal
    set "dois=%~1"
    set "encap_type=%~2"
    
    
rem ECHO doir bridge *
    set token=
    set left=
    set right=
    set item=
    set optn1_left=
    set optn1_right=
    set optn2_left=
    set optn2_right=
    for /f "tokens=1 delims=|" %%i in ("!dois!") do (
        set "token=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!dois!") do (
        set "left=%%i"        
    )
    for /f "tokens=3 delims=|" %%i in ("!dois!") do (
        set "right=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!dois!") do (
        set "item=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("!dois!") do (
        set "optn1_left=%%i"
    )
    for /f "tokens=6 delims=|" %%i in ("!dois!") do (
        set "optn1_right=%%i"
    )
    for /f "tokens=7 delims=|" %%i in ("!dois!") do (
        set "optn2_left=%%i"
    )
    for /f "tokens=8 delims=|" %%i in ("!dois!") do (
        set "optn2_right=%%i"
    )

    set delimed_right=
    set "end_mark=\"
    call ".\funcs\utils.bat" :delim_with_char "!token!" "!right!" "!item!!end_mark!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "delimed_right=%%i"
    )
    rem echo DOIR: FROM ITEM "!item!"
rem echo DELIMD RIGHT "!delimed_right!"
rem echo RIGHT "!right!"
rem echo APPENDED "!item!\"
   
   
  
    if "!delimed_right!" equ " " (
        exit /b
    )


    set "orig_delimtd=!delimed_right!"

    rem Determine if a bridge exists before end mark
    call ".\funcs\utils.bat" :delim_with_char "1" "!end_mark!" "!delimed_right!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "possibly_diff=%%i"
    )

    if "!possibly_diff!" neq "!delimed_right!" (
        set "delimed_right=!possibly_diff!"
    )

    rem To account where two neighboring encapsulators (of different alpabets) do not share a 
    rem     bridge between them.
    if "!orig_delimtd!" equ "!end_mark!" (
        exit /b
    )


    set "primes=!left!|!right!"
    set "o1s=!optn1_left!|!optn1_right!"
    set "o2s=!optn2_left!|!optn2_right!"
    set "doils=1|!primes!|!delimed_right!|!o1s!|!o2s!"
    
    

    
    call ".\funcs\recurse\with_left.bat" :rec_left "!doils!" "!encap_type!"
    set /a token+=1
    

    set "primes=!left!|!right!"
    set "o1s=!optn1_left!|!optn1_right!"
    set "o2s=!optn2_left!|!optn2_right!"
    set "dois=!token!|!primes!|!item!|!o1s!|!o2s!"
    call :DOIR_BRIDGE "!dois!" "!encap_type!"
    endlocal
exit /b

