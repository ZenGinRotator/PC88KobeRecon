setlocal EnableDelayedExpansion 

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

set brk=^



call %*

goto :eof


:sample_file_names
    setlocal

    rem if exist soft.txt ( del soft.txt )
    call :soft_with_last_encap
    rem exit /b
    call :soft_without_last_encap
    endlocal
exit /b

:soft_with_last_encap
    setlocal

    rem primary_type, fill/empty final primary, optn_type, invert_optn_val
    rem Need spaces, bridges, no spaces


    rem Need 1 option, two options, or 3 options
    rem empty_optn_value (independent of invert_optn_val)
    rem     ex: o1 o2 o3
    rem         Inv No No
    rem         No Empty No vs. Empty No No (overwrites necessity of invert_optn_val)
    rem         but we could use overlap between inver_val and empty_val to achieve...
    call :begin "nc" "T" "np" "0"
    call :begin "nc" "T" "ns" "0"

    call :begin "np" "T" "ns" "0"
    call :begin "np" "T" "nc" "0"

    call :begin "ns" "T" "nc" "0"
    call :begin "ns" "T" "np" "0"

    call :begin "ip" "T" "ic" "0"
    call :begin "ip" "T" "is" "0"

    call :begin "is" "T" "ip" "0"
    call :begin "is" "T" "ic" "0"

    call :begin "ic" "T" "ip" "0"
    call :begin "ic" "T" "is" "0"

ECHO ---



    call :begin "nc" "T" "np" "1"
    call :begin "nc" "T" "ns" "1"

    call :begin "np" "T" "ns" "1"
    call :begin "np" "T" "nc" "1"

    call :begin "ns" "T" "nc" "1"
    call :begin "ns" "T" "np" "1"

    call :begin "ip" "T" "ic" "1"
    call :begin "ip" "T" "is" "1"

    call :begin "is" "T" "ip" "1"
    call :begin "is" "T" "ic" "1"

    call :begin "ic" "T" "ip" "1"
    call :begin "ic" "T" "is" "1"
rem exit /b

ECHO ---

    call :begin "nc" "T" "np" "2"
    call :begin "nc" "T" "ns" "2"
    
    call :begin "np" "T" "ns" "2"
    call :begin "np" "T" "nc" "2"
    
    call :begin "ns" "T" "nc" "2"
    call :begin "ns" "T" "np" "2"

    call :begin "ip" "T" "ic" "2"
    call :begin "ip" "T" "is" "2"

    call :begin "is" "T" "ip" "2"
    call :begin "is" "T" "ic" "2"
    
    call :begin "ic" "T" "ip" "2"
    call :begin "ic" "T" "is" "2"


    ECHO ---

    call :begin "nc" "T" "np" "3"
    call :begin "nc" "T" "ns" "3"


    call :begin "np" "T" "ns" "3"
    call :begin "np" "T" "nc" "3"
    
    call :begin "ns" "T" "nc" "3"
    call :begin "ns" "T" "np" "3"

    call :begin "ip" "T" "ic" "3"
    call :begin "ip" "T" "is" "3"

    call :begin "is" "T" "ip" "3"
    call :begin "is" "T" "ic" "3"
    
    call :begin "ic" "T" "ip" "3"
    call :begin "ic" "T" "is" "3"
    ECHO ---
    endlocal
exit /b





:soft_without_last_encap
    setlocal

    call :begin "nc" "" "np" "0"
    call :begin "nc" "" "ns" "0"

    call :begin "np" "" "ns" "0"
    call :begin "np" "" "nc" "0"

    call :begin "ns" "" "nc" "0"
    call :begin "ns" "" "np" "0"

    call :begin "ip" "" "ic" "0"
    call :begin "ip" "" "is" "0"

    call :begin "is" "" "ip" "0"
    call :begin "is" "" "ic" "0"

    call :begin "ic" "" "ip" "0"
    call :begin "ic" "" "is" "0"

