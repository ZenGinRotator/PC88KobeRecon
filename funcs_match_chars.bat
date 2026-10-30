setlocal EnableDelayedExpansion

set delimtxt=delimited.txt
set brk=^



call %*

goto :eof

:slash_qty
    setlocal
    set "token=%~1"
    set "path=%~2"

    set item=
    call ".\funcs\utils.bat" :delim_with_char "!token!" "\" "!path!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "item=%%i"
    )


    if "!item!" equ " " (
        set "token=!token!|"
        echo !token! > token.txt
        exit /b
    )

    set /a token=!token!+1

    call :slash_qty "!token!" "!path!"
    endlocal
exit /b

:do_match
    setlocal

    set "src=%~1"
    rem set "name=%~1"
    set /a qty=0
    rem call ".\funcs\encaps\last.bat" :find_last_char "hi" "\"
    REM call "funcs_rom_keywords.bat" :start_kywds "hi"
    rem set "src=SAMPLE\INDIV\STAGE_1\SUBSET\"
    
    set /a tok_qty=0
    call :slash_qty "1" "!src!"
    for /f "tokens=1 delims=|" %%i in (token.txt) do (
        set /a tok_qty=%%i 
    )

    echo TOK QTY "!tok_qty!"
    
    
    
    call :loop "!tok_qty!" "!src!"
    endlocal
exit /b

:loop
    setlocal
    set "token=%~1"
    set "src=%~2"
    set "t1=(P1 +)  {C1 +} (P1 +) BRIDGE 2(P1 +) [S2 +] (P1 +) BRIDGE 3(P1.0 + (P2.1 +) (P2.2 +) P2.n +) {C3.0 + {C3.1 +} {C3.2 +} C3.n +} - Copy"
set "t2=(P1 +) Bridge 1 {C1 +} (P1 +) BRIDGE 2(P1 +) [S2 +] (P1 +) BRIDGE 3(P1.0 + (P2.1 +) (P2.2 +) P2.n +) {C3.0 + {C3.1 +} {C3.2 +} C3.n +} - Copy"
set "t3=(P1 +){C1 +} (P1 +) BRIDGE 2(P1 +) [S2 +] (P1 +) BRIDGE 3(P1.0 + (P2.1 +) (P2.2 +) P2.n +) {C3.0 + {C3.1 +} {C3.2 +} C3.n +} - Copy"    



set "t5=[S2 +] (P1 +) {C1+} - Copy"
set "t10=[S2 +](P1 +){C1+} - Copy"  
set "t4=[S2 +]  (P1 +)  {C1+} - Copy"
set "t8=[S2 +] BRIDGE 1 (P1 +)BRIDGE 2{C1+} - Copy" 


set "t6=[S2 + [s] [s] s] (P1 + (p) (p) (p) p) {C1+ {c} c} - Copy" 
set "t7=[S2 + [s] [s] s](P1 + (p) (p) (p) p){C1+ {c} c} - Copy" 
set "t11=[S2 + [s] [s] s]             (P1 + (p) (p) (p) p)   {C1+ {c} c} - Copy" 
set "t8=[S2 +] BRIDGE 1 (P1 +)BRIDGE 2{C1+} - Copy" 



set "t9=[S2 +]BRIDGE 1 (P1 +) BRIDGE 2 {C1+} - Copy"

    
call "funcs_rom_keywords.bat" :rom_n_labels "!t11!"
 call "funcs_rom_keywords.bat" :rom_n_labels "!t5!"
     call "funcs_rom_keywords.bat" :rom_n_labels "!t10!"
      call "funcs_rom_keywords.bat" :rom_n_labels "!t4!"
     call "funcs_rom_keywords.bat" :rom_n_labels "!t8!"
   
   call "funcs_rom_keywords.bat" :rom_n_labels "!t6!"
   call "funcs_rom_keywords.bat" :rom_n_labels "!t7!"
   call "funcs_rom_keywords.bat" :rom_n_labels "!t11!"

    exit /b



     
    call "funcs_rom_keywords" :rom_n_labels ""
    call "funcs_rom_keywords" :rom_n_labels " "
    call "funcs_rom_keywords" :rom_n_labels "hi"
  
    for %%i in ("!src!\*") DO (
        rem for %%i in ("SAMPLE\INDIV\STAGE_1\SUBSET\*") DO (
            rem for %%i in ("SAMPLE_FILE_NAMES\*") DO (
        set "path=%%i"
        set /a qty+=1
        echo QTY "!qty!"
        for /f "tokens=%~1 delims=\" %%j in ("!path!") do (
            set "file=%%j"
            rem call ".\funcs\encaps\last.bat" :find_last_char "!file!" "\"
            rem for /f "tokens=1 delims=|" %%i in (last_char.txt) do (
            rem  echo returned last_char "%%i"
            rem  )
            rem call "funcs_first_char.bat" :funcs\encaps\first "!file!" "\"
            rem  for /f "tokens=1 delims=|" %%i in (first_char.txt) do (
                rem echo returned first_char "%%i"
            rem  )
            
            
          

            call "funcs_rom_keywords.bat" :rom_n_labels "!file!"
pause
        )
    )
   
    endlocal
exit /b
