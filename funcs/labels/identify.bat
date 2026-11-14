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

:id_label
    setlocal
    set "left=%~1"
    set "right=%~2"
    set "item=%~3"
    set "from_item=%~4"
    

    set status=
    set encap_item=

rem echo ID ITEM "!item!"
 

    if exist type.txt ( del type.txt )

    call ".\funcs\labels\type.bat" :text_type "!left!" "!right!" "!item!" "!from_item!"


    rem type.txt contains BRIDGE, INDIV, OR NESTED
    for /f "tokens=1 delims=|" %%i in (type.txt) do (
        set "status=%%i"
    )    
    

    rem File name does not have any encapsulators.
    rem Therefore don't need to look for an encapped item.
    
    if exist struct.txt (
        for /f "tokens=2 delims=|" %%i in (struct.txt) do (
            set "encap_item=%%i"
        )
    )

    set format=
    for /f "tokens=1 delims=|" %%i in (format.txt) do (
        set "format=%%i"
    )


    rem the encap format for sorting labels
    rem 0 - BRDG: bridge - (nested, " " -> same line, non-nested -> always add item to next line)
    rem 1 - OPN_ENDD: open-ended: (label ... : (always add item to next line)
    rem 2 - OPN_STRTD: open-started: ...label) : (always add item to same line)
    rem 3 - CLSD: closed: (...label...) : (nested: same-line, indiv: new-line)
    rem Use format to determine when to:
    rem * add nested label to current or new line,
    rem * if format=2, then new line
    rem * else same line

    rem echo FORMAT "!format!"

    
    rem echo is_nested: "!exist!"


    rem for /f "tokens=1"


    rem from item: string only
    rem status: 
    REM NESTED ( {label, {label}, {label} ),
    REM INDIV, ( {label} )
    REM or BRIDGE, <none>
   


    rem change to alphabetic identifier
    set "sort_item=!from_item!"
    if "!status!" equ "INDIV" (
        set "sort_item=!encap_item!"
    )

    if "!status!" equ "NESTED" (
        set "sort_item=!encap_item!"
        if "!from_item!" equ " " (
            set "sort_item=!from_item!"
        )
    )

    rem echo SORT ITEM "!sort_item!" "!status!"

    rem exclude bridge that contains an optional chars
    rem Within 2nd or 3rd call of this recursive function,
    rem     where left and right primary characters are optional characters
    rem     we need to disregard the sorted_item because it is a bridge
    rem     that contains optional delimiting characters.
    


    call ".\funcs\labels\sort\encapped.bat" :labels "!sort_item!" "!status!" "!format!"

    rem reconstruct file name here in realtime
    call ".\funcs\verify\realtime.bat" :reconstruct "!sort_item!"

    rem We will use this section to bring unstructured labels into
    rem     their own *.txt files
set /a show=0
    if "!status!" equ "NESTED" (
        set /a show+=1
    )
    if "!status!" equ "INDIV" (
        set /a show+=1
    )

    if "!show!" neq "0" (
    echo show "!from_item!" "!status!"
    )
    

    endlocal
exit /b