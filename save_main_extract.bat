setlocal EnableDelayedExpansion


@ set "src=APPLIED_ORIG"
@ set "src=..\..\ARCHV_DIRTY"


for /d %%i in ("%src%\*") do (

	for %%j in ("%%i\*") do (
		@ call "..\1 CleanIt\funcs.bat" :overwrite_extract "%%j" "%%i"
	)
)

echo END OF main_extract.bat
pause