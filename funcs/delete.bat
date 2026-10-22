setlocal EnableDelayedExpansion

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


call %*
goto :eof


:del_txts
    setlocal
    echo call delete
    if exist labels.txt ( del labels.txt)
    if exist nested.txt ( del nested.txt )
    if exist %delimtxt% ( del %delimtxt% )
    if exist %brgtxt% ( del %brgtxt% )
    if exist "is_nested.txt" ( del "is_nested.txt" )
    if exist "is_primary_nested.txt" ( del "is_primary_nested.txt" )
    if exist "is_secondary_nested.txt" ( del "is_secondary_nested.txt" )
    if exist "bridge.txt" ( del "bridge.txt" )
    if exist "has_square.txt" ( del "has_square.txt" )
    if exist "has_curl.txt" ( del "has_curl.txt" )
    if exist "has_paren.txt" ( del "has_paren.txt" )
    if exist "last_item.txt" ( del "last_item.txt" )
    if exist "chars.txt" ( del "chars.txt" )
    if exist "token.txt" ( del "token.txt" )
    if exist nested.txt ( del nested.txt )
    if exist indivs.txt ( del indivs.txt )
    if exist bridges.txt ( del bridges.txt )
    if exist reduced_bridge.txt ( del reduced_bridge.txt )
    echo end delete
    endlocal
exit /b