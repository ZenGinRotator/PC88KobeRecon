@ setlocal EnableDelayedExpansion

@ set "src=KEY_FILE"
@ set "demo=DEMO"
@ set "musc=MUSIC"

@ set "tmp_ky_fl=TEMP_KEY"
@ set "tmp_list_fl=TEMP_LIST"
@ set brk=^



for %%i in ("%src%\*") do (
	echo ==============================================="%%~nxi"
	echo --------- "%%~xi"

	
	@ rem We want to deliminate only d88, t88 FOR DEMOS , MUSIC
	@ rem REQUIRED: change .d88_aa8b39d7 to .d88 as part of cleaning data

	if "%%~xi" equ ".d88" (
		@ call :d88 "%%~nxi"
	)

	if "%%~xi" equ ".t88" (
		@ call :d88 "%%~nxi"
	)
	@ rem call :delim "%%~nxi"

	@ call :music_non_delim "%%~nxi"
	

)

@ rem REQUIRED: need to write contents of tmp_list_fl to the demo directory at the end of the for-loop
	@ rem : the last rom to be written after for-loop might be  a one-disk or multi-disk rom
@ rem REQUIRED: need to delete TEMP_KEY.txt and TEMP_LIST.txt at end of for-loop


echo ---- END OF sort.bat" ----
pause
goto :eof


:d88
	@ call :delim "%~1"
	@ call: music_non_delim "%~1"
exit /b



:music_non_delim
	@ rem parse key from file name
	@ set name=
	for /f "tokens=2 delims=_" %%i in ("%~1") do (
		@ set "name=%%i"
	)

	
	

	@ rem parse Music or music from name
	@ set one=
	@ set two=
	@ set thre=
	@ set four=
	@ set fiv=
	@ set six=
	@ set sevn=
	@ set eight=
	@ set nine=
	@ set ten=

	for /f "tokens=1 delims= " %%i in ("!name!") do (
		@ set "one=%%i"
	)
	for /f "tokens=2 delims= " %%i in ("!name!") do (
		@ set "two=%%i"
	) 
	for /f "tokens=3 delims= " %%i in ("!name!") do (
		@ set "thre=%%i"
	)
	for /f "tokens=4 delims= " %%i in ("!name!") do (
		@ set "four=%%i"
	)
	for /f "tokens=5 delims= " %%i in ("!name!") do (
		@ set "fiv=%%i"
	)
	for /f "tokens=6 delims= " %%i in ("!name!") do (
		@ set "six=%%i"
	)
	for /f "tokens=7 delims= " %%i in ("!name!") do (
		@ set "sevn=%%i"
	)
	for /f "tokens=8 delims= " %%i in ("!name!") do (
		@ set "eight=%%i"
	)
	
	for /f "tokens=9 delims= " %%i in ("!name!") do (
		@ set "nine=%%i"
	)
	for /f "tokens=10 delims= " %%i in ("!name!") do (
		@ set "ten=%%i"
	)

echo NAME "!name!" "!one! !two! !thre! !four! !fiv! !six! !sevn! !eight! !nine! !ten!"

	
	@ call :music_types "!one!" "!name!"
	@ call :music_types "!two!" "!name!"
	@ call :music_types "!thre!" "!name!"
	@ call :music_types "!four!" "!name!"
	@ call :music_types "!fiv!" "!name!"
	@ call :music_types "!six!" "!name!"
	@ call :music_types "!sevn!" "!name!"
	@ call :music_types "!eight!" "!name!"
	@ call :music_types "!nine!" "!name!"
	@ call :music_types "!ten!" "!name!"

exit /b



:music_types

	echo === NAME "%~2"
	for %%i in ("music" "Music") do (
		if "%~1" equ %%i (
			echo ------------------ FOUND MUSIC TYPE ------- "%~1"  "%~2"
			@ md "T"
			echo > "T\%~2"

		) else (
			echo NOT A MUSIC FILE, SAVE AS ROM- IS IT SINGLE/MULTI DISK?
		)
	)