ECHO ---



    call :begin "nc" "" "np" "1"
    call :begin "nc" "" "ns" "1"

    call :begin "np" "" "ns" "1"
    call :begin "np" "" "nc" "1"

    call :begin "ns" "" "nc" "1"
    call :begin "ns" "" "np" "1"

    call :begin "ip" "" "ic" "1"
    call :begin "ip" "" "is" "1"

    call :begin "is" "" "ip" "1"
    call :begin "is" "" "ic" "1"

    call :begin "ic" "" "ip" "1"
    call :begin "ic" "" "is" "1"

ECHO ---


    call :begin "nc" "" "np" "2"
    call :begin "nc" "" "ns" "2"
    
    call :begin "np" "" "ns" "2"
    call :begin "np" "" "nc" "2"
    
    call :begin "ns" "" "nc" "2"
    call :begin "ns" "" "np" "2"

    call :begin "ip" "" "ic" "2"
    call :begin "ip" "" "is" "2"

    call :begin "is" "" "ip" "2"
    call :begin "is" "" "ic" "2"
    
    call :begin "ic" "" "ip" "2"
    call :begin "ic" "" "is" "2"

    ECHO ---

    
    call :begin "nc" "" "np" "3"
    call :begin "nc" "" "ns" "3"
    
    call :begin "np" "" "ns" "3"
    call :begin "np" "" "nc" "3"
    
    call :begin "ns" "" "nc" "3"
    call :begin "ns" "" "np" "3"

    call :begin "ip" "" "ic" "3"
    call :begin "ip" "" "is" "3"

    call :begin "is" "" "ip" "3"
    call :begin "is" "" "ic" "3"
    
    call :begin "ic" "" "ip" "3"
    call :begin "ic" "" "is" "3"
    endlocal
exit /b





