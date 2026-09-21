
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


:run
    setlocal
    rem c, p, s
    rem P: c 
    "!nc1!" "!nc2!" "!np1!" "!np2!" "!np3!"
    "!nc1!" "!nc2!" "!ns1!" "!ns2!" "!ns3!"

    "!np1!" "!np2!" "!ns1!" "!ns2!" "!ns3!"
    "!np1!" "!np2!" "!nc1!" "!nc2!" "!nc3!"

    "!ns1!" "!ns2!" "!nc1!" "!nc2!" "!nc3!"
    "!ns1!" "!ns2!" "!np1!" "!np2!" "!np3!"

    "!ip1!" "!ip2!" "!ic1!" "!ic2!" "!ic3!"
    "!ip1!" "!ip2!" "!is1!" "!is2!" "!is3!"

    "!is1!" "!is2!" "!ip1!" "!ip2!" "!ip3!"
    "!is1!" "!is2!" "!ic1!" "!ic2!" "!ic3!"

    "!ic1!" "!ic2!" "!ip1!" "!ip2!" "!ip3!"
    "!ic1!" "!ic2!" "!is1!" "!is2!" "!is3!"
    




    "!nc1!" "!nc2!" "!ip1!" "!np2!" "!np3!"
    "!nc1!" "!nc2!" "!is1!" "!ns2!" "!ns3!"

    "!np1!" "!np2!" "!is1!" "!ns2!" "!ns3!"
    "!np1!" "!np2!" "!ic1!" "!nc2!" "!nc3!"

    "!ns1!" "!ns2!" "!ic1!" "!nc2!" "!nc3!"
    "!ns1!" "!ns2!" "!ip1!" "!np2!" "!np3!"

    "!ip1!" "!ip2!" "!nc1!" "!ic2!" "!ic3!"
    "!ip1!" "!ip2!" "!ns1!" "!is2!" "!is3!"

    "!is1!" "!is2!" "!np1!" "!ip2!" "!ip3!"
    "!is1!" "!is2!" "!nc1!" "!ic2!" "!ic3!"

    "!ic1!" "!ic2!" "!np1!" "!ip2!" "!ip3!"
    "!ic1!" "!ic2!" "!ns1!" "!is2!" "!is3!"




    "!nc1!" "!nc2!" "!np1!" "!ip2!" "!np3!"
    "!nc1!" "!nc2!" "!ns1!" "!is2!" "!ns3!"

    "!np1!" "!np2!" "!ns1!" "!is2!" "!ns3!"
    "!np1!" "!np2!" "!nc1!" "!ic2!" "!nc3!"

    "!ns1!" "!ns2!" "!nc1!" "!ic2!" "!nc3!"
    "!ns1!" "!ns2!" "!np1!" "!ip2!" "!np3!"

    "!ip1!" "!ip2!" "!ic1!" "!nc2!" "!ic3!"
    "!ip1!" "!ip2!" "!is1!" "!ns2!" "!is3!"

    "!is1!" "!is2!" "!ip1!" "!np2!" "!ip3!"
    "!is1!" "!is2!" "!ic1!" "!nc2!" "!ic3!"

    "!ic1!" "!ic2!" "!ip1!" "!np2!" "!ip3!"
    "!ic1!" "!ic2!" "!is1!" "!ns2!" "!is3!"



    "!nc1!" "!nc2!" "!np1!" "!np2!" "!ip3!"
    "!nc1!" "!nc2!" "!ns1!" "!ns2!" "!is3!"

    "!np1!" "!np2!" "!ns1!" "!ns2!" "!is3!"
    "!np1!" "!np2!" "!nc1!" "!nc2!" "!ic3!"

    "!ns1!" "!ns2!" "!nc1!" "!nc2!" "!ic3!"
    "!ns1!" "!ns2!" "!np1!" "!np2!" "!ip3!"

    "!ip1!" "!ip2!" "!ic1!" "!ic2!" "!nc3!"
    "!ip1!" "!ip2!" "!is1!" "!is2!" "!ns3!"

    "!is1!" "!is2!" "!ip1!" "!ip2!" "!np3!"
    "!is1!" "!is2!" "!ic1!" "!ic2!" "!nc3!"

    "!ic1!" "!ic2!" "!ip1!" "!ip2!" "!np3!"
    "!ic1!" "!ic2!" "!is1!" "!is2!" "!ns3!"











    "!nc1!" "" "!np1!" "!np2!" "!np3!"
    "!nc1!" "" "!ns1!" "!ns2!" "!ns3!"

    "!np1!" "" "!ns1!" "!ns2!" "!ns3!"
    "!np1!" "" "!nc1!" "!nc2!" "!nc3!"

    "!ns1!" "" "!nc1!" "!nc2!" "!nc3!"
    "!ns1!" "" "!np1!" "!np2!" "!np3!"

    "!ip1!" "" "!ic1!" "!ic2!" "!ic3!"
    "!ip1!" "" "!is1!" "!is2!" "!is3!"

    "!is1!" "" "!ip1!" "!ip2!" "!ip3!"
    "!is1!" "" "!ic1!" "!ic2!" "!ic3!"

    "!ic1!" "" "!ip1!" "!ip2!" "!ip3!"
    "!ic1!" "" "!is1!" "!is2!" "!is3!"
    




    "!nc1!" "" "!ip1!" "!np2!" "!np3!"
    "!nc1!" "" "!is1!" "!ns2!" "!ns3!"

    "!np1!" "" "!is1!" "!ns2!" "!ns3!"
    "!np1!" "" "!ic1!" "!nc2!" "!nc3!"

    "!ns1!" "" "!ic1!" "!nc2!" "!nc3!"
    "!ns1!" "" "!ip1!" "!np2!" "!np3!"

    "!ip1!" "" "!nc1!" "!ic2!" "!ic3!"
    "!ip1!" "" "!ns1!" "!is2!" "!is3!"

    "!is1!" "" "!np1!" "!ip2!" "!ip3!"
    "!is1!" "" "!nc1!" "!ic2!" "!ic3!"

    "!ic1!" "" "!np1!" "!ip2!" "!ip3!"
    "!ic1!" "" "!ns1!" "!is2!" "!is3!"




    "!nc1!" "" "!np1!" "!ip2!" "!np3!"
    "!nc1!" "" "!ns1!" "!is2!" "!ns3!"

    "!np1!" "" "!ns1!" "!is2!" "!ns3!"
    "!np1!" "" "!nc1!" "!ic2!" "!nc3!"

    "!ns1!" "" "!nc1!" "!ic2!" "!nc3!"
    "!ns1!" "" "!np1!" "!ip2!" "!np3!"

    "!ip1!" "" "!ic1!" "!nc2!" "!ic3!"
    "!ip1!" "" "!is1!" "!ns2!" "!is3!"

    "!is1!" "" "!ip1!" "!np2!" "!ip3!"
    "!is1!" "" "!ic1!" "!nc2!" "!ic3!"

    "!ic1!" "" "!ip1!" "!np2!" "!ip3!"
    "!ic1!" "" "!is1!" "!ns2!" "!is3!"



    "!nc1!" "" "!np1!" "!np2!" "!ip3!"
    "!nc1!" "" "!ns1!" "!ns2!" "!is3!"

    "!np1!" "" "!ns1!" "!ns2!" "!is3!"
    "!np1!" "" "!nc1!" "!nc2!" "!ic3!"

    "!ns1!" "" "!nc1!" "!nc2!" "!ic3!"
    "!ns1!" "" "!np1!" "!np2!" "!ip3!"

    "!ip1!" "" "!ic1!" "!ic2!" "!nc3!"
    "!ip1!" "" "!is1!" "!is2!" "!ns3!"

    "!is1!" "" "!ip1!" "!ip2!" "!np3!"
    "!is1!" "" "!ic1!" "!ic2!" "!nc3!"

    "!ic1!" "" "!ip1!" "!ip2!" "!np3!"
    "!ic1!" "" "!is1!" "!is2!" "!ns3!"


    rem P: s

    rem P: p
    endlocal
