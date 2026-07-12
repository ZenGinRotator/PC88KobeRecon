@ call %*

goto :eof


:file_into_dir
    @ call :no_dir_make "%~1"
    @ call :no_file_make "%~1\%~2"
exit /b

:no_file_make
    if not exist "%~1" (
        @ rem @ md ""
        echo > "%~1"
    )
exit /b

:no_dir_make
    if not exist "%~1" (
        @ md "%~1"
    )
exit /b