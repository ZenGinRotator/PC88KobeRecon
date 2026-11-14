
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


:find_rom_label
    setlocal

    set "name=%~1"

    rem an optional or primary left character for deliminating rom from file name
    set "left=%~2"

    if exist return.txt ( del return.txt )

    set "rom="
    set /a error=0


    rem File name = ""
    if "!name!" equ "" (
        echo "" > return.txt
    )


    rem file name = " "
    if "!name!" equ " " (
        echo "" > return.txt
    )


    rem file name without rom name before first encapsulator (primary or optional)
    call ".\funcs\utils.bat" :delim_with_char "1" "!left!" "PAD#!name!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "rom=%%i"
    )

    if "!rom!" equ "PAD#" (
        echo "" > return.txt
    )

    rem file name with rom label, in which the former has or does not have an encapsulator (primary or optional)
    call ".\funcs\utils.bat" :delim_with_char "2" "#" "!rom!"
    for /f "tokens=1 delims=|" %%i in (%delimtxt%) do (
        set "rom=%%i"
    )


    set "rom=!rom!|"
    echo !rom! > return.txt

    endlocal
exit /b