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



rem output directories for sample: indiv & nested
rem SAMPLE\*
rem *INDV
rem *NEST
rem **NO_ENCAP - a bridge that can serve as a rom name (do this later)
REM **STAGE_1
REM     bridge & encap,

rem **STAGE_2
rem     bridge & encap & bridge & encap


rem **STAGE_3
rem     bridge & encap & bridge & encap & bridge & encap

rem **STAGE_4
rem     bridge & encap, bridge & encap, bridge & encap, bridge & encap

rem ARGUEMENTS FOR FUNCTION CALLS
rem char: c, p, s
rem char_num: 1, 2, 3, 4
rem bridge_num: 0 (indicates space), 1, 2, 3,
rem src_dir: 0 (none), 1, 2, 3
rem dest_dir: 1, 2, 3, 4
rem ** unsure of what arguements required for mixed (nested with indiv and vice-versa)


rem need bridges before the first, single encap


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



call %*

goto :eof


:make_samples
    setlocal
    
set "smp=SAMPLE"
set "ndv=INDIV"
set "nst=NESTED"
set "stg=STAGE"
set "dest_dirs=ALL|SUBSET"
set "sub=SUBSET"
set "all=ALL"

set "dirs=!smp!|!ndv!|!nst!|!stg!|!sub!|!all!"

REM SAMPLE\INDIV\
REM SUB\STAGE_X, where X=1, 2, 3, 4
REM ALL\STAGE_X, where X=1, 2, 3, 4

REM SAMPLE\NESTED
REM SUB\STAGE_X, X=1,2,3,4
REM ALL\STAGE_X, X=1,2,3,4

REM ALL
REM SUB
rem STAGE_1
REM STAGE_2
REM STAGE_3
REM STAGE_4
set "stg2_args=1|2|*"
set "stg3_args=2|3|*"
set "stg4_args=3|4|*"
set "idest_root=!sampl!\!indv!"
set "idest_dir=!sampl!\!indv!\!sub!"
rem rename to all_encap
call "funcs_last_sample_data.bat" :all_indiv "!dirs!" "!idest_dir!"
call "funcs_last_sample_data.bat" :after_1st_stage "!dirs!" "!stg2_args!" ""
exit /b



REM call "funcs_last_sample_data.bat" :after_1st_indiv "!dirs!" "!stg3_args!" "!dest_dirs!" "!idest_root!" "!idest_dir!"
REM call "funcs_last_sample_data.bat" :after_1st_indiv "!dirs!" "!stg4_args!" "!dest_dirs!" "!idest_root!" "!idest_dir!"



REM set "ndest_root=!sampl!\!nest!"
REM set "ndest_dir=!sampl!\!nest!\!sub!"
 REM call "funcs_last_sample_data.bat" :all_nested "!dirs!" "!ndest_root!" "!dest_dirs!" "!ndest_dir!"
REM call "funcs_last_sample_data.bat" :after_1st_nested "!dirs!" "!stg2_args!" "!dest_dirs!" "!ndest_dir!"
 REM call "funcs_last_sample_data.bat" :after_1st_nested "!dirs!" "!stg3_args!" "!dest_dirs!" "!ndest_dir!"
REM call "funcs_last_sample_data.bat" :after_1st_nested "!dirs!" "!stg4_args!" "!dest_dirs!" "!ndest_dir!"
    endlocal
exit /b

