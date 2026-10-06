set "np1=(P1.0 + (P1.1 +) (P1.2 +) P1.n +)"
set "np2=(P2.0 + (P2.1 +) (P2.2 +) P2.n +)"
set "np3=(P3.0 + (P3.1 +) (P3.2 +) P3.n +)"
rem (P1.0 + (P1.1 +) (P1.2 +) P1.N +)



set "nc1={C1.0 + {C1.1 +} {C1.2 +} C1.n +}"
set "nc2={C2.0 + {C2.1 +} {C2.2 +} C2.n +}"
set "nc3={C3.0 + {C3.1 +} {C3.2 +} C3.n +}"


set "ns1=[S1.0 + [S1.1 +] [S1.2 +] S1.n +]"
set "ns2=[S2.0 + [S2.1 +] [S2.2 +] S2.n +]"
set "ns3=[S3.0 + [S3.1 +] [S3.2 +] S3.n +]"

set "ip1=(P1 +)"
set "ip2=(P2 +)"
set "ip3=(P3 +)"

set "ic1={C1 +}"
set "ic2={C2 +}"
set "ic3={C3 +}"

rem (P1 +)
rem (P2 +)


set "is1=[S1 +]"
set "is2=[S2 +]"
set "is3=[S3 +]"


set "b1=B1"
set "b2=B2"
set "b3=B3"
set "b4=B4"



call %*

goto :eof


rem Permutations for last character data

rem 0 encapsulators
rem no encapsulators


rem single encapsulators
rem need 6 versions: ic, is, ip, nc, ns, np
rem an indiv
rem an indiv, bridge
rem nested
rem nested, bridge

rem two encapsulators
rem nested variant, indiv variant
rem with bridge, where bridge B can be: "", "BRIDGE", " BRIDGE", "BRIDGE ", " BRIDGE "
rem c, s
rem s, c
rem c, p
rem p, c
rem s, p
rem p, s
rem c, c,
rem s, s
rem p, p

:all_indiv
    setlocal
    set "dirs=%~1"


    set "char_num=1"
    set "brid_num=1"
    set "func_encap="

    set "args=!brid_num!|!char_num!|!func_encap!"
    call :make_indiv "!dirs!" "c" "!args!"
    call :make_indiv "!dirs!" "s" "!args!"
    call :make_indiv "!dirs!" "p" "!args!"
    endlocal
exit /B

:all_nested
    setlocal

    set "dirs=%~1"

    
    set "char_num=1"
    set "brid_num=1"
    set "func_encap="

    set "args=!brid_num!|!char_num!|!func_encap!"

    call :make_nested "!dirs!" "c" "!args!"
    call :make_nested "!dirs!" "s" "!args!"
    call :make_nested "!dirs!" "p" "!args!"
    endlocal
exit /b


:after_1st_indiv
    setlocal
    set "dirs=%~1"
    set "args=%~2"


    rem These are referenced below but have to be changed here, or below
    set fpath=
    

    set smpl=
    set indv=
    set nest=
    for /f "tokens=1 delims=|" %%i in ("!dirs!") do (
        set "smpl=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!dirs!") do (
        set "indv=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!dirs!") do (
        set "nest=%%i"
    )


    set bri_num=
    set enc_num=
    set func_encap=
    
    for /f "tokens=1 delims=|" %%i in ("!args!") do (
        set "bri_num=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!args!") do (
        set "enc_num=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!args!") do (
        set "func_encap=%%i"
    )

