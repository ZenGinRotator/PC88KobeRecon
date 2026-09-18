call %*

goto :eof



:last_char
    setlocal
    set "s=[s]"
    set "p=(p)"
    set "c={c}"
    set "d=.d88"
    set "b=BRIDGE"

    call "funcs_rom_keywords.bat" :start "!d!"
    call :one_ext_last "!s!" "!b!" "!d!"
    call :one_ext_last "!p!" "!b!" "!d!"
    

    call :one_ext_last "!c!" "!b!" "!d!"

    call :two_ext_last "!s!" "!p!" "!b!" "!d!"
    call :two_ext_last "!s!" "!c!" "!b!" "!d!"
    
    call :two_ext_last "!p!" "!s!" "!b!" "!d!"
    
    call :two_ext_last "!p!" "!c!" "!b!" "!d!"
    
    call :two_ext_last "!c!" "!p!" "!b!" "!d!"
    
    call :two_ext_last "!c!" "!s!" "!b!" "!d!"

    
    call :three_ext_last "!s!" "!p!" "!c!" "!b!" "!d!"
    
    call :three_ext_last "!s!" "!c!" "!p!" "!b!" "!d!"


    call :three_ext_last "!p!" "!c!" "!s!" "!b!" "!d!"


    call :three_ext_last "!p!" "!s!" "!c!" "!b!" "!d!"

    call :three_ext_last "!c!" "!s!" "!p!" "!b!" "!d!"

    call :three_ext_last "!c!" "!p!" "!s!" "!b!" "!d!"
    


    endlocal
exit /b


:one_ext_last
    setlocal
    set "one=%~1"
    set "bridge=%~2"
    set "ext=%~3"
    
    call "funcs_rom_keywords.bat" :start "!one!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge!!ext!" 
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge! !ext!"
    endlocal
exit /b

:two_ext_last
    setlocal
    set "one=%~1"
    set "two=%~2"
    set "bridge=%~3"
    set "ext=%~4"
    call "funcs_rom_keywords.bat" :start "!one!!two!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !two!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!two! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !two! !ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge!!two!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge! !two!!ext!"

    call "funcs_rom_keywords.bat" :start "!one!!two!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!two! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!two!!bridge! !ext!"

    call "funcs_rom_keywords.bat" :start "!one!!bridge!!two!!bridge!!ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !bridge! !ext!"

    call "funcs_rom_keywords.bat" :start "!one!!bridge! !two!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge! !two!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge! !two! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge! !two! !bridge! !ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !ext!"
    
    
    
    
    endlocal
exit /b

:three_ext_last
    setlocal
    set "one=%~1"
    set "two=%~2"
    set "three=%~3"
    set "bridge=%~4"
    set "ext=%~5"

    call "funcs_rom_keywords.bat" :start "!one!!two!!three!!ext!"

    call "funcs_rom_keywords.bat" :start "!one! !two!!three!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !two!!three! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !two! !three!!ext!"
    
    call "funcs_rom_keywords.bat" :start "!one! !two! !three! !ext!"

    call "funcs_rom_keywords.bat" :start "!one!!two! !three!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!two!!three! !ext!"
    call "funcs_rom_keywords.bat" :start "!one!!two! !three! !ext!"
    
    call "funcs_rom_keywords.bat" :start "!one!!bridge!!two!!three!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge!!two!!three! !ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge!!two! !three!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge!!two! !three! !ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !three!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !three! !ext!"

    call "funcs_rom_keywords.bat" :start "!one!!bridge! !two!!three!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge! !two!!three! !ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge! !two! !three!!ext!"
    call "funcs_rom_keywords.bat" :start "!one!!bridge! !two! !three! !ext!"


    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!three!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!three! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !three!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !three! !ext!"

    call "funcs_rom_keywords.bat" :start "!one!!bridge!!two!!three!!bridge!!ext!"
    
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three! !bridge!!ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three! !bridge!!ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three! !bridge! !ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !three! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !three! !bridge! !ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!three! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!three! !bridge!!ext!"

    rem --
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three! !bridge!!ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three! !bridge!!ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!three! !bridge! !ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !three! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !three! !bridge! !ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!three! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two!!three! !bridge!!ext!"

    rem --
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!bridge! !three!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!bridge! !three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two!!bridge! !three! !bridge!!ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !bridge!!three!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !bridge!!three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge!!two! !bridge!!three! !bridge!!ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three!!bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three! !bridge! !ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three! !bridge! !ext!"

    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three! !bridge!!ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three!!bridge! !ext!"
    call "funcs_rom_keywords.bat" :start "!one! !bridge! !two! !bridge! !three! !bridge!!ext!"




    endlocal
exit /b