rem change to all_encap
:all_indiv
    setlocal
    set "dirs=%~1"

    set smp=
    set ndv=
    set nst=
    set stg=
    set sbst=
    set all=
    for /f "tokens=1 delims=|" %%i in ("!dirs!") do (
        set "smp=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!dirs!") do (
        set "ndv=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!dirs!") do (
        set "nst=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!dirs!") do (
        set "stg=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("!dirs!") do (
        set "sbst=%%i"
    )
    for /f "tokens=6 delims=|" %%i in ("!dirs!") do (
        set "all=%%i"
    )



    set "char_num=1"
    set "brid_num=1"
    set "func_encap="

    set "args=!brid_num!|!char_num!|!func_encap!"

    


    set "i_root=!smp!\!ndv!\!stg!_!char_num!"
    set "i_sbst_dir=!i_root!\!sbst!"
    set "i_all_dir=!i_root!\!all!"
    
    set "n_root=!smp!\!nst!\!stg!_!char_num!"
    set "n_sbst_dir=!n_root!\!sbst!"
    set "n_all_dir=!n_root!\!all!"
    
    set "dest_dirs=!i_sbst_dir!|!n_sbst_dir!|!i_all_dir!|!n_all_dir!"

    
    set put_in_dir=
    rem rename to make_encap
    call :make_encap "i" "c" "!args!" "!dest_dirs!" "!put_in_dir!"
    call :make_encap "i" "s" "!args!" "!dest_dirs!" "!put_in_dir!"
    call :make_encap "i" "p" "!args!" "!dest_dirs!" "!put_in_dir!"

    call :make_encap "n" "c" "!args!" "!dest_dirs!" "!put_in_dir!"
    call :make_encap "n" "s" "!args!" "!dest_dirs!" "!put_in_dir!"
    call :make_encap "n" "p" "!args!" "!dest_dirs!" "!put_in_dir!"

    endlocal
exit /B



:after_1st_stage
    setlocal
    set "dirs=%~1"
    set "stg_args=%~2"
    set "echo_only=%~3"


    
    call :read "i" "s" "!dirs!" "!stg_args!" "!echo_only!"
    call :read "i" "a" "!dirs!" "!stg_args!" "!echo_only!"
    call :read "n" "s" "!dirs!" "!stg_args!" "!echo_only!"
    call :read "n" "a" "!dirs!" "!stg_args!" "!echo_only!"
    
   
    exit /b
    

    endlocal
exit /b

:read
    setlocal
    set "type=%~1"
    set "sub_or_all=%~2"
    set "dirs=%~3"
    set "stg_args=%~4"
    set "echo_only=%~5"

   
    for /f "tokens=1 delims=|" %%i in ("!dirs!") do (
        set "src=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!dirs!") do (
        set "dest=%%i"        
    )

    
    set smp=
    set ndv=
    set nst=
    set stg=
    set sbst=
    set all=
    for /f "tokens=1 delims=|" %%i in ("!dirs!") do (
        set "smp=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!dirs!") do (
        set "ndv=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!dirs!") do (
        set "nst=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!dirs!") do (
        set "stg=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("!dirs!") do (
        set "sbst=%%i"
    )
    for /f "tokens=6 delims=|" %%i in ("!dirs!") do (
        set "all=%%i"
    )


    set bri_num=
    set enc_num=
    set func_encap=
    
    for /f "tokens=1 delims=|" %%i in ("!stg_args!") do (
        set "bri_num=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!stg_args!") do (
        set "enc_num=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!stg_args!") do (
        set "func_encap=%%i"
    )

    REM I, S
    set "i_ndv_sub_src=!smp!\!ndv!\!stg!_!bri_num!\!sbst!"
    set "i_ndv_sub_dest=!smp!\!ndv!\!stg!_!enc_num!\!sbst!"
    



    REM I, A
    set "i_ndv_all_src=!smp!\!ndv!\!stg!_!bri_num!\!all!"
    set "i_ndv_all_dest=!smp!\!ndv!\!stg!_!enc_num!\!all!"




    REM N, S
    set "n_nst_sub_src=!smp!\!nst!\!stg!_!bri_num!\!sbst!"
    set "n_nst_sub_dest=!smp!\!nst!\!stg!_!enc_num!\!sbst!"

    REM N, A
    set "n_nst_all_src=!smp!\!nst!\!stg!_!bri_num!\!all!"
    set "n_nst_all_dest=!smp!\!nst!\!stg!_!enc_num!\!all!"

    set "src=!i_ndv_sub_src!"
    set "dest=!i_ndv_sub_dest!"
    set "same=i"
    set "mixed=n"

    if "!type!" equ "i" (
        if "!sub_or_all!" equ "a" (
            set "src=!i_ndv_all_src!"
            set "dest=!i_ndv_all_dest!"
        )
    ) else (
        set "same=n"
        set "mixed=i"
        set "src=!n_nst_sub_src!"
        set "dest=!n_nst_sub_dest!"
        if "!sub_or_all!" equ "a" (
            set "src=!n_nst_all_src!"
            set "dest=!n_nst_all_dest!"
        )

    )


    echo "!brk!" READ...
    echo TYPE "!type!"
    ECHO SUB OR ALL "!sub_or_all!"
    echo SRC "!src!"
    echo DEST "!dest!"
    echo ECHO ONLY "!echo_only!"
    echo SAME "!same!"
    echo MIXED "!mixed!"
    
    
    set /a qty=0
    for %%i in ("!src!\*") do (
        set "fpath=%%i"
        set file=
        for /f "tokens=5 delims=\" %%j in ("!fpath!") do (
            set "file=%%j"
        )
        set /a qty+=1
        echo QTY "!qty!"
      
        set "bridge=BRIDGE"
        set "sm=!same!|!mixed!"
        set "fbe=!file!|!bridge!|!enc_num!"
        set "sde=!stg_args!/!dest!/!echo_only!"

        if "!sub_or_all!" equ "s" (    
            call :do_sub "!sm!" "!fbe!" "!sde!"
               
        ) else (        
            call :do_sub "!sm!" "!fbe!" "!sde!"
        )
    )



    endlocal
