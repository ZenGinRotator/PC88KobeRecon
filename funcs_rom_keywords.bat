setlocal EnableDelayedExpansion

set hep=has_encaps_pnth.txt
set hec=has_encaps_curl.txt
set hes=has_encaps_sqr.txt

set inp=is_nested_pnth.txt
set inc=is_nested_curl.txt
set ins=is_nested_sqr.txt


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

rem need d88 t88 or .cmt file extensions only -- use counter > 0 accept, equ 0 -> reject


rem determine whether file is .d88, .cmt, or .t88
:find_rom

    call :del_all
    set "name=%~1"
    set "prim_dirs=%~2"
    set "sec_dirs=%~3"
    rem set "dest_dir=%~3"
    set "ext=%~4"
    set /a ct=0

    set f=disk_ext_qty.txt
  
    call :disk_count_ "!ext!" "!f!"
  
    for /f "tokens=*" %%i in (!f!) do (
        set /a "ct=%%i"
    )
    echo  NAME "!name!" CT "!ct!" --------------------
    del "!f!"
  
    if !ct! equ 0 (
        exit /b
    )

    call :name_ "!name!" "!prim_dirs!" "!sec_dirs!"
    rem pause
    
    
exit /b


:del_all
    call :del_indiv "%hep%"
    call :del_indiv "%hec%"
    call :del_indiv "%hes%"
    call :del_indiv "%inp%"
    call :del_indiv "%inc%"
    call :del_indiv "%ins%"
exit /b

:del_indiv
    set "file=%~1"
    if exist "!file!" (
        del "!file!"
    )
exit /b

rem determine whether file and directory name has (), {}, [], or does not have encapsulator


:name_
    set "name=%~1"
    set "prim_dirs=%~2"
    set "sec_dirs=%~3"

    set prnth=
    set sqr_brkt=
    set curl_brkt=
    set rkeywd=
    for /f "tokens=3 delims=|" %%i in ("!prim_dirs!") do (
        set "prnth=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!prim_dirs!") do (
        set "sqr_brkt=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("!prim_dirs!") do (
        set "curl_brkt=%%i"
    )


    for /f "tokens=11 delims=|" %%i in ("!sec_dirs!") do (
        set "rkeywd=%%i"
    )

    

    rem use to identify whether we need to skip file or directory name when
    rem     the name has no encapsulators


    rem nested flag
    call :delim_into_file "(" ")" "!name!" "%hep%" "%inp%"
    call :delim_into_file "{" "}" "!name!" "%hec%" "%inc%"
    call :delim_into_file "[" "]" "!name!" "%hes%" "%ins%"

    set ptail=
    set ctail=
    set stail=

    for /f "tokens=*" %%i in (%hep%) do (
        set "ptail=%%i"
    )
    for /f "tokens=*" %%i in (%hec%) do (
        set "ctail=%%i"
    )
    for /f "tokens=*" %%i in (%hes%) do (
        set "stail=%%i"
    )
    rem blank = ECHO is off.
    set "blnk=ECHO is off."
    rem echo start "!name!"
    rem echo parnet "!ptail!"
    rem echo curly "!ctail!"
    rem echo square "!stail!"

    del "%hep%"
    del "%hec%"
    del "%hes%"

    set /a qty=0
    if "!ptail!" equ "!blnk!" (
        set /a qty+=1
    )
    if "!ctail!" equ "!blnk!" (
        set /a qty+=1
    )
    if "!stail!" equ "!blnk!" (
        set /a qty+=1
    )
    if !qty! equ 3 (
        rem echo NO ENCAPSULATORS
        exit /b
    )


    rem pause
    if "!ptail!" neq "!blnk!" (
        call :delim_it "!name!" "(" ")" "!prnth!\!rkeywd!"
    )

    if "!ctail!" neq "!blnk!" (
        call :delim_it "!name!" "{" "}" "!curl_brkt!\!rkeywd!"
    )

    if "!stail!" neq "!blnk!" (
        call :delim_it "!name!" "[" "]" "!sqr_brkt!\!rkeywd!"
    )

    
    rem pause
exit /b




