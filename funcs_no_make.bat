@ call *%

goto :eof


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