rem echo ARGS  "!args!"
    

    set "src_dir=!smpl!\!indv!\STAGE_!bri_num!"
    set "dest_dir=!smpl!\!indv!\STAGE_!enc_num!"
    rem echo SRC "!src_dir!"
    rem echo DEST "!dest_dir!"
    set /a q=0
    
    for %%i in ("!src_dir!\*") do (
        set "fpath=%%i"
        rem echo FPATH "!fpath!"
        REM PAUSE
        set file=
        set /a q+=1
        echo DEST_DIR "!dest_dir!" !q!

        for /f "tokens=4 delims=\" %%j in ("!fpath!") do (
            set "file=%%j"

            rem Write this
            rem ECHO READ FILE "!file!"
            call :write "!dest_dir!" "!file!"

            rem Write this
            call :add_bridge "!file!" "!dest_dir!" "!enc_num!"
           

            rem Write these
            rem echo ALL INDIV
            rem echo "DIRS" "!dirs!"
            rem echo "args" "!args!"
            call :add_indiv "!file!" "c" "" "!dirs!" "!args!"
            call :add_indiv "!file!" "p" "" "!dirs!" "!args!"
            call :add_indiv "!file!" "s" "" "!dirs!" "!args!"

            set "b=BRIDGE !enc_num!"
            set "sb= !b!"
            set "bs=!b! "
            set "sbs= !b! "

            call :add_indiv "!file!" "c" "!b!" "!dirs!"  "!args!"
            call :add_indiv "!file!" "p" "!b!" "!dirs!"  "!args!"
            call :add_indiv "!file!" "s" "!b!" "!dirs!"  "!args!"


            call :add_indiv "!file!" "c" "!sb!" "!dirs!"  "!args!"
            call :add_indiv "!file!" "p" "!sb!" "!dirs!"  "!args!"
            call :add_indiv "!file!" "s" "!sb!" "!dirs!"  "!args!"

            call :add_indiv "!file!" "c" "!bs!" "!dirs!"  "!args!"
            call :add_indiv "!file!" "p" "!bs!" "!dirs!"  "!args!"
            call :add_indiv "!file!" "s" "!bs!" "!dirs!"  "!args!"

            call :add_indiv "!file!" "c" "!sbs!" "!dirs!"  "!args!"
            call :add_indiv "!file!" "p" "!sbs!" "!dirs!"  "!args!"
            call :add_indiv "!file!" "s" "!sbs!" "!dirs!"  "!args!"

            

            rem set /a enc_num_=!enc_num!-1
            rem Need to change destination folder from \indiv\ to \nested\

            rem Write these
            ECHO INDIV, NESTED
            call :add_nested "!file!" "c" "" "!dirs!" "!args!"
            call :add_nested "!file!" "p" "" "!dirs!" "!args!"
            call :add_nested "!file!" "s" "" "!dirs!" "!args!"


            call :add_nested "!file!" "c" "!b!" "!dirs!"  "!args!"
            call :add_nested "!file!" "p" "!b!" "!dirs!"  "!args!"
            call :add_nested "!file!" "s" "!b!" "!dirs!"  "!args!"


            call :add_nested "!file!" "c" "!sb!" "!dirs!"  "!args!"
            call :add_nested "!file!" "p" "!sb!" "!dirs!"  "!args!"
            call :add_nested "!file!" "s" "!sb!" "!dirs!"  "!args!"

            call :add_nested "!file!" "c" "!bs!" "!dirs!"  "!args!"
            call :add_nested "!file!" "p" "!bs!" "!dirs!"  "!args!"
            call :add_nested "!file!" "s" "!bs!" "!dirs!"  "!args!"

            call :add_nested "!file!" "c" "!sbs!" "!dirs!"  "!args!"
            call :add_nested "!file!" "p" "!sbs!" "!dirs!"  "!args!"
            call :add_nested "!file!" "s" "!sbs!" "!dirs!"  "!args!"




        )


    )

    endlocal
exit /b

:add_bridge
    setlocal
    set "file=%~1"
    set "dir=%~2"
    set "brid_num=%~3"

    set bridge=
    call :make_bridge "!brid_num!"
    for /f "tokens=1 delims=|" %%i in (bridge.txt) do (
        set "bridge=%%i"
        rem echo "!file!!bridge!"
        rem echo "!file!!bridge! "
        rem echo "!file! !bridge!"
        rem echo "!file! !bridge! "

        REM echo ADD BRIDGE
        rem Write all
        call :write "!dir!" "!file!!bridge!"
        call :write "!dir!" "!file!!bridge! "
        call :write "!dir!" "!file! !bridge!"
        call :write "!dir!" "!file! !bridge! "

    )
    endlocal