:begin
    setlocal
    
    rem flags:
    rem     primary encapsulators (aty=2)
    rem         nested or indiv
    rem     optional encapsulators (qty=3)
    rem         nested or indiv
    rem     primary encapsulator # 2 -- filled or empty

    rem "nc"

    rem  "0-p2(filled)/1-p2(empty)" 
    
    rem "np/ns"
    
    rem "0-same optional encap (all n or all i)
    rem 1-change nth optioanl encap to its opposite
    rem if n -> i"
    rem if i -> n""

    set "ptype=%~1"
    set "pfill=%~2"
    set "otype=%~3"

    rem numerical value
    set "o_invert=%~4"



    rem block if n is in primary and n is in options
    if "!ptype!" equ "!otype!" (
        echo SAME PRIME AND SAME OPTION
        pause
        exit /b
    )


    set "prime1=!nc1!"
    set "prime2=!nc2!"

    rem nc np ns ic ip is

    if "!ptype!" equ "np" (
        set "prime1=!np1!"
        set "prime2=!np2!"
    )

    if "!ptype!" equ "ns" (
        set "prime1=!ns1!"
        set "prime2=!ns2!"

    )
    if "!ptype!" equ "ip" (
        set "prime1=!ip1!"
        set "prime2=!ip2!"
        
    )
    if "!ptype!" equ "ic" (
        set "prime1=!ic1!"
        set "prime2=!ic2!"
        
    )
    if "!ptype!" equ "is" (
        set "prime1=!is1!"
        set "prime2=!is2!"
        
    )

    if "!pfill!" equ "" (
        set prime2=
    )

    set "o1=!nc1!"
    set "o2=!nc2!"
    set "o3=!nc3!"

    if "!otype!" equ "np" (
        set "o1=!np1!"
        set "o2=!np2!"
        set "o3=!np3!"
    )
    if "!otype!" equ "ns" (
        set "o1=!ns1!"
        set "o2=!ns2!"
        set "o3=!ns3!"
    )
    if "!otype!" equ "ic" (
        set "o1=!ic1!"
        set "o2=!ic2!"
        set "o3=!ic3!"
    )
    if "!otype!" equ "ip" (
        set "o1=!ip1!"
        set "o2=!ip2!"
        set "o3=!ip3!"
    )
    if "!otype!" equ "is" (
        set "o1=!is1!"
        set "o2=!is2!"
        set "o3=!is3!"
    )

    rem invert n -> i or i -> n but always retain c, s, p
    if "!o_invert!" equ "1" (
    
        call :invert_o "!o1!"
        for /f "tokens=1 delims=|" %%i in (inverted.txt) do (
            set "o1=%%i"
        )
    ) 

    if "!o_invert!" equ "2" (
    
        call :invert_o "!o2!"
        for /f "tokens=1 delims=|" %%i in (inverted.txt) do (
            set "o2=%%i"
        )


    ) 

    if "!o_invert!" equ "3" (
    
        call :invert_o "!o3!"
        for /f "tokens=1 delims=|" %%i in (inverted.txt) do (
            set "o3=%%i"
        )
    ) 

    rem affix the space or bridge to 1 or more options
    rem Layout of sample file name, where B = "BRIDGE 1"
    rem enc1 BS (0) o BS (1) o BS (2) o BS (3) enc
    

    rem BS can be: b only, s only, bs, or sb
    rem b only (3):
    rem s only (5):
    rem bs (7):
    rem sb (11):

    rem         BS
    rem     0   1   2   3
    rem position
    rem 0
    rem 1
    rem 2
    rem 3

    rem Use 
    rem x.0: no BS
    rem x.1: b
    rem x.2: s
    rem x.3: bs
    rem x.4: sb

    rem position 0
    rem 0.0, 0.1, 0.2, 0.3, 0.4

    rem position 1
    rem 1.0, 1.1, 1.2, 1.3, 1.4

    rem position 2
    rem 2.0, 2.1, 2.2, 2.3, 2.4

    rem position 3
    rem 3.0, 3.1, 3.2, 3.3, 3.4


    rem appearance value of option permutation
    rem show 0 (show 0.0, 0.1, 0.2, 0.3 as a permutation in the file name), disregard 1, 2, 3 (without BS, eg enc)
    rem show 1, disregard 0, 2, 3
    rem show 2, disregard 0, 1, 3
    rem show 3, disregard 0, 1, 2

    rem show 0, 1, disregard 2, 3
    rem show 0, 2
    rem show 0, 3
    rem show 1, 2,
    rem show 2, 3


    rem show 0, 1, 2, disregard 3
    rem show 1, 2, 3,
    rem show 2, 3, 0,
    rem show 3, 0, 1

    rem show 0, 1, 2, 3



    rem prime numbers: 1, 3, 5, 7, 11, 13, 17, 19, 23
    rem 3 + 5 = 8
    rem 3 + 7 = 10
    rem 3 + 11 = 14
    rem 5 + 7 = 12
    rem 5 + 11 = 16
    rem 7 + 11 = 18

    rem "encap1" "encap2" "optn1 "optn2" "optn3" "to_directory_indicator"
    rem set "primes=!prime!|!prime2!"
    rem set "optns=!o1!|!o2!|!o3!"
    rem no BS
    call :write "!prime1!" "!prime2!" "!o1!" "!o2!" "!o3!" "T"


    call :change_o  "1" "!prime1!" "!prime2!" "!o1!" "!o2!" "!o3!" "T"
    call :change_o  "2" "!prime1!" "!prime2!" "!o1!" "!o2!" "!o3!" "T"
    call :change_o  "3" "!prime1!" "!prime2!" "!o1!" "!o2!" "!o3!" "T"
    call :change_o  "4" "!prime1!" "!prime2!" "!o1!" "!o2!" "!o3!" "T"
  
    endlocal
exit /b