exit /b




:do_sub
    setlocal
    set "sm=%~1"
    set "fbe=%~2"
    set "sde=%~3"


    set same=
    set mixed=
    for /f "tokens=1 delims=|" %%i in ("!sm!") do (
        set "same=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!sm!") do (
        set "mixed=%%i"
    )

    set file=
    set bridge=
    set enc_num=
    for /f "tokens=1 delims=|" %%i in ("!fbe!") do (
        set "file=%%i"       
    )
    for /f "tokens=2 delims=|" %%i in ("!fbe!") do (
        set "bridge=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!fbe!") do (
        set "enc_num=%%i"
    )

    set stg_args=
    set dest=
    set echo_only=

    for /f "tokens=1 delims=/" %%i in ("!sde!") do (
        set "stg_args=%%i"
    )
    for /f "tokens=2 delims=/" %%i in ("!sde!") do (
        set "dest=%%i"
    )
    for /f "tokens=3 delims=/" %%i in ("!sde!") do (
        set "echo_only=%%i"        
    )


    call :write "!dest!" "!file!" "!echo_only!"
    call :add_only_bridge "!file!" "!dest!" "!enc_num!" "!echo_only!"


    set "b=!bridge! !enc_num!"
    set "sb= !b!"
    set "bs=!b! "
    set "sbs= !b! "

    
    call :add_bridge_n_encap "!same!" "c" "!file!" "" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "p" "!file!" "!b!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "s" "!file!" "!sb!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "c" "!file!" "!bs!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "p" "!file!" "!sbs!" "!stg_args!" "!dest!" "!echo_only!"

    echo ---- mixed ----
    call :add_bridge_n_encap "!mixed!" "p" "!file!" "" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "s" "!file!" "!b!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "c" "!file!" "!sb!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "p" "!file!" "!bs!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "s" "!file!" "!sbs!" "!stg_args!" "!dest!" "!echo_only!"

    endlocal
exit /B