exit /b

:make_bridge
    setlocal
    set "num=%~1"
    set "bridge=BRIDGE!num!|"
    echo !bridge! > bridge.txt
    endlocal
exit /b


:add_indiv
    setlocal
    set "file=%~1"
    set "char=%~2"
    set "bridge=%~3"
    set "dirs=%~4"
    set "args=%~5"
    


    set smpl=
    set indv=
    set nest=
    for /f "tokens=1 delims=|" %%i in ("!dirs!") do (
        set "smpl=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!dirs!") do (
        set "indv=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!dirs!") do (
        set "nest=%%i"
    )

    
    set bri_num=
    set enc_num=
    set func_encap=
    
    for /f "tokens=1 delims=|" %%i in ("!args!") do (
        set "bri_num=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!args!") do (
        set "enc_num=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!args!") do (
        set "func_encap=%%i"
    )

    
    set "src_dir=!smpl!\!indv!\STAGE_!bri_num!"
    set "dest_dir=!smpl!\!indv!\STAGE_!enc_num!"


    call :make_indiv "!dirs!" "!char!" "!args!"
    for /f "tokens=1 delims=|" %%i in (indiv.txt) do (
        set "encap=%%i"
        set "file=!file!!bridge!!encap!"

        rem Write this
        rem echo "!file!"
        call :write "!dest_dir!" "!file!"

    )
    endlocal
exit /b

:double_n
    setlocal
    endlocal
exit /b

rem args=!char_num!|!brid_num!|!func_encap!
:make_indiv
    setlocal
    set "dirs=%~1"
    set "char=%~2"
    set "args=%~3"

    rem echo MAKE_INDIV_DIRS "!dirs!"
    rem echo ARSGS "!args!"
    set smpl=
    set indv=
    set nest=
    for /f "tokens=1 delims=|" %%i in ("!dirs!") do (
        set "smpl=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!dirs!") do (
        set "indv=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!dirs!") do (
        set "nest=%%i"
    )


    set char_num=
    set brid_num=
    set func_encap=
    for /f "tokens=1 delims=|" %%i in ("!args!") do (
        set "brid_num=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!args!") do (
        set "char_num=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!args!") do (
        set "func_encap=%%i"
    )

    

    set "enc_l=("
    set "enc_r=)"
    set "cap_c=P"

    if "!char!" equ "c" (
        set "enc_l={"
        set "enc_r=}"
        set "cap_c=C"
    )

    if "!char!" equ "s" (
        set "enc_l=["
        set "enc_r=]"
        set "cap_c=S"
    )

    set "name=!enc_l!!cap_c!!char_num! +!enc_r!"
    set "dest_dir=!smpl!\!indv!\STAGE_!char_num!"

    if "!func_encap!" equ "*" (
        set "name=!name!|"
        echo !name! > indiv.txt
        exit /b
    )



    if not exist "!dest_dir!" (
        md "!dest_dir!"
    )
    echo !name! > "!dest_dir!\!name!"

    call :prepend_bridge "!name!" "!brid_num!" "!dest_dir!"

    
    endlocal
exit /b

:prepend_bridge
    setlocal
    set "name=%~1"
    set "brid_num=%~2"
    set "dir=%~3"


    set "b=BRIDGE !brid_num!"
    set "sb= !b!"
    set "bs=!b! "
    set "sbs= !b! "

    set "bn=!b!!name!"
    set "sbn=!sb!!name!"
    set "bsn=!bs!!name!"
    set "sbsn=!sbs!!name!"
    echo !bn! > "!dir!\!bn!"
    echo !sbn! > "!dir!\!sbn!"
    echo !bsn! > "!dir!\!bsn!"
    echo !sbsn! > "!dir!\!sbsn!"
    endlocal
exit /b


