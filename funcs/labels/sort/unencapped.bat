setlocal EnableDelayedExpansion
set brk=^




call %*

goto :eof


:labels
    setlocal

    set "item=%~1"
    set "status=%~2"

    if "!item!" equ " " (
        exit /b
    )

    set /a keep=0

    if "!status!" equ "NESTED" (
        set /a keep+=1
    )
    if "!status!" equ "INDIV" (
        set /a keep+=1
    )

    if "!keep!" equ "0" (
        exit /b
    )


    set "code=LABEL_NESTED"
    if "!status!" equ "INDIV" (
        set "code=LABEL_INDIV"
    )

    rem This function places bridges, indiv lables, and 
    rem     groups of nested labels on separate lines 
    rem     within respect text files
    rem A group of nested labels is defined as all nested 
    rem     labels belonging to the same group, and each
    rem     group is placed on its own line in txt file.
    call ".\funcs\labels\sort\utils.bat" :item_into_file "!item!" "!status!" "!code!"

    rem This function places each nested label belonging to
    rem     the same group, on its own line.
    rem example using Group1 , Group2, etc
    rem g1_label1
    rem g1_label2
    rem g2_label1
    rem g2_label2
    rem g2_label3
    if "!code!" equ "LABEL_NESTED" (
        set "code=!code!2"
        call ".\funcs\labels\sort\utils.bat" :item_into_file "!item!" "!status!" "!code!"
    )

    

    endlocal
exit /b