:delim_it
rem echo DELIM NAME "!name!" "%~2" "%~3"
    set "name=%~1"
    rem 2 = left bound encapsulator
    rem 3 = right bound encapsulator

    set "dest_dir=%~4"
    rem echo DEST DIR "!dest_dir!"
    rem pause





    set nested=%inp%

    if "%~2" equ "{" (
        set nested=%inc%
    )
    if "%~2" equ "[" (
        set nested=%ins%
    )

    set is_nested=
    for /f "tokens=*" %%i in (!nested!) do (
        set "is_nested=%%i"
    )


    rem removing the appended space character after reading is_nested from file
    for /f "tokens=1 delims= " %%i in ("!is_nested!") do (
        set "is_nested=%%i"
    )
    
    del "!nested!"

    set one=
    set two=
    set three=
    set one_tail=
    set two_tail=
    set three_tail=


    rem Guaranteed to have at least 1 group of labels
    
    rem 1-A
    for /f "tokens=2 delims=%~2" %%i in ("!name!") do (
        set "one_tail=%%i"
    )
    rem 1-B
    for /f "tokens=1 delims=%~3" %%i in ("!one_tail!") do (
        set "one=%%i"
    )
    rem 1-C
    for /f "tokens=1 delims=%~2" %%i in ("!one!") do (
        set "one=%%i"
    )

    rem echo ONE "!one!"
    call :save_group "!dest_dir!" "!one!"


    rem 2-A
    for /f "tokens=3 delims=%~2" %%i in ("!name!") do (
        set "two_tail=%%i"
    )
        rem 2-B
    for /f "tokens=1 delims=%~3" %%i in ("!two_tail!") do (
        set "two=%%i"
    )

    rem echo TWO TAIL "!two_tail!"
    rem echo TWO "!two!"
    
    rem If two tail is empty, 
    rem save group 1,
    rem return

    if "!two!" equ "" (
        exit /b
    )
     
    call :save_group "!dest_dir!" "!two!"
    


    if "!is_nested!" equ "T" (
        set "name=(!name!"
    )




    rem 3-A
    for /f "tokens=4 delims=%~2" %%i in ("!name!") do (
        set "three_tail=%%i"
    )

    rem 3-B
    if "!is_nested!" equ "F" (
        set "three_tail=X)!three_tail!"
    )
    rem 3-C
    if "!is_nested!" equ "T" (
        set "three_tail=!two_tail!"
    )

    rem 3-D
    for /f "tokens=2 delims=%~3" %%i in ("!three_tail!") do (
        set "three=%%i"
    )



rem echo THREE TAIL "!three_tail!"
    rem echo THREE "!three!"
    rem If three tail is empty,
    rem     save group 2
    rem     return 

    if "!three!" equ "" (
        exit /b
    )

    call :save_group "!dest_dir!" "!three!"


    rem Might not need if collecting file names and sorting those names by 
    rem     indvidual groups 1, 2, or 3
    rem Removing unwanted spaces from blank keywords
    set "sp_three= !three!"
    set "sp_two= !two!"
    if "!sp_three!" equ " " (
        set sp_three=
    )

    if "!sp_two!" equ " " (
        set sp_two=
    )

    rem Need to fix nested?
    rem (x (y) z) outputs x  y  z and not x y z
    rem need to remove the spaces when we do the 
    rem     search through all words in x, y, and z

    rem set "c=!one!!sp_two!!sp_three!"
rem      echo is nested "!is_nested!" 
    rem echo c "%~2 %~3" "!c!"
    rem set "d=!one! !two! !three!"
    rem echo d "!d!"
    rem echo e "!one!" - "!sp_two!" - "!sp_three!"

    rem Use one two three as indicated in echo f below
    rem echo f "!one!" - "!two!" - "!three!"

    rem Call :save_group on one, two, and three,
    rem    
rem pause

exit /b