:after_1st_nested
    setlocal

    set "dirs=%~1"
    set "args=%~2"

    set fpath=

    
    set smpl=
    set indv=
    set nest=
    for /f "tokens=1 delims=|" %%i in ("!dirs!") do (
        set "smpl=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!dirs!") do (
        set "indv=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!dirs!") do (
        set "nest=%%i"
    )


    set bri_num=
    set enc_num=
    set func_encap=
    
    for /f "tokens=1 delims=|" %%i in ("!args!") do (
        set "bri_num=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!args!") do (
        set "enc_num=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!args!") do (
        set "func_encap=%%i"
    )

    set "src_dir=!smpl!\!nest!\STAGE_!bri_num!"
    set "dest_dir=!smpl!\!nest!\STAGE_!enc_num!"

    set /a qty=0
    
    for %%i in ("!src_dir!\*") do (
        set "fpath=%%i"
            set file=
            set /a qty+=1
            echo DEST_DIR "!dest_dir!" !qty!
        for /f "tokens=2 delims=\" %%i in ("!fpath!") do (
            set "file=%%i"
            rem echo FILE IN DIRECTORY= "!file!"
            call :write "!dest_dir!" "!file!"


            rem Write this
            call :add_bridge "!file!" "!dest_dir!" "!enc_num!"


            rem Write these
            call :add_nested "!file!" "c" "" "2" "!dir!"
            call :add_nested "!file!" "p" "" "2" "!dir!"
            call :add_nested "!file!" "s" "" "2" "!dir!"

            set "b=BRIDGE !enc_num!"
            set "sb= !b!"
            set "bs=!b! "
            set "sbs= !b! "


            rem Write these
            call :add_nested "!file!" "c" "!b!" "!dirs!"  "!args!"
            call :add_nested "!file!" "p" "!b!" "!dirs!"  "!args!"
            call :add_nested "!file!" "s" "!b!" "!dirs!"  "!args!"


            call :add_nested "!file!" "c" "!sb!" "!dirs!"  "!args!"
            call :add_nested "!file!" "p" "!sb!" "!dirs!"  "!args!"
            call :add_nested "!file!" "s" "!sb!" "!dirs!"  "!args!"

            call :add_nested "!file!" "c" "!bs!" "!dirs!"  "!args!"
            call :add_nested "!file!" "p" "!bs!" "!dirs!"  "!args!"
            call :add_nested "!file!" "s" "!bs!" "!dirs!"  "!args!"

            call :add_nested "!file!" "c" "!sbs!" "!dirs!"  "!args!"
            call :add_nested "!file!" "p" "!sbs!" "!dirs!"  "!args!"
            call :add_nested "!file!" "s" "!sbs!" "!dirs!"  "!args!"



            set /a enc_num_=!enc_num!-1
            rem echo ENC !enc_num!

        rem Write these
        call :add_indiv "!file!" "c" "" "!dirs!"  "!args!"
        call :add_indiv "!file!" "p" "" "!dirs!"  "!args!"
        call :add_indiv "!file!" "s" "" "!dirs!"  "!args!"


        call :add_indiv "!file!" "c" "!b!" "!dirs!"  "!args!"
        call :add_indiv "!file!" "p" "!b!" "!dirs!"  "!args!"
        call :add_indiv "!file!" "s" "!b!" "!dirs!"  "!args!"


        call :add_indiv "!file!" "c" "!sb!" "!dirs!"  "!args!"
        call :add_indiv "!file!" "p" "!sb!" "!dirs!"  "!args!"
        call :add_indiv "!file!" "s" "!sb!" "!dirs!"  "!args!"

        call :add_indiv "!file!" "c" "!bs!" "!dirs!"  "!args!"
        call :add_indiv "!file!" "p" "!bs!" "!dirs!"  "!args!"
        call :add_indiv "!file!" "s" "!bs!" "!dirs!"  "!args!"

        call :add_indiv "!file!" "c" "!sbs!" "!dirs!"  "!args!"
        call :add_indiv "!file!" "p" "!sbs!" "!dirs!"  "!args!"
        call :add_indiv "!file!" "s" "!sbs!" "!dirs!"  "!args!"

    )

    )
    endlocal
exit /b

