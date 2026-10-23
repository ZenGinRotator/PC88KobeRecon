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





    rem .\funcs\labels\identify.bat

    rem **** KEEP!!!! : Displays whether from item is BRIDGE, NESTED, OR INDIV
    call ".\funcs\labels\identify.bat" :id_label "!left!" "!right!" "!item!" "!from_item!"


    if "!next!" equ " " (
        exit /b
    )



    

 rem exclude strings  containing either option 1 left or option 2 right
    set haso1=
    set haso2=
    set /a hide=0

    call ".\funcs\utils.bat" :delim_with_char "1" "!optn1_right!" "!use!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "haso1=%%i"
    )
        if "!haso1!" neq "!use!" (
            set /a hide+=1
        )

    
    call ".\funcs\utils.bat" :delim_with_char "1" "!optn2_right!" "!use!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "haso2=%%i"
    )
        if "!haso2!" neq "!use!" (
            set /a hide+=1
        )

    


REM echo ITEM "!item!"

rem currently use can save a space " "
    if "!use!" neq " " (
         if "!hide!" equ "0" (

            rem set "nest_status=A BRIDGE"
            if "!ttoken!" equ "2" (
            REM TEST FOR nested label
            
            set /a temp=!ttoken!+1
            call ".\funcs\utils.bat" :delim_with_char "!temp!" "!left!" "!item!"
            for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
                if "%%i" neq " " (
                    rem set "nest_status=NESTED"
                    REM echo #### NEXT  "%%i" ##### "!left!" "!item!"
                    REM echo "" > nested.txt
                )
            )
            )


            rem if item === bitem, then the item/bitem is last of nested label
            rem if item == bitem, then item/bitem is an ending bridge

            rem if exist nested.txt (
            rem     set "nest_status=NESTED"
            rem )


             echo "!brk!" use "!use!" "!nest_status!"
            REM echo ITEM "!item!"
            REM echo BITEM "!bitem!"
            REM echo PAD "!pad!"
            REM echo PADDED "!padded!"

            rem need to determine if this is an encapsulated label or a bridge
            
         )
        rem echo ITEM "!item!"
    )

    if "!bitem!" equ " " (
       
        exit /b
    )


    set /a ttoken+=1
    

    set "primes=!left!|!right!"
    set "o1s=!optn1_left!|!optn1_right!"
    set "o2s=!optn2_left!|!optn2_right!"
    set "doils2=!ttoken!|!primes!|!item!|!o1s!|!o2s!"
    call :rec_left "!doils2!"

    endlocal
exit /b