exit /b



:optns_in_bridge
    setlocal
    rem primary encapsulators
    set "enc1=%~1"
    set "enc2=%~2"

    rem opional encapsulators
    set "o1=%~3"
    set "o2=%~4"
    set "o3=%~5"

    set "e=.d88"
    set "s= "
    set "b1=BRIDGE 1"
    SET "b2=BRIDGE 2"

    set "its=!s!"
    set "itb1=!b1!"

    set "itsb1=!s!!b1!"
    set "itb1s=!b1!!s!"

    set "itb2=!b2!"
    set "itsb2=!s!!b2!"
    set "itb2s=!b2!!s!"
    
    call :inbetweens "!enc1!" "" "" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!its!" "" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itb1!" "" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itsb1!" "" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itb1s!" "" "" "" "" "" "" "!enc2!"

    call :inbetweens "!enc1!" "" "!o1!" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!its!" "!o1!" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itb1!" "!o1!" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itsb1!" "!o1!" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itb1s!" "!o1!" "" "" "" "" "" "!enc2!"
    
    call :inbetweens "!enc1!" "" "!o1!" "!its!" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "!itb1!" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "!itsb1!" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "!itb1s!" "" "" "" "" "!enc2!"

    call :inbetweens "!enc1!" "" "!o1!" "!its!" "!o2!" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "!itb1!" "!o2!" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "!itsb1!" "!o2!" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "!itb1s!" "!o2!" "" "" "" "!enc2!"


    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "" "" "" "!enc2!"
    

    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "!its!" "" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "!itb1!" "" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "!itsb1!" "" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "!itb1s!" "" "" "!enc2!"



    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "!its!" "!o3!" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "!itb1!" "!o3!" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "!itsb1!" "!o3!" "" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "!itb1s!" "!o3!" "" "!enc2!"

    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "" "!o3!" "!its!" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "" "!o3!" "!itb1!" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "" "!o3!" "!itsb1!" "!enc2!"
    call :inbetweens "!enc1!" "" "!o1!" "" "!o2!" "" "!o3!" "!itb1s!" "!enc2!"



   endlocal
exit /B

:inbetweens
    setlocal

    rem primary encapsulator
    set "enc1=%~1"
    set "it1=%~2"
    set "o1=%~3"
    set "it2=%~4"
    set "o2=%~5"
    set "it3=%~6"
    set "o3=%~7"
    set "it4=%~8"
    set "enc2=%~9"

    "!enc1!!it1!!o1!!it2!!o2!!it3!!o3!!it4!!enc2!"

    endlocal
exit /b