:add_nested
    setlocal
    set "file=%~1"
    set "char=%~2"
    set "bridge=%~3"

    set "dirs=%~4"
    set "args=%~5"


    set smpl=
    set indv=
    set nest=
    for /f "tokens=1 delims=|" %%i in ("!dirs!") do (
        set "smpl=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!dirs!") do (
        set "indv=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!dirs!") do (
        set "nest=%%i"
    )

    
    set bri_num=
    set enc_num=
    set func_encap=
    
    for /f "tokens=1 delims=|" %%i in ("!args!") do (
        set "bri_num=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!args!") do (
        set "enc_num=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!args!") do (
        set "func_encap=%%i"
    )

    
    set "src_dir=!smpl!\!indv!\STAGE_!bri_num!"
    set "dest_dir=!smpl!\!indv!\STAGE_!enc_num!"
   


    call :make_nested "!dirs!" "!char!" "!args!"
    for /f "tokens=1 delims=|" %%i in (nested.txt) do (
        set "encap=%%i"
        set "file=!file!!bridge!!encap!"
        
        rem Write this.
        rem echo "!file!"
        call :write "!dest_dir!" "!file!"


    )
    endlocal
exit /b

:make_nested
    setlocal
    set "dirs=%~1"
    set "char=%~2"
    set "args=%~3"

    set smpl=
    set indv=
    set nest=
    for /f "tokens=1 delims=|" %%i in ("!dirs!") do (
        set "smpl=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!dirs!") do (
        set "indv=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!dirs!") do (
        set "nest=%%i"
    )


    set char_num=
    set brid_num=
    set func_encap=
    for /f "tokens=1 delims=|" %%i in ("!args!") do (
        set "brid_num=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!args!") do (
        set "char_num=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!args!") do (
        set "func_encap=%%i"
    )

    set "enc_l=("
    set "enc_r=)"
    set "cap_c=P"

    if "!char!" equ "c" (
        set "enc_l={"
        set "enc_r=}"
        set "cap_c=C"
    )

    if "!char!" equ "s" (
        set "enc_l=["
        set "enc_r=]"
        set "cap_c=S"
    )

    set "name=!enc_l!!cap_c!!char_num!.0 + !enc_l!!cap_c!!char_num!.1 +!enc_r! !enc_l!!cap_c!!char_num!.2 +!enc_r! !cap_c!!char_num!.n +!enc_r!"
    set "dest_dir=!smpl!\!nest!\STAGE_!char_num!"

    if "!func_encap!" EQU "*" (
        set "name=!name!|"
        echo !name! > nested.txt
        exit /b
    )


    if not exist "!dest_dir!" (
        md "!dest_dir!"
    )
    echo !name! > "!dest_dir!\!name!"

    call :prepend_bridge "!name!" "!brid_num!" "!dest_dir!"
    endlocal
exit /b

:write
    setlocal
    set "path=%~1"
    set "file=%~2"
    rem echo PATH "!path!"
    rem echo FILE "!file!"
    rem echo "!brk!"
    if not exist "!path!" (
        md "!path!"
    )
    echo write file path "!path!\!file!"
     exit /b
    echo !file! > "!path!\!file!"
    endlocal
exit /b



:one
    setlocal
    endlocal
exit /b


rem three encapsulators
rem indiv-only, nested-only, 
rem with and without terminating bridge
rem s, s, s,
rem c, c, c
rem p, p, p

rem mixed varianet
rem with and without terminating bridge

rem indiv, indiv, indiv
rem indiv, indiv, indiv, bridge
rem nested, nested, nested
rem nested, nested, nested, bridge
rem nested, indiv, nested
rem nested, indiv, nested, bridge
rem nested, nested, indiv
rem nested, nested, indiv, bridge
rem indiv, nested, nested
rem indiv, nested, nested, bridge
rem indiv, nested, indiv
rem indiv, nested, indiv, bridge


rem four (3 = all 3 + 1 repeated) encapsulators

rem


:last_char
    setlocal
    set "is=[s]"
    set "ip=(p)"
    set "ic={c}"
    set "in={}"
    set "d=.d88"
    set "b=BRIDGE"


    rem call :all_ones
    rem call :all_twos

    call :all_threes

    endlocal
