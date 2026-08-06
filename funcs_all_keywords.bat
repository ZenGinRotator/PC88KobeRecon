setlocal EnableDelayedExpansion

call %*

goto :eof

rem The directory or file name may have 0, 1, 2, or 3 encapsulated groups of words.
rem Need to gather directory or file names by keywords encapsulated wthinin each group,
rem     and not collected by a category specified by the combination of all encapsulated 
rem     words from all groups within the directory or file name.

rem For each directory or file name
rem 1. determine if it has a nested or non-nested encapsulator and write status to file
rem 2. read its nested/non-nested state from file
rem 3. extract keywords from Groups 1, 2, 3, using the non-nested status of the 
rem     directory or file name
rem 4. sort directory or file names by Groups 1, 2, 3, or none (when there are no groups in the name)

:curl
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"
    call :kywd "{" "}" "%~1" "!sec_dirs!" "!dest_dir!"

exit /b

:sqr
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"
    call :kywd "[" "]" "%~1" "!sec_dirs!" "!dest_dir!"

exit /b

:parenths
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"
    call :kywd "(" ")" "%~1" "!sec_dirs!" "!dest_dir!"

exit /b

:kywd
    set "name=%~3"
    set "sec_dirs=%~4"
    set "dest_dir=%~5"

    rem Definitions:
    rem left bound delimiter: eg. "(", "[", or "{"
    rem right bound delimiter: eg ")" "]", or "}"
    
    rem Variables to store any groups of encapsulated words
    rem     found in the directory or file name
    set one=
    set two=

    rem Using a "left bound" delimiting character (eg. "(", "[", or "{")
    rem     to find the first group of
    rem     encapsulated words in the directory or file name,
    rem     along with any other words that appear after that group
    rem     of encapsulated words.
    rem "This is a file name (with label L).txt" -> "with label L).txt" 
    for /f "tokens=2 delims=%~1" %%i in ("!name!") do (
        set "one=%%i"
    )


    rem To account for directory or file names that do not contain
    rem     any encapsulated words within the title.
    rem We receive the entire directory or file name when no
    rem     encapsulated words are found when using the 
    rem     delimiting character to partion the directory or file
    rem     name.
    rem If we receive an exact copy of the origina file namme, delete
    rem     that copy from memory.
    rem "This is a file name without a label L.txt" -> "This is a file name without a label L.txt" -> ""
    if "!one!" equ "%~3" (
        set one=
    )

    rem Using a right-bound delimiting character to partition
    rem     the outcome of using the initial left-bound delimiting character
    rem     on the file name.
    rem "with label L).txt" -> "with label L"
    for /f "tokens=1 delims=%~2" %%i in ("!one!") do (
        set "two=%%i"
    )

    rem Assume the directory or file name contains a set of nested
    rem     delimiting characters.
    set "is_nested=T"

    rem To account for a directory or file name with at least 1 group 
    rem     of encapsulated words, such as:
    rem         1. "file (with a label).txt",
    rem         2. "file (with) two (labels).txt,
    rem         3. "file (with) three (different) (labels).txt")
    rem         4. "file with no lables.txt"
    rem         All do not contain any nested delimiters (encapsulated words)



    rem To account for a directory or file name with no delimiting charcters
    rem     (eg. "This is a file or directory name without lables.txt")
    rem         All do not contain any nested delimiters (encapsulated words)
    if "!two!" equ "" (
        set "is_nested=F"
    )


    rem To account for a directory or file name with at least 1 group 
    rem     of encapsulated words, such as:
    rem         1. "file (with a label).txt",
    rem         2. "file (with) two (labels).txt,
    rem         3. "file (with) three (different) (labels).txt")
    rem         All do not contain any nested delimiters (encapsulated words)

    rem "This is a file name (with label L).txt" -> "with label L).txt" -> "with label L"
    rem (eg. "with label L" is not equivalent to "with label L).txt")
    if "!two!" neq "!one!" (
        set "is_nested=F"
    )

    call :extract "%~1" "%~2" "!name!" "!sec_dirs!" "!dest_dir!" "!is_nested!"
exit /b

:extract

    set "name=%~3"
    set "sec_dirs=%~4"
    set "dest_dir=%~5"
    set "is_nested=%~6"

    echo NAME "!name!"
    

    rem A file or directory name can have 0 or up to 3
    rem     groups of encapsulated words, where each
    rem     encapsulated groups of words, can contain 1 or more words
    rem     within that encapsulated group.

    rem 3 groups of encapsulated words and combine the groups to find
    rem     the string of all encapsulated words, and use this string as 
    rem     the label associated with the directory or file name.
    set one=
    set two=
    set three=

    rem The group of encapsulated words and any other words
    rem     (labels and non-labels) that follow words in the
    rem     desired group of encapsulated words.
    set one_tail=
    set two_tail=
    set three_tail=

    rem Collecting Labels from Group 1 and possibly 
    rem     non-lables appearing before the next group of
    rem     encapsulated labels.
    for /f "tokens=2 delims=%~1" %%i in ("!name!") do (
        set "one_tail=%%i"
    )
    
 





    rem Account for a directory or file name
    rem     without encapsulated words because of the absence
    rem     of a left-bound delimiting character in the file name.
    rem We can end this function because the directory or file name
    rem     does not contain any labels.
    if "!one_tail!" equ "" (
        set one_tail=
        rem echo stop "!name!" the function here because there is no need to look for non-existent labels
        rem read the qty files
        rem delete the qty files,
        rem  and write the name, labels, and qtys in the list
        set "encaps=%~1!one!%~2 %~1!two!%~2 %~1!three!%~2"
        call :item "!one!" "!two!" "!three!" "!dest_dir!" "!name!"
        rem call :itemize "%~1" "%~2" "!name!" "!encaps!" "!g_qty_path!" "!dest_dir!" "LONG_AND_LARGE"
        exit /b
    )




