setlocal EnableDelayedExpansion

call %*

goto :eof

:id_label
    setlocal
    set "left=%~1"
    set "right=%~2"
    set "item=%~3"
    set "from_item=%~4"
    rem echo CALL ID_LABEL

    set status=
    set encap_item=




    if exist type.txt ( del type.txt )

    call :text_type "!left!" "!right!" "!item!" "!from_item!"

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

    set "exist=N"
    if exist is_nested.txt (
        set "exist=Y"
    )
    rem echo is_nested: "!exist!"


    rem for /f "tokens=1"


    rem from item: string only
    rem status: 
    REM NESTED ( {label, {label}, {label} ),
    REM INDIV, ( {label} )
    REM or BRIDGE, <none>
    rem echo --- DOIL2 ---- "!from_item!" "!status!"


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
    
    call ".\funcs\labels\sort.bat" :sort_label "!sort_item!" "!status!" "!format!"

    endlocal
exit /b





:text_type
    setlocal
    set "left=%~1"
    set "right=%~2"
    set "item=%~3"
    set "from_item=%~4"
rem echo CALL TEXT_TYPE
rem ECHO "!left!"
rem echo "!right!"
rem echo "!item!"
rem echo "!from_item!"
    rem encap structures within file names
    rem "bridge(label)"
    rem "(label)"
    rem "....bridge(label)bridge(label)....."
    rem "....(label)(label)..."
    rem "....bridge(label)(label)...."
    rem "...(label)(label)bridge...."

    rem "....bridge(label (label) (label) label)..."
    rem "....bridge(label (label) (label) label)bridge(label (label) (label) label)..."
    rem "....bridge(label (label) (label) label)(label (label) (label) label)..."
    rem "....(label (label) (label) label)(label (label) (label) label)bridge..."

    rem change item -> to -> padded item

    rem item                            padded item
    rem -----                           -------------


    rem "bridge"                          "PADbridge"
    rem     1                                   1

    rem "bridge(label"                    "PADbridge(label"
    rem     1   2                           1           2
    
    rem "bridge(label (label"             "PADbridge(label (label"
    rem     1   2       3                   1       2       3
    
    rem " label"                           "PAD label"
    rem     1                               1

    rem ""                          "PAD"
    rem 1                            1
    
    rem " "                         "PAD "
    rem 1                           1
    
    rem "(label"                    "PAD(label"
    rem     1                       1       2
    
    rem "(label (label"             "PAD(label (label"
    rem     1   2                   1       2       3



    rem variables representative of text previously collected using token values
    set first=
    set sec=
    set third=
    call ".\funcs\utils.bat" :delim_with_char "1" "!left!" "PAD!item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "first=%%i"
    )

    
    call ".\funcs\utils.bat" :delim_with_char "2" "!left!" "PAD!item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "sec=%%i"
    )

    
    call ".\funcs\utils.bat" :delim_with_char "3" "!left!" "PAD!item!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "third=%%i"
    )


    REM echo THIRD "!third!"
    REM save whether string is bridge, nested, or indiv encapsulator
    set nest_status=

    rem endmark=\ open, token=1 -> (label, token > 1 -> label)
    rem endmark=/ closed (label)

    rem applies to bridge B, last nested label L, 
    rem B (label (label) (label) L) B
    rem B (label) B
    if "!from_item!" equ "!item!" (
        set "nest_status=BRIDGE"
        set "bridge=0"
        set "bridge=BRDG"
        set "format=!bridge!"
        if exist is_nested.txt (
            del is_nested.txt
            set "nest_status=NESTED"

            rem echo ENCAPED FORMAT: "label)"
            set "open_started=2"
            set "open_started=OPN_STRTD"
            set "format=!open_started!"
            set "nested=3"
            call :encap_struct "!open_started!" "!left!|!right!" "!from_item!"
        )
        set "nest_status=!nest_status!|"
        echo !nest_status! > type.txt
        if exist format.txt ( del format.txt )
        set "format=!format!|"
        echo !format! > format.txt

        exit /b

    )


    rem Applies to bridge B, as in:
    rem B(label) -- indiv encapsulator

    rem Apples to bridges B1 and B2, as in:
    rem B1(label (label)|B2(label)| label), -- nested encapsulator
    rem B1="bridge", " "<space>, ""<no space>,
    rem B2=" "<space>
    if "PAD!from_item!" equ "!first!" (
        set "nest_status=BRIDGE"
        set "bridge=BRDG"
        set "format=!bridge!"
        if exist is_nested.txt (
            set "nest_status=NESTED"
            set "nested=BRDG"
            set "format=!nested!"
        
        )
        
        set "nest_status=!nest_status!|"
        echo !nest_status! > type.txt
        if exist format.txt ( del format.txt )
        set "format=!format!|"
        echo !format! > format.txt

        exit /b

    )

    rem applies to label L
    rem "PAD(L)""
    rem "PADbridge(L)"
    rem PAD(L (x) (x) x)
    rem PADbridge(L (x) (x) x)
    if "!from_item!" equ "!sec!" (
        rem set "format=(indiv)"
        set "format=CLSD"
        set "nest_status=INDIV"
        if exist is_nested.txt (
            set "nest_status=NESTED"
            rem set "format=(NESTED)"
            set "format=CLSD"
        )
    )


    rem Applies to label L:
    rem PAD(x (L) (x) x)
    rem PADbridge(x (L) (x) x)
    rem PAD(x), which has non-existent L
    
    if "!third!" neq " " (
        set "nest_status=NESTED"
        ECHO "" > is_nested.txt
        rem if "!from_item!" equ "!sec!" ( set "format=(NESTED + ")
        if "!from_item!" equ "!sec!" (
            set "format=OPN_ENDD"
        )
        rem IF "!from_item!" equ "!third!" ( set "format=(NESTED -)")
        if "!from_item!" equ "!third!" (
            set "format=CLSD"
        )
    )



    rem echo "!format!"
     call :encap_struct "!format!" "!left!|!right!" "!from_item!"


    set "nest_status=!nest_status!|"
    echo !nest_status! > type.txt
    if exist format.txt ( del format.txt )
    set "format=!format!|"
    echo !format! > format.txt
    endlocal
exit /b













rem determine if encasulators are open-started, open-ended, or closed
rem open-ended: "(label 1 label2 label N..." -> 1
rem open-started: "label N-2, label N-1, label N)" -> 2
rem closed: "(label 1, label 2, .... labelN)" -> 3
:encap_struct
    setlocal
rem ECHO CALLL ENCAP_STRUCT
    rem open-started, open-ended, or closed
    set "type=%~1"
    set "encap_set=%~2"
    set "labels=%~3"
    rem set "file_type=%~4"

    rem store ecapsulators: (), {}, or []
    set left=
    set right=
    for /f "tokens=1 delims=|" %%i in ("!encap_set!") do (
        set "left=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!encap_set!") do (
        set "right=%%i"
    )


    rem bridge only, format=0

    rem open-ended, format=1
    set "use=!left!!labels!"


    rem open-started, format=2
    REM if "!type!" equ "2" (
    if "!type!" equ "OPN_STRTD" (
        set "use=!labels!!right!"
    )

    rem closed, format=3
    REM if "!type!" equ "3" (
    if "!type!" equ "CLSD" (
        set "use=!left!!labels!!right!"
    )

    rem if exist struct.txt ( del struct.txt )
    rem echo ENCAP STRUCT "!use!"
    echo "|!use!|" > struct.txt
    
    endlocal
exit /b