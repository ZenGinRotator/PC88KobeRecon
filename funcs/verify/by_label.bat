setlocal EnableDelayedExpansion
set brk=^




call %*

goto :eof


:reconstruct2
    setlocal

    set file=positions.txt

    set old=
    set item=
    if exist !file! (
        for /f "tokens=1 delims=|" %%i in (!file!) do (
            set "old=!old!%%i!brk!"
        rem echo item: "%%i"

            set "item=%%i"
            call :parse "!item!"

        )
    )

    rem this is a temporary location for file deletion
    if exist !file! (
        del !file!
    )
    endlocal
exit /b




:parse
    setlocal
    set "item=%~1"
   
    set file_code=
    set /a positn=0
    for /f "tokens=1 delims=." %%i in ("!item!") do (
        set "file_code=%%i"
    )
    for /f "tokens=2 delims=." %%i in ("!item!") do (
        set "positn=%%i"
    )

    set file=bridges.txt


    if "!file_code!" equ "N" (
        set file=nested.txt
    )
    if "!file_code!" equ "I" (
        set file=indivs.txt
    )

    if "!file_code!" equ "S" (
        set file=spaces.txt
    )

    if "!file_code!" equ "R" (
        set file=rom.txt
    )

    
    rem indivs.txt
    rem nested.txt
    rem echo THE FILE "!file!"
    rem echo POSITION "!positn!"
    rem loop through the file and find counter that matches positn
    set /a qty=0
    set name=
    set label=
    for /f "tokens=*" %%i in (!file!) do (
        REM echo IN FILE "%%i"
        set /a qty+=1
        if "!qty!" equ "!positn!" (
             set "gotn=%%i"
             set "label="
            call ".\funcs\utils.bat" :delim_with_char "1" "#" "!gotn!"
            for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
                set "label=%%i"
            )
            set "name=!name!!label!"
        )
    )

    if not exist name.txt (
        set "name=!name!|"
        echo !name! > name.txt
        exit /b
    )

    set "old="
    for /f "tokens=1 delims=|" %%i in (name.txt) do (
         set "old=!old!%%i"
    )
    


    set "name=!old!!name!"
    rem echo OLD1 "!name!"
    
    rem echo OLD2 "!old2!"
    rem echo CONSTRUC 2 "!name!"
    set "name=!name!|"
    
    echo !name! > name.txt
    

    endlocal
exit /b