exit /b


:all_ones
    setlocal
    call :one_ext_last "!ip1!" "!b!" "!d!"
    call :one_ext_last "!np1!" "!b!" "!d!"
    call :one_ext_last "!ic1!" "!b!" "!d!"
    call :one_ext_last "!nc1!" "!b!" "!d!"
    call :one_ext_last "!is1!" "!b!" "!d!"
    call :one_ext_last "!ns1!" "!b!" "!d!"

    endlocal
exit /b


:one_ext_last
    setlocal
    set "one=%~1"
    set "bridge=%~2"
    set "ext=%~3"
    
    call "funcs_last_char.bat" :find_last_char "" "!one!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!ext!" 
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !ext!" 
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !ext!"
    
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!" 
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!" 
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!"
    

    
    endlocal
exit /b


:all_twos
    setlocal
    call :two_ext_last "!ip1!" "!ic1!" "!b!" "!d!"
    call :two_ext_last "!ic1!" "!ip1!" "!b!" "!d!"
    call :two_ext_last "!ip1!" "!is1!" "!b!" "!d!"
    call :two_ext_last "!is1!" "!ip1!" "!b!" "!d!"
    call :two_ext_last "!is1!" "!ic1!" "!b!" "!d!"
    call :two_ext_last "!ic1!" "!is1!" "!b!" "!d!"

    call :two_ext_last "!np1!" "!nc1!" "!b!" "!d!"
    call :two_ext_last "!nc1!" "!np1!" "!b!" "!d!"
    call :two_ext_last "!np1!" "!ns1!" "!b!" "!d!"
    call :two_ext_last "!ns1!" "!np1!" "!b!" "!d!"
    call :two_ext_last "!ns1!" "!nc1!" "!b!" "!d!"
    call :two_ext_last "!nc1!" "!ns1!" "!b!" "!d!"

    call :two_ext_last "!np1!" "!ic1!" "!b!" "!d!"
    call :two_ext_last "!nc1!" "!ip1!" "!b!" "!d!"
    call :two_ext_last "!np1!" "!is1!" "!b!" "!d!"
    call :two_ext_last "!ns1!" "!ip1!" "!b!" "!d!"
    call :two_ext_last "!ns1!" "!ic1!" "!b!" "!d!"
    call :two_ext_last "!nc1!" "!is1!" "!b!" "!d!"

    call :two_ext_last "!ip1!" "!nc1!" "!b!" "!d!"
    call :two_ext_last "!ic1!" "!np1!" "!b!" "!d!"
    call :two_ext_last "!ip1!" "!ns1!" "!b!" "!d!"
    call :two_ext_last "!is1!" "!np1!" "!b!" "!d!"
    call :two_ext_last "!is1!" "!nc1!" "!b!" "!d!"
    call :two_ext_last "!ic1!" "!ns1!" "!b!" "!d!"

    endlocal
exit /b

:two_ext_last
    setlocal
    set "one=%~1"
    set "two=%~2"
    set "bridge=%~3"
    set "ext=%~4"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two!"
    
    call "funcs_last_char.bat" :find_last_char "" "!one! !two!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !two! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two!!ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!two!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two!!bridge! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two!!bridge!!ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !bridge! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two! !bridge! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !ext!"
    
    
    call "funcs_last_char.bat" :find_last_char "" "!one! !two!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !two!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!two!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two!!bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two!!bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge!"
    
    
    
    endlocal
exit /b