:change_o
    setlocal
    rem set "o=%~1"
    set "positn=%~1"
    set "enc1=%~2"
    set "enc2=%~3"
    set "o1=%~4"
    set "o2=%~5"
    set "o3=%~6"
    set "dir_f=%~7"
    set "b=BRIDGE 1"
    set "s= "

    set "targ_o=!o1!"
    if "!positn!" equ "2" (
        set "targ_o=!o2!"
    )
    if "!positn!" equ "3" (
        set "targ_o=!o3!"
    )

    if "!positn!" equ "4" (
        set "targ_o=!o3!"
    )

    set "bo=!b!!targ_o!"
    set "so=!s!!targ_o!"
    set "bso=!b!!s!!targ_o!"
    set "sbo=!s!!b!!targ_o!"

    if "!positn!" equ "4" (
        set "bo=!targ_o!!b!"
        set "so=!targ_o!!s!"
        set "bso=!targ_o!!b!!s!"
        set "sbo=!targ_o!!s!!b!"
    )

rem call :write "!prime1!" "!prime2!" "!o1!" "!o2!" "!o3!" "T"
    if "!positn!" equ "1" (
        call :write "!prime1!" "!prime2!" "!bo!" "!o2!" "!o3!" "!dir_f!"
        call :write "!prime1!" "!prime2!" "!so!" "!o2!" "!o3!" "!dir_f!"        
        call :write "!prime1!" "!prime2!" "!bso!" "!o2!" "!o3!" "!dir_f!"
        call :write "!prime1!" "!prime2!" "!sbo!" "!o2!" "!o3!" "!dir_f!"        
    )
    if "!positn!" equ "2" (
        call :write "!prime1!" "!prime2!" "!o1!" "!bo!" "!o3!" "!dir_f!"
        call :write "!prime1!" "!prime2!" "!o1!" "!so!" "!o3!" "!dir_f!"        
        call :write "!prime1!" "!prime2!" "!o1!" "!bso!" "!o3!" "!dir_f!"        
        call :write "!prime1!" "!prime2!" "!o1!" "!sbo!" "!o3!" "!dir_f!"        
    )
    if "!positn!" equ "3" (
        call :write "!prime1!" "!prime2!" "!o1!" "!o2!" "!bo!" "!dir_f!"
        call :write "!prime1!" "!prime2!" "!o1!" "!o2!" "!so!" "!dir_f!"
        call :write "!prime1!" "!prime2!" "!o1!" "!o2!" "!bso!" "!dir_f!"
        call :write "!prime1!" "!prime2!" "!o1!" "!o2!" "!sbo!" "!dir_f!"
    )
    if "!positn!" equ "4" (
        call :write "!prime1!" "!prime2!" "!o1!" "!o2!" "!bo!" "!dir_f!"
        call :write "!prime1!" "!prime2!" "!o1!" "!o2!" "!so!" "!dir_f!"
        call :write "!prime1!" "!prime2!" "!o1!" "!o2!" "!bso!" "!dir_f!"
        call :write "!prime1!" "!prime2!" "!o1!" "!o2!" "!sbo!" "!dir_f!"

    )



    endlocal
exit /b




:hard_vs_soft
    setlocal
   
   
    set r=
    set /a qh=0

    for %%i in ("hard\*") do (
        set /a qh+=1
        set "r=%%i"
        set itm=
        for /f "tokens=2 delims=\" %%i in ("!r!") do (
            set "itm=%%i"
                
        )

        if exist "soft\!itm!" (
            rem del "soft\!itm!"
            rem del "hard\!itm!"
            
        )
        
    )
    set /a s=0
    set /a h=0
    for /d %%i in ("soft\*") do (
        set /a s=!s!+1
    )
    for /d %%i in ("hard\*") do (
        set /a h=!h!+1
    )


    if "!h!" equ "0" (
       rd "hard\"
    )
    if "!s!" equ "0" (
       rd "soft\"
    )
   
    endlocal
exit /b

:hard_code
    setlocal
    if exist hard.txt ( del hard.txt )

  
    call :hard_with_last_encap
    rem EXIT /B

    call :hard_without_last_encap
    endlocal
exit /b