exit /b

@ REM Use to identify (demo-like lable / music-like label)
@ rem --- NEED batch file to look for underscore in unclean data -----------
:delim
	echo --- "%~1"
	@ set key=
	@ set file=
	for /f "tokens=1 delims=_" %%i in ("%~1") do (
		@ set "key=%%i"
	)
	for /f "tokens=2 delims=_" %%i in ("%~1") do (
		@ set "file=%%i"
	)

	@ call :id_wrd "!key!" "!file!"
exit /b

:id_wrd
	@ set wrd_tail=
	@ set wrd=
	for /f "tokens=2 delims=(" %%i in ("%~2") do (
		@ set "wrd_tail=%%i"
	)
	for /f "tokens=1 delims=)" %%i in ("!wrd_tail!") do (
		@ set "wrd=%%i"
	)
	
	@ call :music "%~1" "!wrd!"
	@ call :demo "%~1" "!wrd!"
exit /b

:music
	@ rem musc
	@ set "box=Music box"
	@ set "dsk=music disk"
	@ set "gal=Music Gallery"
	@ set "mod=music mode"
	

	for %%i in ("!box!" "!dsk!" "!gal!" "!mod!") do (
		
		if "%~2" equ %%i (
			@ call :sort_ "%musc%" "%~1"
			ECHO music 
			pause
			exit /b
		)
	)
exit /b

@ rem Demos can be multidisc (eg. 1054 - Mugen Senshi Valis II)
:demo

	@ rem demo "tmp_ky_fl=TEMP_KEY" "tmp_list_fl=TEMP_LIST"
	@ set "dmo=demo"
	@ set "dsc=demo disk"
	@ set "vrsn=demo version"

	@ rem Parse directory key, and compare this key with the previous directory key
	@ rem to see if the curr key and prev key are the same or different
	@ rem if the same, then create m3u file for all disks in the list
	@ rem if the same, place the m3u file and each listed item in the same (keyed) rom directory 

	

	for %%i in ("!dmo!" "!dsc!" "!vrsn!") do (
		if "%~2" equ %%i (
			@ call :key_ "%demo%" "%~1"
			@ rem echo DEMO key "%~1"
			@ rem pause
			exit /b
		)

	)
	
	
exit /b

:key_
	@ set key=
	@ set temp_k=
	@ set list=
	for /f "tokens=1 delims=." %%i in ("%~2") do (
		@ set "key=%%i"
	)
	for /f "tokens=1 delims= " %%i in (%tmp_ky_fl%.txt) do (
		@ set "temp_k=%%i"
	)
	for /f "tokens=*" %%i in (%tmp_list_fl%.txt) do (
		@ set "list=%%i"
	)


	@ rem REVISE if-else statements
	if "!key!" equ "!temp_k!" (
		echo SAME KEY "!key!"
		
	) else (
		echo DIFF KEY, SAVE THIS KEY "!key!" "!temp_k!"
		echo !key! > "%tmp_ky_fl%.txt"
		@ rem Need to write m3u to list (future task-do when using keys to rename files/dirs)

		@ call :list_to_demo "%demo%\!temp_k!"
		@ set list=
	)
	@ set "list=!list!!brk!%~2"
	echo !list! > "%tmp_list_fl%.txt"
	pause
exit /b



:list_to_demo
	@ set /a qty=0
	@ set tmp=
	for /f "tokens=*" %%i in (%tmp_list_fl%.txt) do (
		@ set "tmp=%%i"
		@ set /a qty+=1
	)

	
	if !qty! gtr 1 (
		@ call :list_to_dir "%~1"
	) else (
		@ call :sort_ "%demo%" "!tmp!"
	)
	echo PAUSED
	pause
exit /b

:list_to_dir
	for /f "tokens=*" %%i in (%tmp_list_fl%.txt) do (
		@ call :sort_ "%~1" "%%i"
	)
exit /b


@ rem Same as :key_or_table in keyify.bat
:sort_
	@ md "%~1"
	echo > "%~1\%~2"
exit /b