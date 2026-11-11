setlocal EnableDelayedExpansion
set brk=^



call %*

goto :eof


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

rem echo FROM EQU? ITEM "!from_item!" "!item!"
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
            rem del is_nested.txt
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
            rem 
            



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
    if "!type!" equ "OPN_STRTD" (
        set "use=!labels!!right!"
    )

    rem closed, format=3
    if "!type!" equ "CLSD" (
        set "use=!left!!labels!!right!"
    )

   

    rem echo ENCAP STRUCT "!use!"
    echo "|!use!|" > struct.txt
    
    endlocal
exit /b