:do_all
    setlocal
    set "sm=%~1"
    set "fbe=%~2"
    set "sde=%~3"


    set same=
    set mixed=
    for /f "tokens=1 delims=|" %%i in ("!sm!") do (
        set "same=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!sm!") do (
        set "mixed=%%i"
    )

    set file=
    set bridge=
    set enc_num=
    for /f "tokens=1 delims=|" %%i in ("!fbe!") do (
        set "file=%%i"       
    )
    for /f "tokens=2 delims=|" %%i in ("!fbe!") do (
        set "bridge=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!fbe!") do (
        set "enc_num=%%i"
    )

    set stg_args=
    set dest=
    set echo_only=

    for /f "tokens=1 delims=/" %%i in ("!sde!") do (
        set "stg_args=%%i"
    )
    for /f "tokens=2 delims=/" %%i in ("!sde!") do (
        set "dest=%%i"
    )
    for /f "tokens=3 delims=/" %%i in ("!sde!") do (
        set "echo_only=%%i"        
    )

    
    call :write "!dest!" "!file!" "!echo_only!"
    call :add_only_bridge "!file!" "!dest!" "!enc_num!" "!echo_only!"


    set "b=!bridge! !enc_num!"
    set "sb= !b!"
    set "bs=!b! "
    set "sbs= !b! "

                   
    call :write "!dest!" "!file!" "!echo_only!"
    
    call :add_only_bridge "!file!" "!dest!" "!enc_num!" "!echo_only!"

    call :add_bridge_n_encap "!same!" "c" "!file!" "" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "p" "!file!" "" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "s" "!file!" "" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "p" "!file!" "" "!stg_args!" "!dest!" "!echo_only!"



    call :add_bridge_n_encap "!same!" "c" "!file!" "!b!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "p" "!file!" "!b!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "s" "!file!" "!b!" "!stg_args!" "!dest!" "!echo_only!"


    rem Use s
    call :add_bridge_n_encap "!same!" "c" "!file!" "!sb!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "p" "!file!" "!sb!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "s" "!file!" "!sb!" "!stg_args!" "!dest!" "!echo_only!"

    rem Use c
    call :add_bridge_n_encap "!same!" "c" "!file!" "!bs!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "p" "!file!" "!bs!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "s" "!file!" "!bs!"  "!stg_args!" "!dest!" "!echo_only!"

            rem Use p
    call :add_bridge_n_encap "!same!" "c" "!file!" "!sbs!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "p" "!file!" "!sbs!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!same!" "s" "!file!" "!sbs!" "!stg_args!" "!dest!" "!echo_only!"
            
            

      
    rem Use p
    call :add_bridge_n_encap "!mixed!" "c" "!file!" "" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "p" "!file!" "" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "s" "!file!" "" "!stg_args!" "!dest!" "!echo_only!"

    rem Use s
    call :add_bridge_n_encap "!mixed!" "c" "!file!" "!b!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "p" "!file!" "!b!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "s" "!file!" "!b!" "!stg_args!" "!dest!" "!echo_only!"

    rem use c
    call :add_bridge_n_encap "!mixed!" "c" "!file!" "!sb!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "p" "!file!" "!sb!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "s" "!file!" "!sb!" "!stg_args!" "!dest!" "!echo_only!"


    rem use p
    call :add_bridge_n_encap "!mixed!" "c" "!file!" "!bs!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "p" "!file!" "!bs!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "s" "!file!" "!bs!" "!stg_args!" "!dest!" "!echo_only!"

    rem use s
    call :add_bridge_n_encap "!mixed!" "c" "!file!" "!sbs!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "p" "!file!" "!sbs!" "!stg_args!" "!dest!" "!echo_only!"
    call :add_bridge_n_encap "!mixed!" "s" "!file!" "!sbs!" "!stg_args!" "!dest!" "!echo_only!"


    endlocal
exit /b

