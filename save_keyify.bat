@ setlocal EnableDelayedExpansion

@ set "src=APPLIED_ORIG"
@ set "k_dir=KEY_DIR"
@ set "k_fil=KEY_FILE"
@ set "k_ext=KEY_EXT"

@ set "t_ext=TABLE_EXT"
@ set "t_dir=TABLE_DIR"
@ set "t_fil=TABLE_FILE"

@ set "typ=TYPES"
@ set "prnth=PARENTHESES"
@ set "brkt=BRACKETS"
@ set "exts=EXTENSIONS"
@ set "demo=DEMO"


@ set /a dqty=0
for /d %%i in ("%src%\*") do (

@ rem 	echo -- "%%~nxi"
	@ set /a dqty+=1
	

	@ set /a fqty=0
	for %%j in ("%%i\*") do (

		@ set /a fqty+=1
		
		
		@ rem change underscore _ to asterisk *????
		@ rem to account for "Good_..." in the title
@ rem		@ call :key_or_table "%k_dir%" "!dqty!_%%~nxi"
@ rem		@ call :key_or_table "%k_ext%" "!dqty!.!fqty!_%%~xj"
@ rem		@ call :key_or_table "%k_fil%" "!dqty!.!fqty!_%%~nxj"


@ rem		@ call :key_or_table "%t_dir%\!dqty!" "%%~nxi"
@ rem		@ call :key_or_table "%t_ext%\!dqty!.!fqty!" "%%~xj"
@ rem		@ call :key_or_table "%t_fil%\!dqty!.!fqty!" "%%~nxj"

		@ rem ---- reconnaisance ----
		@ rem ---- need to find types of words and include only the pertinent
		@ rem ---- (word)/[word] to help with sorting demos from roms, and etc.
@ rem		@ call :parenths "%%~xj" "%%~nxj"
@ rem		@ call :brackets "%%~xj" "%%~nxj"
@ rem		echo ---------------- PAUSED ----------------

@ rem		@ call :ext_only "%exts%" "%%~xj" "%%~nxj"
		
	)

	
)

pause 

goto :eof

:parenths
	@ call :word_only "(" ")" "%prnth%\%~1" "%~2"
exit /b

:brackets
	@ call :word_only "[" "]" "%brkt%\%~1" "%~2"
exit /b


:key_or_table
	@ md "%~1"
	echo > "%~1\%~2"
exit /b

:word_only
	@ set wrd_tail=
	@ set wrd=
	for /f "tokens=2 delims=%~1" %%i in ("%~4") do (
		@ set "wrd_tail=%%i"
	)
	for /f "tokens=1 delims=%~2" %%i in ("!wrd_tail!") do (
		@ set "wrd=%%i"
	)


	if "!wrd!" neq "" (
		@ md "%~3\!wrd!\"
		echo > "%~3\!wrd!\%~4"
	)
exit /b


:ext_only
	@ md "%~1\%~2"
	echo > "%~1\%~2\%~3"
exit /b