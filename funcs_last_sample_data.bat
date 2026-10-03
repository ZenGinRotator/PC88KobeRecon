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
    call :make_indiv "c" "1" ""
    call :make_indiv "s" "1" ""
    call :make_indiv "p" "1" ""
    endlocal
exit /B

:all_nested
    setlocal
    call :make_nested "c" "1"
    call :make_nested "s" "1"
    call :make_nested "p" "1"
    endlocal
exit /b


:after_1st_indiv
    setlocal
    set fpath=
    set "bri_num=%~1"
    set "enc_num=%~2"
    for %%i in ("SAMPLE_INDIV\*") do (
        set "fpath=%%i"
        set file=
        for /f "tokens=2 delims=\" %%j in ("!fpath!") do (
            set "file=%%j"
            echo "!file!"

            
            call :add_bridge "!file!" " "


            call :add_indiv "!file!" "c" "" "!enc_num!"
            call :add_indiv "!file!" "p" "" "!enc_num!"
            call :add_indiv "!file!" "s" "" "!enc_num!"

            set "b=BRIDGE !bri_num!"
            set "sb= !b!"
            set "bs=!b! "
            set "sbs= !b! "

            call :add_indiv "!file!" "c" "!b!" "!enc_num!" 
            call :add_indiv "!file!" "p" "!b!" "!enc_num!" 
            call :add_indiv "!file!" "s" "!b!" "!enc_num!" 


            call :add_indiv "!file!" "c" "!sb!" "!enc_num!" 
            call :add_indiv "!file!" "p" "!sb!" "!enc_num!" 
            call :add_indiv "!file!" "s" "!sb!" "!enc_num!" 

            call :add_indiv "!file!" "c" "!bs!" "!enc_num!" 
            call :add_indiv "!file!" "p" "!bs!" "!enc_num!" 
            call :add_indiv "!file!" "s" "!bs!" "!enc_num!" 

            call :add_indiv "!file!" "c" "!sbs!" "!enc_num!" 
            call :add_indiv "!file!" "p" "!sbs!" "!enc_num!" 
            call :add_indiv "!file!" "s" "!sbs!" "!enc_num!" 

            

            set /a enc_num_=!enc_num!-1
            rem echo ENC !enc_num!

            call :add_nested "!file!" "c" "" "!enc_num_!"
            call :add_nested "!file!" "p" "" "!enc_num_!"
            call :add_nested "!file!" "s" "" "!enc_num_!"


            call :add_nested "!file!" "c" "!b!" "!enc_num_!" 
            call :add_nested "!file!" "p" "!b!" "!enc_num_!" 
            call :add_nested "!file!" "s" "!b!" "!enc_num_!" 


            call :add_nested "!file!" "c" "!sb!" "!enc_num_!" 
            call :add_nested "!file!" "p" "!sb!" "!enc_num_!" 
            call :add_nested "!file!" "s" "!sb!" "!enc_num_!" 

            call :add_nested "!file!" "c" "!bs!" "!enc_num_!" 
            call :add_nested "!file!" "p" "!bs!" "!enc_num_!" 
            call :add_nested "!file!" "s" "!bs!" "!enc_num_!" 

            call :add_nested "!file!" "c" "!sbs!" "!enc_num_!" 
            call :add_nested "!file!" "p" "!sbs!" "!enc_num_!" 
            call :add_nested "!file!" "s" "!sbs!" "!enc_num_!" 




        )


    )

    endlocal
exit /b

:add_bridge
    setlocal
    set "file=%~1"

    set bridge=
    call :make_bridge "1"
    for /f "tokens=1 delims=|" %%i in (bridge.txt) do (
        set "bridge=%%i"
        echo "!file!!bridge!"
        echo "!file!!bridge! "
        echo "!file! !bridge!"
        echo "!file! !bridge! "

    )
    endlocal
exit /b

:make_bridge
    setlocal
    set "num=%~1"
    set "bridge=BRIDGE!|"
    echo !bridge! > bridge.txt
    endlocal
exit /b


:add_indiv
    setlocal
    set "file=%~1"
    set "char=%~2"
    
    set "bridge=%~3"
    set "num=%~4"
    set indiv=
    call :make_indiv "!char!" "!num!" "*"
    for /f "tokens=1 delims=|" %%i in (indiv.txt) do (
        set "indiv=%%i"
        set "file=!file!!bridge!!indiv!"
        echo "!file!"
    )
    endlocal
exit /b

:double_n
    setlocal
    endlocal
exit /b


