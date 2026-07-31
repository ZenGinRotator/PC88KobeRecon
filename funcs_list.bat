@ setlocal EnableDelayedExpansion



@ call %*
@ goto :eof






:list_gen

set "prim_dirs=%~1"
set "secnd_dirs=%~2"
@ set src=
@ set u_scor=
@ set prnth=
@ set sqr_brkt=
@ set curl_brkt=
@ set exts=
@ set compl=
set encaptor=
set encapted=

for /f "tokens=1 delims=|" %%i in ("!prim_dirs!") do (
    @ set "src=%%i"
)
for /f "tokens=2 delims=|" %%i in ("!prim_dirs!") do (
    @ set "u_scor=%%i"
)
for /f "tokens=3 delims=|" %%i in ("!prim_dirs!") do (
    @ set "prnth=%%i"
)
for /f "tokens=4 delims=|" %%i in ("!prim_dirs!") do (
    @ set "sqr_brkt=%%i"
)
for /f "tokens=5 delims=|" %%i in ("!prim_dirs!") do (
    @ set "curl_brkt=%%i"
)
for /f "tokens=6 delims=|" %%i in ("!prim_dirs!") do (
    @ set "exts=%%i"
)
for /f "tokens=7 delims=|" %%i in ("!prim_dirs!") do (
    @ set "compl=%%i"
)

set quan=
set prelim=
set label=
for /f "tokens=1 delims=|" %%i in ("!secnd_dirs!") do (
    set "quan=%%i"
)
for /f "tokens=6 delims=|" %%i in ("!secnd_dirs!") do (
    set "encaptor=%%i"
)

for /f "tokens=7 delims=|" %%i in ("!secnd_dirs!") do (
    set "prelim=%%i"
)

for /f "tokens=8 delims=|" %%i in ("!secnd_dirs!") do (
    set "label=%%i"
)

for /f "tokens=9 delims=|" %%i in ("!secnd_dirs!") do (
    set "encapted=%%i"
)

set "prelim_label=!prelim!_!label!"




for /d %%i in ("!src!\*") do (

    rem call :underscores "!u_scor!\DIR" "%%~nxi"

    set "pl_dir=%prelim_label%\DIR"
    set "pare_pl_d=!prnth!\!pl_dir!"
    set "sqr_pl_d=!sqr_brkt!\!pl_dir!"
    set "curl_pl_d=!curl_brkt!\!pl_dir!"
    rem echo "!pare_pl_d!"
    rem echo "!sqr_pl_d!"
    rem echo "!curl_pl_d!"
    rem echo "^"
   
    

    rem call "funcs_prelim_labels.bat" :parenths "!pare_pl_d!" "%%~nxi"
    rem call "funcs_prelim_labels.bat" :sqr_brackets "!sqr_pl_d!" "%%~nxi"
    rem call "funcs_prelim_labels.bat" :curly_brackets "!curl_pl_d!" "%%~nxi"

    rem Call these functions one at a time because of the HUGE time penalty
    rem     when creating the directories and files.


    set "qed=!quan!\!encaptor!\DIR"

    set "pqed=!prnth!\!qed!"
    set "sqed=!sqr_brkt!\!qed!"
    set "cqed=!curl_brkt!\!qed!"

    rem echo "!pqed!"
    rem echo "!sqed!"
    rem echo "!cqed!"
    rem echo -


    rem call "funcs_encapsulator_qty.bat" :parenth "%%~nxi" "!secnd_dirs!" "!pqed!"
    rem call "funcs_encapsulator_qty.bat" :square "%%~nxi" "!secnd_dirs!" "!sqed!"
    rem call "funcs_encapsulator_qty.bat" :curly "%%~nxi" "!secnd_dirs!" "!cqed!"

    rem need to isolate an encapsulated disk/Disk from parenthese...
    rem .... but need to have prior knowledge about the maximum number of encapsulated words
    rem .... within a found set of parentehesis

    set "qedd=!quan!\!encapted!\DIR"


    rem call :no_encaps_test "%~3\DIR" "%%~nxi"
    rem echo " --- %%~nxi ---"
    


    for %%j in ("%%i\*") do (

        rem call :underscores "!u_scor!\FILE\%%~nxi" "%%~nxj"


        set "pl_file=%prelim_label%\FILE"

        set "pplf=!prnth!\!pl_file!"
        set "splf=!sqr_brkt!\!pl_file!"
        set "cplf=!curl_brkt!\!pl_file!"



        rem call "funcs_prelim_labels.bat" :parenths "!pplf!" "%%~nxj"
        rem call "funcs_prelim_labels.bat" :sqr_brackets "!splf!" "%%~nxj"
        rem call "funcs_prelim_labels.bat" :curly_brackets "!cplf!" "%%~nxj"


        rem call :extensions "!exts!\%%~xj" "%%~nxj"
        rem call :completed "!compl!\%%~nxi" "%%~nxj" 

        set "qef=!quan!\!encaptor!\FILE"
        set "pqef=!prnth!\!qef!"
        set "sqef=!sqr_brkt!\!qef!"
        set "cqef=!curl_brkt!\!qef!"

        rem echo "!pqef!"
        rem echo "!sqef!"
        rem echo "!cqef!"
        rem pause

        rem call "funcs_encapsulator_qty.bat" :parenth "%%~nxj" "!secnd_dirs!" "!pqef!"
        rem call "funcs_encapsulator_qty.bat" :square "%%~nxj" "!secnd_dirs!" "!sqef!"
        rem call "funcs_encapsulator_qty.bat" :curly "%%~nxj" "!secnd_dirs!" "!cqef!"
        
        rem this parses all words encapsulated by parentheses
        set "qedf=!quan!\!encapted!\FILE"
        call "funcs_encapsulated_qty.bat" :parenth_word_qty "%%~nj" "!secnd_dirs!" "!prnth!\!qedf!"

        rem call :no_encaps_test "%~3\FILE" "%%~nxj"
    )

)

@ rem %~2 = LIST_MADE
rem  echo > "%~2"
exit /b

:completed
    @ call "funcs_no_make.bat" :file_into_dir "%~1" "%~2"
exit /b



:underscores

    @ set part=
    for /f "tokens=1 delims=_" %%i in ("%~2") do (
        @ set "part=%%i"
    )

    
    
    @ rem @ goto :eof
    if "%~2" neq "!part!" (
        @ call "funcs_no_make.bat" :file_into_dir "%~1" "%~2"
    )
exit /b








:extensions
    @ call "funcs_no_make.bat" :file_into_dir "%~1" "%~2"
exit /b

:no_encaps_test

    echo "%~2"
    set no_sqr_brkt=
    set no_curl_brkt=
    set no_parenth=
    for /f "tokens=1 delims=[" %%i in ("%~2") do (
        set "no_sqr_brkt=%%i"
    )
    for /f "tokens=1 delims={" %%i in ("%~2") do (
        set "no_curl_brkt=%%i"
    )

    for /f "tokens=1 delims=(" %%i in ("%~2") do (
        set "no_parenth=%%i"
    )
    rem ECHO "!no_sqr_brkt!" "%~2"
    rem pause
    if "!no_sqr_brkt!" neq "%~2" (
        exit /b
    )
    if "!no_curl_brkt!" neq "%~2" (
        exit /b
    )
    if "!no_parenth!" neq "%~2" (
        exit /b
    )
    call "funcs_no_make.bat" :file_into_dir "%~1" "%~2"
    
exit /b


