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



:recurse_on_group2
    setlocal
    set "recs=%~1"

    set token=
    set left_char=
    set right_char=
    set name=
    set optn_one_left=
    set optn_one_right=
    set optn_two_left=
    set optn_two_right=
    

    for /f "tokens=1 delims=|" %%i in ("!recs!") do (
        set "token=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!recs!") do (
        set "left_char=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!recs!") do (
        set "right_char=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!recs!") do (
        set "name=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("!recs!") do (
        set "optn_one_left=%%i"
    )
    for /f "tokens=6 delims=|" %%i in ("!recs!") do (
        set "optn_one_right=%%i"        
    )
    for /f "tokens=7 delims=|" %%i in ("!recs!") do (
        set "optn_two_left=%%i"
    )
    for /f "tokens=8 delims=|" %%i in ("!recs!") do (
        set "optn_two_right=%%i"
    )


    set item=
    call ".\funcs\utils.bat" :delim_with_char "!token!" "!right_char!" "!name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )
    

    if "!item!" equ " " (
        exit /b
    )


    rem Assume a text bridge preceeds the label
    rem     as in Bridge |last char| label
    set orig_bridge=
    call ".\funcs\utils.bat" :delim_with_char "1" "!left_char!" "!item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        rem possibly is encapsulated label
        set "orig_bridge=%%i"
    )



    rem Item does not have a preceeding bridge
    rem Example item: "{label"
    if "!left_char!!orig_bridge!" equ "!item!" (
        set orig_bridge=
    )

    set last_char=


    rem "!!!! Making an attempt to re-use this if-condition as a callable function !!!!

    rem **** need to add parameter to show results for last char output
    call ".\funcs\encaps\last.bat" :find_last_char "!orig_bridge!" ""
    for /f "tokens=1 delims=|" %%i in (last_char.txt) do (
        rem echo LAST CHAR "%%i"
        set "last_char=%%i"
        if "!last_char!" equ "@" (
            set last_char=
        )
            
    )
    
    

    rem Last_char exists within our discovered bridge, however this bridge
    rem     can be one of two situations, where bridge B exists within file F
    rem     in the form of
    rem     F=B <last_encap> label </last_encap>,
    rem     where B=Bridge2 <optn2_encap> label </optn2_encap>, or 
    rem     where B=Bridge1 <optn1_encap> label </optn1_encap> Bridge2 <optn2_encap> lael </optn2_encap>
    rem echo INIT LAST CHAR "!last_char!"
    if "!last_char!" neq "" (

        rem primes must contain one of the two option characters
        rem Use last char to find the correct opton<1/2>_right char, the latter of which is not == @ (indicatinga blank char)
        set "o_left=!optn_one_left!"
        set "o_right=!optn_one_right!"
        if "!last_char!" neq "!o_right!" (
            set "o_right=!optn_two_right!"
            set "o_left=!optn_two_left!"
        )

        set "primes=!o_left!|!o_right!"
        set "o1s=!optn_one_left!|!optn_one_right!"
        set "o2s=!optn_two_left!|!optn_two_right!"
        
        set "dois=1|!primes!|!orig_bridge!|!o1s!|!o2s!"
        
        
        set "encap_type=O1"
              
        call ".\funcs\recurse\with_right.bat" :DOIR_BRIDGE "!dois!" "!encap_type!"

    ) 
    rem else (   
   
    set "primes=!left_char!|!right_char!"
    set "o1s=!optn_one_left!|!optn_one_right!"
    set "o2s=!optn_two_left!|!optn_two_right!"
    set "doils=1|!primes!|!item!|!o1s!|!o2s!"
    
    

    REM This function can correctly identify bridges, indivs, or nested labels
    rem     when delimiting use left & right primary encapsulators
    set "encap_type=P"
    call ".\funcs\recurse\with_left.bat" :rec_left "!doils!" "!encap_type!
    



    
    set status=
    set /a ttoken=!token!
    


    set /a ttoken+=1

    
    set "primes=!left_char!|!right_char!"
    set "o1s=!optn_one_left!|!optn_one_right!"
    set "o2s=!optn_two_left!|!optn_two_right!"
    set "recs=!ttoken!|!primes!|!name!|!o1s!|!o2s!"


    call :recurse_on_group2 "!recs!"

    endlocal
exit /b