:hard_with_last_encap
    setlocal

    call :write "!nc1!" "!nc2!" "!np1!" "!np2!" "!np3!" ""
  call :write "!nc1!" "!nc2!" "!ns1!" "!ns2!" "!ns3!" ""

  call :write "!np1!" "!np2!" "!ns1!" "!ns2!" "!ns3!" ""
  call :write   "!np1!" "!np2!" "!nc1!" "!nc2!" "!nc3!" ""

   call :write  "!ns1!" "!ns2!" "!nc1!" "!nc2!" "!nc3!" ""
   call :write  "!ns1!" "!ns2!" "!np1!" "!np2!" "!np3!" ""

   call :write  "!ip1!" "!ip2!" "!ic1!" "!ic2!" "!ic3!" ""
   call :write  "!ip1!" "!ip2!" "!is1!" "!is2!" "!is3!" ""

  call :write   "!is1!" "!is2!" "!ip1!" "!ip2!" "!ip3!" ""
   call :write  "!is1!" "!is2!" "!ic1!" "!ic2!" "!ic3!" ""

   call :write  "!ic1!" "!ic2!" "!ip1!" "!ip2!" "!ip3!" ""
   call :write  "!ic1!" "!ic2!" "!is1!" "!is2!" "!is3!" ""
   




  call :write   "!nc1!" "!nc2!" "!ip1!" "!np2!" "!np3!" ""
  call :write   "!nc1!" "!nc2!" "!is1!" "!ns2!" "!ns3!" ""

  call :write   "!np1!" "!np2!" "!is1!" "!ns2!" "!ns3!" ""
   call :write  "!np1!" "!np2!" "!ic1!" "!nc2!" "!nc3!" ""

  call :write   "!ns1!" "!ns2!" "!ic1!" "!nc2!" "!nc3!" ""
  call :write   "!ns1!" "!ns2!" "!ip1!" "!np2!" "!np3!" ""

   call :write  "!ip1!" "!ip2!" "!nc1!" "!ic2!" "!ic3!" ""
   call :write  "!ip1!" "!ip2!" "!ns1!" "!is2!" "!is3!" ""

  call :write   "!is1!" "!is2!" "!np1!" "!ip2!" "!ip3!" ""
  call :write   "!is1!" "!is2!" "!nc1!" "!ic2!" "!ic3!" ""

   call :write  "!ic1!" "!ic2!" "!np1!" "!ip2!" "!ip3!" ""
   call :write  "!ic1!" "!ic2!" "!ns1!" "!is2!" "!is3!" ""






   call :write  "!nc1!" "!nc2!" "!np1!" "!ip2!" "!np3!" ""
   call :write  "!nc1!" "!nc2!" "!ns1!" "!is2!" "!ns3!" ""

   call :write  "!np1!" "!np2!" "!ns1!" "!is2!" "!ns3!" ""
   call :write  "!np1!" "!np2!" "!nc1!" "!ic2!" "!nc3!" ""

   call :write  "!ns1!" "!ns2!" "!nc1!" "!ic2!" "!nc3!" ""
   call :write  "!ns1!" "!ns2!" "!np1!" "!ip2!" "!np3!" ""

  call :write   "!ip1!" "!ip2!" "!ic1!" "!nc2!" "!ic3!" ""
  call :write   "!ip1!" "!ip2!" "!is1!" "!ns2!" "!is3!" ""

  call :write   "!is1!" "!is2!" "!ip1!" "!np2!" "!ip3!" ""
  call :write   "!is1!" "!is2!" "!ic1!" "!nc2!" "!ic3!" ""

   call :write  "!ic1!" "!ic2!" "!ip1!" "!np2!" "!ip3!" ""
   call :write  "!ic1!" "!ic2!" "!is1!" "!ns2!" "!is3!" ""







