call %*

goto :eof


:file_into_dir
rem echo file_into_dir "%~1 %~2"
    call :no_dir_make "%~1"
    call :no_file_make "%~1\%~2"
    rem echo end of file_into_dir
exit /b

:no_file_make
    if not exist "%~1" (
        echo > "%~1"
    )
exit /b

:no_dir_make
    if not exist "%~1" (
        @ md "%~1"
    )
exit /b

