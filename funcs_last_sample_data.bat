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