REM 37
   call :write  "!nc1!" "!nc2!" "!np1!" "!np2!" "!ip3!" ""
   call :write  "!nc1!" "!nc2!" "!ns1!" "!ns2!" "!is3!" ""

   call :write  "!np1!" "!np2!" "!ns1!" "!ns2!" "!is3!" ""
  call :write "!np1!" "!np2!" "!nc1!" "!nc2!" "!ic3!" ""

   call :write  "!ns1!" "!ns2!" "!nc1!" "!nc2!" "!ic3!" ""
   call :write  "!ns1!" "!ns2!" "!np1!" "!np2!" "!ip3!" ""

   call :write  "!ip1!" "!ip2!" "!ic1!" "!ic2!" "!nc3!" ""
   call :write  "!ip1!" "!ip2!" "!is1!" "!is2!" "!ns3!" ""

   call :write  "!is1!" "!is2!" "!ip1!" "!ip2!" "!np3!" ""
   call :write  "!is1!" "!is2!" "!ic1!" "!ic2!" "!nc3!" ""

   call :write  "!ic1!" "!ic2!" "!ip1!" "!ip2!" "!np3!" ""
   call :write  "!ic1!" "!ic2!" "!is1!" "!is2!" "!ns3!" ""
    endlocal
exit /b





:hard_without_last_encap
    setlocal

   call :write  "!nc1!" "" "!np1!" "!np2!" "!np3!" ""
   call :write  "!nc1!" "" "!ns1!" "!ns2!" "!ns3!" ""

   call :write  "!np1!" "" "!ns1!" "!ns2!" "!ns3!" ""
   call :write  "!np1!" "" "!nc1!" "!nc2!" "!nc3!" ""

   call :write  "!ns1!" "" "!nc1!" "!nc2!" "!nc3!" ""
  call :write   "!ns1!" "" "!np1!" "!np2!" "!np3!" ""

  call :write   "!ip1!" "" "!ic1!" "!ic2!" "!ic3!" ""
  call :write   "!ip1!" "" "!is1!" "!is2!" "!is3!" ""

  call :write   "!is1!" "" "!ip1!" "!ip2!" "!ip3!" ""
  call :write   "!is1!" "" "!ic1!" "!ic2!" "!ic3!" ""

  call :write   "!ic1!" "" "!ip1!" "!ip2!" "!ip3!" ""
  call :write   "!ic1!" "" "!is1!" "!is2!" "!is3!" ""
    







   call :write  "!nc1!" "" "!ip1!" "!np2!" "!np3!" ""
   call :write  "!nc1!" "" "!is1!" "!ns2!" "!ns3!" ""

   call :write  "!np1!" "" "!is1!" "!ns2!" "!ns3!" ""
   call :write  "!np1!" "" "!ic1!" "!nc2!" "!nc3!" ""

   call :write  "!ns1!" "" "!ic1!" "!nc2!" "!nc3!" ""
   call :write  "!ns1!" "" "!ip1!" "!np2!" "!np3!" ""

   call :write  "!ip1!" "" "!nc1!" "!ic2!" "!ic3!" ""
call :write     "!ip1!" "" "!ns1!" "!is2!" "!is3!" ""

call :write     "!is1!" "" "!np1!" "!ip2!" "!ip3!" ""
call :write     "!is1!" "" "!nc1!" "!ic2!" "!ic3!" ""

  call :write   "!ic1!" "" "!np1!" "!ip2!" "!ip3!" ""
  call :write   "!ic1!" "" "!ns1!" "!is2!" "!is3!" ""




   call :write  "!nc1!" "" "!np1!" "!ip2!" "!np3!" ""
    call :write "!nc1!" "" "!ns1!" "!is2!" "!ns3!" ""

    call :write "!np1!" "" "!ns1!" "!is2!" "!ns3!" ""
   call :write  "!np1!" "" "!nc1!" "!ic2!" "!nc3!" ""

   call :write  "!ns1!" "" "!nc1!" "!ic2!" "!nc3!" ""
   call :write  "!ns1!" "" "!np1!" "!ip2!" "!np3!" ""

    call :write "!ip1!" "" "!ic1!" "!nc2!" "!ic3!" ""
    call :write "!ip1!" "" "!is1!" "!ns2!" "!is3!" ""

    call :write "!is1!" "" "!ip1!" "!np2!" "!ip3!" ""
    call :write "!is1!" "" "!ic1!" "!nc2!" "!ic3!" ""

    call :write "!ic1!" "" "!ip1!" "!np2!" "!ip3!" ""
    call :write "!ic1!" "" "!is1!" "!ns2!" "!is3!" ""



    call :write "!nc1!" "" "!np1!" "!np2!" "!ip3!" ""
    call :write "!nc1!" "" "!ns1!" "!ns2!" "!is3!" ""

    call :write "!np1!" "" "!ns1!" "!ns2!" "!is3!" ""
    call :write "!np1!" "" "!nc1!" "!nc2!" "!ic3!" ""

    call :write "!ns1!" "" "!nc1!" "!nc2!" "!ic3!" ""
    call :write "!ns1!" "" "!np1!" "!np2!" "!ip3!" ""

    call :write "!ip1!" "" "!ic1!" "!ic2!" "!nc3!" ""
    call :write "!ip1!" "" "!is1!" "!is2!" "!ns3!" ""

    call :write "!is1!" "" "!ip1!" "!ip2!" "!np3!" ""
    call :write "!is1!" "" "!ic1!" "!ic2!" "!nc3!" ""

    call :write "!ic1!" "" "!ip1!" "!ip2!" "!np3!" ""
    call :write "!ic1!" "" "!is1!" "!is2!" "!ns3!" ""
    endlocal