:all_threes
    setlocal
    
    call :three_ext_last "!is1!" "!ip1!" "!ic1!" "!b!" "!d!"
    call :three_ext_last "!is1!" "!ic1!" "!ip1!" "!b!" "!d!"
    call :three_ext_last "!ic1!" "!is1!" "!ip1!" "!b!" "!d!"
    call :three_ext_last "!ic1!" "!ip1!" "!is1!" "!b!" "!d!"
    call :three_ext_last "!ip1!" "!ic1!" "!is1!" "!b!" "!d!"
    call :three_ext_last "!ip1!" "!is1!" "!ic1!" "!b!" "!d!"

    
    call :three_ext_last "!ns1!" "!np1!" "!nc1!" "!b!" "!d!"
    call :three_ext_last "!ns1!" "!nc1!" "!np1!" "!b!" "!d!"
    call :three_ext_last "!nc1!" "!ns1!" "!np1!" "!b!" "!d!"
    call :three_ext_last "!nc1!" "!np1!" "!ns1!" "!b!" "!d!"
    call :three_ext_last "!np1!" "!nc1!" "!ns1!" "!b!" "!d!"
    call :three_ext_last "!np1!" "!ns1!" "!nc1!" "!b!" "!d!"

    
    call :three_ext_last "!is1!" "!np1!" "!ic1!" "!b!" "!d!"
    call :three_ext_last "!is1!" "!nc1!" "!ip1!" "!b!" "!d!"
    call :three_ext_last "!ic1!" "!ns1!" "!ip1!" "!b!" "!d!"
    call :three_ext_last "!ic1!" "!np1!" "!is1!" "!b!" "!d!"
    call :three_ext_last "!ip1!" "!nc1!" "!is1!" "!b!" "!d!"
    call :three_ext_last "!ip1!" "!ns1!" "!ic1!" "!b!" "!d!"

    
    call :three_ext_last "!ns1!" "!ip1!" "!nc1!" "!b!" "!d!"
    call :three_ext_last "!ns1!" "!ic1!" "!np1!" "!b!" "!d!"
    call :three_ext_last "!nc1!" "!is1!" "!np1!" "!b!" "!d!"
    call :three_ext_last "!nc1!" "!ip1!" "!ns1!" "!b!" "!d!"
    call :three_ext_last "!np1!" "!ic1!" "!ns1!" "!b!" "!d!"
    call :three_ext_last "!np1!" "!is1!" "!nc1!" "!b!" "!d!"
    endlocal
exit /b

:three_ext_last
    setlocal
    set "one=%~1"
    set "two=%~2"
    set "three=%~3"
    set "bridge=%~4"
    set "ext=%~5"

    call "funcs_last_char.bat" :find_last_char "" "!one!!two!!three!!ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !two!!three!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !two!!three! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !two! !three!!ext!"
    
    call "funcs_last_char.bat" :find_last_char "" "!one! !two! !three! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!two! !three!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two!!three! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two! !three! !ext!"
    
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two!!three!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two!!three! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two! !three!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two! !three! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two!!three!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two!!three! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two! !three!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two! !three! !ext!"


    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !three!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !three! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two!!three!!bridge!!ext!"
    
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!!ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!!ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three! !bridge! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three! !bridge!!ext!"

    rem --
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!!ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!!ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three! !bridge! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three! !bridge!!ext!"

    rem --
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!bridge! !three!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!bridge! !three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!bridge! !three! !bridge!!ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !bridge!!three!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !bridge!!three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !bridge!!three! !bridge!!ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge! !ext!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge!!ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge! !ext!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge!!ext!"


    call "funcs_last_char.bat" :find_last_char "" "!one!!two!!three!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !two!!three!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !two!!three!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !two! !three!"
    
    call "funcs_last_char.bat" :find_last_char "" "!one! !two! !three!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!two! !three!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two!!three!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!two! !thre!"
    
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two!!three!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two!!three!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two! !three!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two! !three!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two!!three!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two!!three!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two! !three!"
    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge! !two! !three!"


    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !three!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !three!"

    call "funcs_last_char.bat" :find_last_char "" "!one!!bridge!!two!!three!!bridge!"
    
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three! !bridge!"

    rem --
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two!!three! !bridge!"

    rem --
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!bridge! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!bridge! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two!!bridge! !three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !bridge!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !bridge!!three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge!!two! !bridge!!three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge!"

    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three!!bridge!"
    call "funcs_last_char.bat" :find_last_char "" "!one! !bridge! !two! !bridge! !three! !bridge!"



    endlocal
exit /b