:add_only_bridge
    setlocal
    set "file=%~1"
    set "dir=%~2"
    set "brid_num=%~3"
    set "echo_only=%~4"

    rem echo ADD BRIDGE, ECHO ONLY "!echo_only!"
    rem ECHO ADD BRIDGE
    set bridge=
    call :make_bridge "!brid_num!"
    for /f "tokens=1 delims=|" %%i in (bridge.txt) do (
        set "bridge=%%i"
        rem Write all
        call :write "!dir!" "!file!!bridge!" "!echo_only!"
        call :write "!dir!" "!file!!bridge! " "!echo_only!"
        call :write "!dir!" "!file! !bridge!" "!echo_only!"
        call :write "!dir!" "!file! !bridge! " "!echo_only!"

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


:add_bridge_n_encap
    setlocal
    set "type=%~1"
    set "char=%~2"
    set "file=%~3"
    
    set "bridge=%~4"
    set "args=%~5"
    set "dest_dir=%~6"
    set "echo_only=%~7"


    
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

    

rem ECHO TYPE "!type!"
rem echo "!char!"
rem echo "!file!"
rem echo "!bridge!"
rem echo "!args!"
rem echo "!dest_dir!"

rem     set empty_dest_dir=
    call :make_encap "!type!" "!char!" "!args!" "!dest_dir!" "!echo_only!"
    for /f "tokens=1 delims=|" %%i in (encap.txt) do (
        set "encap=%%i"
        rem ECHO ENCAP "!encap!"
        rem pause
        set "file=!file!!bridge!!encap!"

        rem Write this
        call :write "!dest_dir!" "!file!" "!echo_only!"

    )
    endlocal
exit /b

:double_n
    setlocal
    endlocal
exit /b

rem args=!char_num!|!brid_num!|!func_encap!

rem change to make_encap
:make_encap
    setlocal
    set "type=%~1"
    set "char=%~2"
    set "args=%~3"
    set "dest_dirs=%~4"
    set "echo_only=%~5"

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

    if "!type!" equ "n" (
        set "name=!enc_l!!cap_c!!char_num!.0 + !enc_l!!cap_c!!char_num!.1 +!enc_r! !enc_l!!cap_c!!char_num!.2 +!enc_r! !cap_c!!char_num!.n +!enc_r!"
    )
    
    

    if "!func_encap!" equ "*" (
        set "name=!name!|"
        echo !name! > encap.txt
        exit /b
    )

    set i_sub_dir=
    set n_sub_dir=
    set i_all_dir=
    set n_all_dir=
    for /f "tokens=1 delims=|" %%i in ("!dest_dirs!") do (
        set "i_sub_dir=%%i"
    )
    for /f "tokens=2 delims=|" %%i in ("!dest_dirs!") do (
        set "n_sub_dir=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!dest_dirs!") do (
        set "i_all_dir=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!dest_dirs!") do (
        set "n_all_dir=%%i"
    )


    if "!type!" equ "i" (
        call :check_n_write "!i_sub_dir!" "!name!" "!echo_only!"
        call :check_n_write "!i_all_dir!" "!name!" "!echo_only!"
        exit /b
    )

    
    call :check_n_write "!n_sub_dir!" "!name!" "!echo_only!"
    call :check_n_write "!n_all_dir!" "!name!" "!echo_only!"

    endlocal
exit /b

:check_n_write
    setlocal
    set "dest_dir=%~1"
    set "name=%~2"
    set "echo_only=%~3"

    if not exist "!dest_dir!" (
        md "!dest_dir!"
    )

   
    call :write "!dest_dir!" "!name!" "!echo_only!"
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











:write
    setlocal
    set "path=%~1"
    set "file=%~2"
    set "echo_only=%~3"
   
    if not exist "!path!" (
        md "!path!"
    )
    set "fpath=!path!\!file!"
    echo "!echo_only!"  write file path "!fpath!"
    if "!echo_only!" neq "" (
        exit /b
    )
    

    if not exist "!fpath!" (
        echo !file! > "!fpath!"
    )
    
    endlocal
exit /b













































:all_nested
    setlocal

    rem set "dirs=%~1"
    set "dest_root=%~2"
    set "dest_dirs=%~3"

    
    set "char_num=1"
    set "brid_num=1"
    set "func_encap="

    set "args=!brid_num!|!char_num!|!func_encap!"


    call :make_nested "c" "!args!" "!dest_root!\STAGE_!char_num!"
    call :make_nested "s" "!args!" "!dest_root!\STAGE_!char_num!"
    call :make_nested "p" "!args!" "!dest_root!\STAGE_!char_num!"
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
        for /f "tokens=4 delims=\" %%i in ("!fpath!") do (
            set "file=%%i"
          
            call :write "!dest_dir!" "!file!"


            rem Write this
            call :add_bridge "!file!" "!dest_dir!" "!enc_num!"


            rem Write these
            call :add_nested "!file!" "c" "" "!args!" "!dest_dir!"
            call :add_nested "!file!" "p" "" "!args!" "!dest_dir!"
            call :add_nested "!file!" "s" "" "!args!" "!dest_dir!"

            set "b=BRIDGE !enc_num!"
            set "sb= !b!"
            set "bs=!b! "
            set "sbs= !b! "


            rem Write these
            call :add_nested "!file!" "c" "!b!" "!args!" "!dest_dir!"
            call :add_nested "!file!" "p" "!b!" "!args!" "!dest_dir!"
            call :add_nested "!file!" "s" "!b!" "!args!" "!dest_dir!"


            call :add_nested "!file!" "c" "!sb!" "!args!" "!dest_dir!"
            call :add_nested "!file!" "p" "!sb!" "!args!" "!dest_dir!"
            call :add_nested "!file!" "s" "!sb!" "!args!" "!dest_dir!"

            call :add_nested "!file!" "c" "!bs!" "!args!" "!dest_dir!"
            call :add_nested "!file!" "p" "!bs!" "!args!" "!dest_dir!"
            call :add_nested "!file!" "s" "!bs!" "!args!" "!dest_dir!"

            call :add_nested "!file!" "c" "!sbs!" "!args!" "!dest_dir!"
            call :add_nested "!file!" "p" "!sbs!" "!args!" "!dest_dir!"
            call :add_nested "!file!" "s" "!sbs!" "!args!" "!dest_dir!"



            set /a enc_num_=!enc_num!-1
            rem echo ENC !enc_num!

        rem Write these
        call :add_indiv "!file!" "c" "" "!args!" "!dest_dir!"
        call :add_indiv "!file!" "p" "" "!args!" "!dest_dir!"
        call :add_indiv "!file!" "s" "" "!args!" "!dest_dir!"


        call :add_indiv "!file!" "c" "!b!" "!args!" "!dest_dir!"
        call :add_indiv "!file!" "p" "!b!" "!args!" "!dest_dir!"
        call :add_indiv "!file!" "s" "!b!" "!args!" "!dest_dir!"


        call :add_indiv "!file!" "c" "!sb!" "!args!" "!dest_dir!"
        call :add_indiv "!file!" "p" "!sb!" "!args!" "!dest_dir!"
        call :add_indiv "!file!" "s" "!sb!" "!args!" "!dest_dir!"

        call :add_indiv "!file!" "c" "!bs!" "!args!" "!dest_dir!"
        call :add_indiv "!file!" "p" "!bs!" "!args!" "!dest_dir!"
        call :add_indiv "!file!" "s" "!bs!" "!args!" "!dest_dir!"

        call :add_indiv "!file!" "c" "!sbs!" "!args!" "!dest_dir!"
        call :add_indiv "!file!" "p" "!sbs!" "!args!" "!dest_dir!"
        call :add_indiv "!file!" "s" "!sbs!" "!args!" "!dest_dir!"

    )

    )
    endlocal
exit /b

:add_nested
    setlocal
    set "file=%~1"
    set "char=%~2"
    set "bridge=%~3"
    set "args=%~4"
    set "dest_dir=%~5"


    
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

    
    


    call :make_nested "!char!" "!args!"
    for /f "tokens=1 delims=|" %%i in (nested.txt) do (
        set "encap=%%i"
        set "file=!file!!bridge!!encap!"
        
        call :write "!dest_dir!" "!file!"


    )
    endlocal
exit /b

:make_nested
    setlocal
    set "char=%~1"
    set "args=%~2"
    set "dest_dir=%~3"


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