exit /b





:write
    setlocal
    rem primary encapsulators
    set "a=%~1"
    set "b=%~2"

    rem optional encapsulators
    set "c=%~3"
    set "d=%~4"
    set "e=%~5"

    rem directory destination for created files
    set "f=%~6"

    rem Currently unused.
    set "it1=%~7"
    set "it2=%~8"
    set "it3=%~9"
    
    set "t=!a!!c!!d!!e!!b!"

    rem echo T "!t!"


    set "dir=hard"
    if "!f!" equ "T" (
        set "dir=SAMPLE_FILE_NAMES"
    )


    if not exist "!dir!" (
        md "!dir!
    )
  

    echo !t! > "!dir!\!t!"
    endlocal
exit /b

:invert_o
    setlocal
    set "o=%~1"
    if "!o!" equ "!ns1!" (
        set "o=!is1!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b
    )
    if "!o!" equ "!ns2!" (
        set "o=!is2!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )
    if "!o!" equ "!ns3!" (
        set "o=!is3!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )

    if "!o!" equ "!is1!" (
        set "o=!ns1!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )
    if "!o!" equ "!is2!" (
        set "o=!ns2!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )
    if "!o!" equ "!is3!" (
        set "o=!ns3!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )


    if "!o!" equ "!nc1!" (
        set "o=!ic1!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )
    if "!o!" equ "!nc2!" (
        set "o=!ic2!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )
    if "!o!" equ "!nc3!" (
        set "o=!ic3!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )

    if "!o!" equ "!ic1!" (
        set "o=!nc1!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )
    if "!o!" equ "!ic2!" (
        set "o=!nc2!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )
    if "!o!" equ "!ic3!" (
        set "o=!nc3!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )


    if "!o!" equ "!np1!" (
        set "o=!ip1!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )
    if "!o!" equ "!np2!" (
        set "o=!ip2!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )

    if "!o!" equ "!np3!" (
        set "o=!ip3!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )

    if "!o!" equ "!ip1!" (
        set "o=!np1!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )
    if "!o!" equ "!ip2!" (
        set "o=!np2!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )
    if "!o!" equ "!ip3!" (
        set "o=!np3!"
        set "o=!o!|"
        echo !o! > "inverted.txt"
        exit /b

    )
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
    
    rem appearance value 0
    call :inbetweens "!enc1!" "" "" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!its!" "" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itb1!" "" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itsb1!" "" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itb1s!" "" "" "" "" "" "" "!enc2!"

    rem appearance value 0.1
    call :inbetweens "!enc1!" "" "!o1!" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!its!" "!o1!" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itb1!" "!o1!" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itsb1!" "!o1!" "" "" "" "" "" "!enc2!"
    call :inbetweens "!enc1!" "!itb1s!" "!o1!" "" "" "" "" "" "!enc2!"
    

    rem appearance value 
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