:make_indiv
    setlocal
    set "char=%~1"
    set "num=%~2"
    set "dest_dir=%~3"

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

    set "name=!enc_l!!cap_c!!num! +!enc_r!"
    set "dir=SAMPLE_INDIV"

    if "!dest_dir!" neq "" (
        set "name=!name!|"
        echo !name! > indiv.txt
        exit /b
    )



    if not exist "!dir!" (
        md "!dir!"
    )
    echo !name! > "!dir!\!name!"

    call :prepend_bridge "!name!" "!dir!"

    set "name"
    endlocal
exit /b

:prepend_bridge
    setlocal
    set "name=%~1"
    set "dir=%~2"
    set "b=BRIDGE 0"
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
    set fpath=
    set "bri_num=%~1"
    set "enc_num=%~2"
    for %%i in ("SAMPLE_NESTED\*") do (
        set "fpath=%%i"
            set file=
        for /f "tokens=2 delims=\" %%i in ("!fpath!") do (
            set "file=%%i"
            echo FILE IN DIRECTORY= "!file!"

            call :add_bridge "!file!" " "



            call :add_nested "!file!" "c" "" "2"
            call :add_nested "!file!" "p" "" "2"
            call :add_nested "!file!" "s" "" "2"

            set "b=BRIDGE !bri_num!"
            set "sb= !b!"
            set "bs=!b! "
            set "sbs= !b! "

            call :add_nested "!file!" "c" "!b!" "2" 
            call :add_nested "!file!" "p" "!b!" "2" 
            call :add_nested "!file!" "s" "!b!" "2" 


            call :add_nested "!file!" "c" "!sb!" "2" 
            call :add_nested "!file!" "p" "!sb!" "2" 
            call :add_nested "!file!" "s" "!sb!" "2" 

            call :add_nested "!file!" "c" "!bs!" "2" 
            call :add_nested "!file!" "p" "!bs!" "2" 
            call :add_nested "!file!" "s" "!bs!" "2" 

            call :add_nested "!file!" "c" "!sbs!" "2" 
            call :add_nested "!file!" "p" "!sbs!" "2" 
            call :add_nested "!file!" "s" "!sbs!" "2" 



            set /a enc_num_=!enc_num!-1
            rem echo ENC !enc_num!


        call :add_indiv "!file!" "c" "" "!enc_num_!"
        call :add_indiv "!file!" "p" "" "!enc_num_!"
        call :add_indiv "!file!" "s" "" "!enc_num_!"


        call :add_indiv "!file!" "c" "!b!" "!enc_num_!" 
        call :add_indiv "!file!" "p" "!b!" "!enc_num_!" 
        call :add_indiv "!file!" "s" "!b!" "!enc_num_!" 


        call :add_indiv "!file!" "c" "!sb!" "!enc_num_!" 
        call :add_indiv "!file!" "p" "!sb!" "!enc_num_!" 
        call :add_indiv "!file!" "s" "!sb!" "!enc_num_!" 

        call :add_indiv "!file!" "c" "!bs!" "!enc_num_!" 
        call :add_indiv "!file!" "p" "!bs!" "!enc_num_!" 
        call :add_indiv "!file!" "s" "!bs!" "!enc_num_!" 

        call :add_indiv "!file!" "c" "!sbs!" "!enc_num_!" 
        call :add_indiv "!file!" "p" "!sbs!" "!enc_num_!" 
        call :add_indiv "!file!" "s" "!sbs!" "!enc_num_!" 

    )

    )
    endlocal
exit /b

:add_nested
    setlocal
        set "file=%~1"
    set "char=%~2"
    
    set "bridge=%~3"
    set "num=%~4"
    set indiv=
    call :make_nested "!char!" "!num!" "*"
    for /f "tokens=1 delims=|" %%i in (nested.txt) do (
        set "indiv=%%i"
        set "file=!file!!bridge!!indiv!"
        echo "!file!"
    )
    endlocal
exit /b

:make_nested
    setlocal
    set "char=%~1"
    set "num=%~2"
    set "dest_dir=%~3"

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

    set "name=!enc_l!!cap_c!!num!.0 + !enc_l!!cap_c!!num!.1 +!enc_r! !enc_l!!cap_c!!num!.2 +!enc_r! !cap_c!!num!.n +!enc_r!"
    set "dir=SAMPLE_NESTED"


    if "!dest_dir!" neq "" (
        set "name=!name!|"
        echo !name! > nested.txt
        exit /b
    )


    if not exist "!dir!" (
        md "!dir!"
    )
    echo !name! > "!dir!\!name!"

    call :prepend_bridge "!name!" "!dir!"
    endlocal
exit /b

:write
    setlocal
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