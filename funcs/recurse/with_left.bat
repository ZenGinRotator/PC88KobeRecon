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

:rec_left
    setlocal
    rem echo REC_LEFT
    rem PAUSE
        rem ECHO * doil 2 *
    set "doils2=%~1"
    set "encap_type=%~2"
    

    
    set ttoken=
    set left=
    set right=
    set item=
    set optn1_left=
    set optn1_right=
    set optn2_left=
    set optn2_right=

    for /f "tokens=1 delims=|" %%i in ("!doils2!") do (
        set "ttoken=%%i"
    )

    for /f "tokens=2 delims=|" %%i in ("!doils2!") do (
        set "left=%%i"
    )

    for /f "tokens=3 delims=|" %%i in ("!doils2!") do (
        set "right=%%i"
    )

    for /f "tokens=4 delims=|" %%i in ("!doils2!") do (
        set "item=%%i"
    )

    for /f "tokens=5 delims=|" %%i in ("!doils2!") do (
        set "optn1_left=%%i"
    )

    for /f "tokens=6 delims=|" %%i in ("!doils2!") do (
        set "optn1_right=%%i"
    )

    for /f "tokens=7 delims=|" %%i in ("!doils2!") do (
        set "optn2_left=%%i"
    )
    for /f "tokens=8 delims=|" %%i in ("!doils2!") do (
        set "optn2_right=%%i"
    )
   
    rem echo "ITEM " "!item!"
    
   
    set from_item=
    call ".\funcs\utils.bat" :delim_with_char "!ttoken!" "!left!" "!item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "from_item=%%i"
    )
    echo ITEM "!item!"
    ECHO FROM ITEM "!from_item!"
    echo TOKEN "!ttoken!"

    
    rem "bridge"                          "PADbridge"
    
    rem "bridge(label"                    "PADbridge(label"
    
    rem "bridge(label (label"             "PADbridge(label (label"
    
    rem " label"                           "PAD label"
    
    rem ""                          "PAD"
    
    rem " "                         "PAD "
    
    rem "(label"                    "PAD(label"
    
    rem "(label (label"             "PAD(label (label"
    
    rem use a temp token value to determine the future string
    rem to be extracted from item
    
    SET /A temp=!ttoken!+1
    set next=
    call ".\funcs\utils.bat" :delim_with_char "!temp!" "!left!" "!item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "next=%%i"
    )


    rem echo FROM ITEM "!from_item!"
    rem echo LEFT AND RIGHT "!left!" and "!right!"


    set last_char=


    rem "!!!! Making an attempt to re-use this if-condition as a callable function !!!!

    rem **** need to add parameter to show results for last char output
    call ".\funcs\encaps\last.bat" :find_last_char "!from_item!" ""
    for /f "tokens=1 delims=|" %%i in (last_char.txt) do (
        rem echo LAST CHAR "%%i"
        set "last_char=%%i"
        if "!last_char!" equ "@" (
            set last_char=
        )
            
    )
    rem echo SECONDARY LAST CHAR "!last_char!"
    set "use_optnR=!optn1_right!"
    if "!last_char!" equ "!optn2_right!" (
        set "use_optnR=!optn2_right!"

    )
    rem echo USE OPTION R "!use_optnR!"

    if "!encap_type!" equ "O1" (

        REM Avoid delimiting the bridge again if previously delimited
        if "!use_optnR!" neq "!right!" (

            rem Avoid delimiting a bridge without any encapsulators
            if "!last_char!" neq "" (
            rem echo ......................... USE FOUND OPTION "!use_optnR!" within found item
            
            set "use_optnL=("
            if "!use_optnR!" equ "}" (
                set "use_optnL={"
            )
            if "!use_optnR!" equ "]" (
                set "use_optnL=["
            )
            
            set "primes=!use_optnL!|!use_optnR!"
            set "o1s=!optn_one_left!|!optn_one_right!"
            set "o2s=!optn_two_left!|!optn_two_right!"
            set "doils=1|!primes!|!from_item!|!o1s!|!o2s!"


            call "funcs_rom_keywords.bat" :DOIR_BRIDGE "!doils!"
            )

        )
        
    )

    set /a do_=0
    if "!last_char!" equ "" (
        call ".\funcs\labels\identify.bat" :id_label "!left!" "!right!" "!item!" "!from_item!"
    ) 

    
    
    if "!next!" equ " " (
        exit /b
    )


    if "!bitem!" equ " " (
       
        exit /b
    )


    set /a ttoken+=1
    

    set "primes=!left!|!right!"
    set "o1s=!optn1_left!|!optn1_right!"
    set "o2s=!optn2_left!|!optn2_right!"
    set "doils2=!ttoken!|!primes!|!item!|!o1s!|!o2s!"
    call :rec_left "!doils2!" "!encap_type!"

    endlocal
exit /b