rem This needs to be its own function
rem This function receives, 
rem     the intended group label (eg: 1, 2, or 3)
rem     Counts the number of delimited labels using the empty character
rem     Writes the lables for the intended group to a file
rem     Writes the number of all lables within this group to a separate file

rem After calling this function for each of the three groups,
rem     then need to use a different function to read all of these previosuly
rem     created files to create the file entry for the 
rem     filename ______ labels for all 3 groups ____ and their respective label quantities






    rem TEST TO SEE IF WE CAN EXIT THIS FUNCTION WHEN NO LABLES
    REM exist the directory and file name
    rem Then we can write the name to file as described below
    rem to shorten the scripts running time

    rem Finding the first group of labels (encapsulated words)
    rem     in the directory or file name.
    for /f "tokens=1 delims=%~2" %%i in ("!one_tail!") do (
        set "one=%%i"
    )


    rem To account if the first group of encapsulated words 
    rem     is an example of a set of nested encapsulators
    rem     (eg. "this is a file (with (a nested) label).txt")
    for /f "tokens=1 delims=%~1" %%i in ("!one!") do (
        set "one=%%i"
    )



    rem Write data for the first group only, to file
    rem call :save_word_count "%~1" "%~2" "1" "!one!" "!g_qty_path!"






    rem          Find Group 2
    for /f "tokens=3 delims=%~1" %%i in ("!name!") do (
        set "two_tail=%%i"
    )

    rem Account for circumstances where the file or directory
    rem     name only has 1 group of lables.
    rem If so, then read the label quantities for the 
    rem     first group (0 to n lables)
    rem     second group (always 0)
    rem     and the third group (always 0).
    
    rem Then terminate the function.
    if "!two_tail!" equ "" (
        rem set two_tail=
        rem STOP THE FUNCTION HERE
        set "encaps=%~1!one!%~2 %~1!two!%~2 %~1!three!%~2"
        call :item "!one!" "!two!" "!three!" "!dest_dir!" "!name!"

       
       

        rem call :itemize "%~1" "%~2" "!name!" "!encaps!" "!g_qty_path!" "!dest_dir!" "LONG_AND_LARGE"

        exit /b
    )

    for /f "tokens=1 delims=%~2" %%i in ("!two_tail!") do (
        set "two=%%i"
    )

    rem Account for a directory or file name that contains 
    rem     nested lables or non-nested lables, and change the name
    rem     so we can retrieve the third group of lables using
    rem     the same delimiting character and token value
    rem     for the intended partition of the string.
    if "!is_nested!" equ "T" (
        set "name=(!name!"
    )

    rem Saving for Group 2
    rem call :save_word_count "%~1" "%~2" "2" "!two!" "!g_qty_path!"






    
    rem                 Group 3
    for /f "tokens=4 delims=%~1" %%i in ("!name!") do (
        set "three_tail=%%i"
    )

    if "!three_tail!" equ "" (
        set "encaps=%~1!one!%~2 %~1!two!%~2 %~1!three!%~2"
        rem call :itemize "%~1" "%~2" "!name!" "!encaps!" "!g_qty_path!" "!dest_dir!" "LONG_AND_LARGE"
        call :item "!one!" "!two!" "!three!" "!dest_dir!" "!name!"


        exit /b
    )

    rem Adjust the string to account for directory or
    rem     file names with or without nested lables,
    rem     both of which are unchanged, would require using differnet
    rem     token numbers to partition three_tail with the same 
    rem     delimiting character.
    if "!is_nested!" equ "F" (
        set "three_tail=X)!three_tail!"
    )
   

    if "!is_nested!" equ "T" (
         set "three_tail=!two_tail!"
    )
    
    for /f "tokens=2 delims=%~2" %%i in ("!three_tail!") do (
        set "three=%%i"
    )


    rem call :save_word_count "%~1" "%~2" "3" "!three!" "!g_qty_path!"


    set "encaps=%~1!one!%~2 %~1!two!%~2 %~1!three!%~2"
    call :item "!one!" "!two!" "!three!" "!dest_dir!" "!name!"

    rem call :itemize "%~1" "%~2" "!name!" "!encaps!" "!g_qty_path!" "!dest_dir!" "LONG_AND_LARGE"
    rem NEED TO EXIT THE FUNCTION 

exit /b

:item
    set "one=%~1"
    set "two=%~2"
    set "three=%~3"
    set "dest_dir=%~4"
    set "name=%~5"
    call :do_ "!dest_dir!" "!one!" "!name!"
    call :do_ "!dest_dir!" "!two!" "!name!"
    call :do_ "!dest_dir!" "!three!" "!name!"
   
exit /b

:do_
    set "dest_dir=%~1"
    set "group=%~2"
    set "name=%~3"
    
    
    if "!group!" neq "" (
        call "funcs_no_make.bat" :file_into_dir "!dest_dir!\!group!" "!name!"
    )
exit /b