rem Delimit file or directory name with {, [, or (
rem if not delimited, skip the file or directory name
rem otherwise save group 1, 2, and possibly 3 in the directory or file name

rem ROM_KEYWORDS
REM /INDIV_GROUP
REM /All_GROUP
rem Save by individual group (list of names and categorized names containing files)
rem save by all groups combined together

rem Need to find music in name title that is non-encapsulated
:delim_into_file
    rem 1: left bound char
    rem 2: token
    rem 3: name
    set "name=%~3"
    set "has_encaps_file=%~4"
    set "is_nested_file=%~5"
    set one_tail=

    rem determine if we have an encapsulator in the name or just skip it 
    for /f "tokens=2 delims=%~1" %%i in ("!name!") do (
        rem echo "%%i"
        set "one_tail=%%i"
    )
    rem echo FIRST ONE TAIL "!one_tail!"
    echo !one_tail! > "!has_encaps_file!"
    
    
    
    rem stop this iteration
    if "!one_tail!" equ "" (
        rem echo EXITED
        exit /b
        rem goto :eof
    )
    
    rem echo !one_tail! > "!has_encaps_file!"


    if "!one_tail!" equ "!name!" (
        set one_tail=
    )


    set test=
    for /f "tokens=1 delims=%~2" %%i in ("!one_tail!") do (
        set "test=%%i"
    )

    rem echo TEST "!test!" FROM ONE TAIL "!one_tail!"

    set "is_nested=T"


    rem I think this was a remant of an original test
    rem     to identify name that has no encapsulators
    rem if "!test!" equ "" (
    rem     set "is_nested=F"
    rem )

    if "!test!" neq "!one_tail!" (
        set "is_nested=F"
    )

    
    echo !is_nested! > "!is_nested_file!"
exit /b


:disk_count_
    set "ext=%~1"
    rem set "dest_dir=%~2"
    set "file=%~2"
    set /a ct=0

    if "!ext!" equ ".d88" (
        set /a ct+=1
    )
    if "!ext!" equ ".t88" (
        set /a ct+=1
    )
    if "!ext!" equ ".cmt" (
        set /a ct+=1
    )

    echo !ct! > "!file!"
exit /b

rem determine whether file is

:save_group
    set "dest_dir=%~1"
    set "group=%~2"
    
    call "funcs_no_make.bat" :file_into_dir "!dest_dir!" "!group!"
exit /b



:target_in_group
    set "group=%~1"


    set /a qty=0
    set a1=
    set a2=
    set a3=
    set a4=
    set a5=
    set a6=
    set a7=
    set a8=
    set a9=
    set a10=

    for /f "tokens=1 delims= " %%i in ("!labels!") do (
        set "a1=%%i"
    )
    for /f "tokens=2 delims= " %%i in ("!labels!") do (
        set "a2=%%i"
    )
    for /f "tokens=3 delims= " %%i in ("!labels!") do (
        set "a3=%%i"
    )
    for /f "tokens=4 delims= " %%i in ("!labels!") do (
        set "a4=%%i"
    )
    for /f "tokens=5 delims= " %%i in ("!labels!") do (
        set "a5=%%i"
    )
    for /f "tokens=6 delims= " %%i in ("!labels!") do (
        set "a6=%%i"
    )
    for /f "tokens=7 delims= " %%i in ("!labels!") do (
        set "a7=%%i"
    )
    for /f "tokens=8 delims= " %%i in ("!labels!") do (
        set "a8=%%i"
    )
    for /f "tokens=9 delims= " %%i in ("!labels!") do (
        set "a9=%%i"
    )
    for /f "tokens=10 delims= " %%i in ("!labels!") do (
        set "a10=%%i"
    )



exit /b

















































rem we CAN DELETE ALL OF THE CODE BELOW

:curl
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"
    set "ext=%~4"
    set /a ct=0

    rem echo "!name!"
    set f=accepted_disk_ext_qty.txt
    call "funcs_no_make.bat" :file_into_dir "!dest_dir!" "!f!"
    call :disk_count "!ext!" "!dest_dir!" "!f!"


    for /f "tokens=*" %%i in (!dest_dir!\!f!) do (
        set /a "ct=%%i"
    )
  
    if !ct! equ 0 (
        rem echo ZERO
        exit /b
    )

    call :kywd "{" "}" "%~1" "!sec_dirs!" "!dest_dir!"

exit /b


:sqr
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"
    set /a ct=0

    rem echo "!name!"
    set f=accepted_disk_ext_qty.txt
    call "funcs_no_make.bat" :file_into_dir "!dest_dir!" "!f!"
    call :disk_count "!ext!" "!dest_dir!" "!f!"


    for /f "tokens=*" %%i in (!dest_dir!\!f!) do (
        set /a "ct=%%i"
    )
    del "!dest_dir!\!f!"
    rem echo ct "!ct!"
    rem pause
    rem exit /b
  
    if !ct! equ 0 (
        exit /b
    )
    call :kywd "[" "]" "%~1" "!sec_dirs!" "!dest_dir!"

exit /b

:parenths
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"

    set /a ct=0

    rem echo "!name!"
    set f=accepted_disk_ext_qty.txt
    call "funcs_no_make.bat" :file_into_dir "!dest_dir!" "!f!"
    call :disk_count "!ext!" "!dest_dir!" "!f!"


    for /f "tokens=*" %%i in (!dest_dir!\!f!) do (
        set /a "ct=%%i"
    )
    del "!dest_dir!\!f!"
    rem echo ct "!ct!"
    rem pause
    rem exit /b
  
    if !ct! equ 0 (
        exit /b
    )
    call :kywd "(" ")" "%~1" "!sec_dirs!" "!dest_dir!"

exit /b




:disk_count
    set "ext=%~1"
    set "dest_dir=%~2"
    set "file=%~3"
    set /a ct=0

    if "!ext!" equ ".d88" (
        set /a ct+=1
    )
    if "!ext!" equ ".t88" (
        set /a ct+=1
    )
    if "!ext!" equ ".cmt" (
        set /a ct+=1
    )

    echo !ct! > "!dest_dir!\!file!"
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