setlocal EnableDelayedExpansion
call %*

goto :eof


:sqrd_qty
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"
    call :has_nested_encapsulator "[" "]" "%~1" "!sec_dirs!" "!dest_dir!"
exit /b


:parenth_word_qty
    set "name=%~1"
    set "sec_dirs=%~2"
    set "dest_dir=%~3"
    call :has_nested_encapsulator "(" ")" "%~1" "!sec_dirs!" "!dest_dir!"
    
exit /b

rem Function to determine whether the directory or file name contains
rem     any nested delimiting characters, such as
rem     Given file "f" with the delimiting characters "(" and ")",
rem         "This is a file name (with a (nested label) indicating multiple file type) for this file.txt",
rem     or does not have any nested delimiting characters, such as:
rem     Given file f_single:
rem         "This is a file name (with one label for file type).txt"
rem     Given file f_double:
rem         "This is a file name (with one) and (two) labels for its file type.txt"
rem     Given file f_triple
rem         "This is a file name with (one) and (two) and (three) labels indicating the file has 3 different types.txt"
rem     Given file f_none
rem         "This is a file name without any labels.txt"
rem     Note that files f_single, f_double, f_triple do not have any nested
rem         delimiting characters.
:has_nested_encapsulator
    rem Arguments
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


    call :encapsulated_qty "%~1" "%~2" "!name!" "!sec_dirs!" "!dest_dir!" "!is_nested!"

exit /b



rem Collect all encapsulated words within dir or file name
rem     and show the entire collection words as a string.
rem Need this function because we wish to determine if one
rem     of the collected words is "demo", "Demo", "disk",
rem     "Disk", "Music", or "music" and to categorize 
rem     those dirs or files 
rem     for EmulationStation:


:encapsulated_qty


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
    if "!one_tail!" equ "!name!" (
        set one_tail=
        echo stop the function here because there is no need to look for non-existent labels
        exit /b
    )


rem     if "!one_tail!" equ "" (
rem         echo STOPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
rem        exit /b



rem     )
    rem Use these to count the number of labels within one of
    rem     the three groups of labels.
    set /a aqty=0
    set /a bqty=0
    set /a cqty=0

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








    rem          Find Group 2
    for /f "tokens=3 delims=%~1" %%i in ("!name!") do (
        set "two_tail=%%i"
    )

    rem Account for circumstances where the previous 
    rem     delimiting character is non-existent and we
    rem     we get the entirety of one_tail when determining
    rem     two_tail, which should be deleted from memory.
    if "!two_tail!" equ "!name!" (
        set two_tail=
        rem STOP THE FUNCTION HERE
        exit /b
    )

    for /f "tokens=1 delims=%~2" %%i in ("!two_tail!") do (
        set "two=%%i"
    )

    rem Account for a directory or file name that contains 
    rem     nested lables or non-nested lables, and change the name
    rem     so we can retrieve the third group of lables using
    rem     the same delimiting character and numerical value
    rem     for associated with the partition found by the 
    rem     delimiting character.
    if "!is_nested!" equ "T" (
        set "name=(!name!"
    )

    
    rem                 Group 3
    for /f "tokens=4 delims=%~1" %%i in ("!name!") do (
        set "three_tail=%%i"
    )

    rem Adjust the string to account for directory or
    rem     file names with or without nested lables.
    if "!is_nested!" equ "F" (
        set "three_tail=X)!three_tail!"
    )
   

    if "!is_nested!" equ "T" (
         set "three_tail=!two_tail!"
    )
    
    for /f "tokens=2 delims=%~2" %%i in ("!three_tail!") do (
        set "three=%%i"
    )



    rem Th three groups of lables found in the directory or file name.
    set "encaps=(!one!)   (!two!)    (!three!)"
    set "f=!one! !two! !three!"


    rem Counting the number of encapsulators (eg. groups of lables)
    rem     in the directory or file name
    set /a qty=0

    if "!one!" neq "" (
        set /a qty+=1
    )

    if "!two!" neq "" (
        set /a qty+=1
    )
    if "!three!" neq "" (
        set /a qty+=1
    )
    
    echo "!encaps!" !qty!
    echo "!f!"
    set brk=^


    echo "!brk!"
    

    
    rem pause
    rem exit /b
    set none=
    set singl=
    set doubl=
    set tripl=

    for /f "tokens=2 delims=|" %%i in ("!sec_dirs!") do (
        set "none=%%i"
    )
    for /f "tokens=3 delims=|" %%i in ("!sec_dirs!") do (
        set "singl=%%i"
    )
    for /f "tokens=4 delims=|" %%i in ("!sec_dirs!") do (
        set "doubl=%%i"
    )
    for /f "tokens=5 delims=|" %%i in ("!sec_dirs!") do (
        set "tripl=%%i"
    )


    rem set "path=!dest_dir!\!none!"
    rem if "!qty!" equ "1" (
    rem     set "path=!dest_dir!\!singl!"
    rem )
    rem if "!qty!" equ "2" (
    rem     set "path=!dest_dir!\!doubl!"
    rem )
    rem if "!qty!" equ "3" (
    rem    set "path=!dest_dir!\!tripl!"
    rem )

    set "path=!dest_dir!"


    rem Counting the number of words withinin each of the 
    rem     "label-only" groups by delimiting each
    rem     group of encapsulated words by an empty space.
    set /a qty=0

    rem Group 1 labels
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

    rem Group 2 labels
    set b1=
    set b2=
    set b3=
    set b4=
    set b5=
    set b6=
    set b7=
    set b8=
    set b9=
    set b10=

    rem Group 3 labels
    set c1=
    set c2=
    set c3=
    set c4=
    set c5=
    set c6=
    set c7=
    set c8=
    set c9=
    set c10=

    rem Delimt each individual words in the group
    for /f "tokens=1 delims= " %%i in ("!one!") do (
        set "a1=%%i"
    )
    for /f "tokens=2 delims= " %%i in ("!one!") do (
        set "a2=%%i"
    )
    for /f "tokens=3 delims= " %%i in ("!one!") do (
        set "a3=%%i"
    )
    for /f "tokens=4 delims= " %%i in ("!one!") do (
        set "a4=%%i"
    )
    for /f "tokens=5 delims= " %%i in ("!one!") do (
        set "a5=%%i"
    )
    for /f "tokens=6 delims= " %%i in ("!one!") do (
        set "a6=%%i"
    )
    for /f "tokens=7 delims= " %%i in ("!one!") do (
        set "a7=%%i"
    )
    for /f "tokens=8 delims= " %%i in ("!one!") do (
        set "a8=%%i"
    )
    for /f "tokens=9 delims= " %%i in ("!one!") do (
        set "a9=%%i"
    )
    for /f "tokens=10 delims= " %%i in ("!one!") do (
        set "a10=%%i"
    )



    for /f "tokens=1 delims= " %%i in ("!two!") do (
        set "b1=%%i"
    )
    for /f "tokens=2 delims= " %%i in ("!two!") do (
        set "b2=%%i"        
    )
    for /f "tokens=3 delims= " %%i in ("!two!") do (
        set "b3=%%i"        
    )
    for /f "tokens=4 delims= " %%i in ("!two!") do (
        set "b4=%%i"
    )
    for /f "tokens=5 delims= " %%i in ("!two!") do (
        set "b5=%%i"
    )
    for /f "tokens=6 delims= " %%i in ("!two!") do (
        set "b6=%%i"
    )
    for /f "tokens=7 delims= " %%i in ("!two!") do (
        set "b7=%%i"
    )
    for /f "tokens=8 delims= " %%i in ("!two!") do (
        set "b8=%%i"
    )
    for /f "tokens=9 delims= " %%i in ("!two!") do (
        set "b9=%%i"
    )
    for /f "tokens=10 delims= " %%i in ("!two!") do (
        set "b10=%%i"
    )


    for /f "tokens=1 delims= " %%i in ("!three!") do (
        set "c1=%%i"
    )
    for /f "tokens=2 delims= " %%i in ("!three!") do (
        set "c2=%%i"
    )
    for /f "tokens=3 delims= " %%i in ("!three!") do (
        set "c3=%%i"
    )
    for /f "tokens=4 delims= " %%i in ("!three!") do (
        set "c4=%%i"
    )
    for /f "tokens=5 delims= " %%i in ("!three!") do (
        set "c5=%%i"
    )
    for /f "tokens=6 delims= " %%i in ("!three!") do (
        set "c6=%%i"
    )
    for /f "tokens=7 delims= " %%i in ("!three!") do (
        set "c7=%%i"
    )
    for /f "tokens=8 delims= " %%i in ("!three!") do (
        set "c8=%%i"
    )
    for /f "tokens=9 delims= " %%i in ("!three!") do (
        set "c9=%%i"
    )
    for /f "tokens=10 delims= " %%i in ("!three!") do (
        set "c10=%%i"
    )


    rem Counting the number of space-delimited labels from each group

    if "!a1!" neq "" (
        set /a qty+=1
    )
    if "!a2!" neq "" (
        set /a qty+=1
        
    )
    if "!a3!" neq "" (
        set /a qty+=1
        
    )
    if "!a4!" neq "" (
        set /a qty+=1
        
    )
    if "!a5!" neq "" (
        set /a qty+=1
        
    )
    if "!a6!" neq "" (
        set /a qty+=1
        
    )
    if "!a7!" neq "" (
        set /a qty+=1
        
    )
    if "!a8!" neq "" (
        set /a qty+=1
        
    )
    if "!a9!" neq "" (
        set /a qty+=1
        
    )
    if "!a10!" neq "" (
        set /a qty+=1
        
    )

    set /a aqty=!qty!
    set /a qty=0


    if "!b1!" neq "" (
        set /a qty+=1
        
    )
    if "!b2!" neq "" (
        set /a qty+=1
        
    )
    if "!b3!" neq "" (
        set /a qty+=1
        
    )
    if "!b4!" neq "" (
        set /a qty+=1
        
    )
    if "!b5!" neq "" (
        set /a qty+=1
        
    )
    if "!b6!" neq "" (
        set /a qty+=1
        
    )
    if "!b7!" neq "" (
        set /a qty+=1
        
    )
    if "!b8!" neq "" (
        set /a qty+=1
        
    )
    if "!b9!" neq "" (
        set /a qty+=1
        
    )
    if "!b10!" neq "" (
        set /a qty+=1
        
    )

    set /a bqty=!qty!
    set /a qty=0



    if "!c1!" neq "" (
        set /a qty+=1
        
    )
    if "!c2!" neq "" (
        set /a qty+=1
        
    )
    if "!c3!" neq "" (
        set /a qty+=1
        
    )
    if "!c4!" neq "" (
        set /a qty+=1
        
    )
    if "!c5!" neq "" (
        set /a qty+=1
        
    )
    if "!c6!" neq "" (
        set /a qty+=1
        
    )
    if "!c7!" neq "" (
        set /a qty+=1
        
    )
    if "!c8!" neq "" (
        set /a qty+=1
        
    )
    if "!c9!" neq "" (
        set /a qty+=1
        
    )
    if "!c10!" neq "" (
        set /a qty+=1
        
    )

    set /a cqty=!qty!

    rem Encapsulating the number of each words from each group
    set "qtys= %~1!aqty!%~2 %~1!bqty!%~2 %~1!cqty!%~2"

    call "funcs_no_make.bat" :file_into_dir "!path!" "!name!_________!encaps!_____!qtys!"

    rem Recording the maximum number of encapsulated lables for groups 1, 2, or 3,
    rem     and the directory or file name containing the group with that 
    rem     the maximum number of labels.
    call :largest_into_dir "1" "!path!\long" "!aqty!" "!name!"
    call :largest_into_dir "2" "!path!" "!bqty!" "!name!"
    call :largest_into_dir "3" "!path!" "!cqty!" "!name!"

    

exit /b



:largest_into_dir
    set "flag=%~1"
    set "path=%~2"
    set "qty=%~3"
    set "name=%~4"

    rem Individual files to record the maximum number of lables
    rem     for each group, among all directory or file names with that 
    rem     specific group number.
    set larg_qty_txt=first_largest_qty.txt
    set sec_larg_qty_txt=sec_largest_qty.txt
    set third_larg_qty_txt=third_largest_qty.txt

    set "tag=first"
    if "!flag!" equ "2" (
        set larg_qty_txt=sec_largest_qty.txt
        set "tag=sec"
    )
    if "!flag!" equ "3" (
        set larg_qty_txt=third_largest_qty.txt
        set "tag=third"
    )

    rem Baseline description for the file that will contain
    rem     the directory or file name having the maximum number
    rem     of lables for group G, among all directory or file names
    rem     with group G.
    set "longest_encaps_words_txt=!tag!_longest_encaps_words.txt"


    rem Create the file if it does not exist.
    if not exist !path!\!larg_qty_txt! (
        call "funcs_no_make.bat" :file_into_dir "!path!" "!larg_qty_txt!"
        echo -1 > !path!\!larg_qty_txt!
    )

    rem Read the contents of the file if the file exists.
    for /f "tokens=*" %%i in (!path!\!larg_qty_txt!) do (
        set /a file_qty=%%i
    )

   
    rem Create a new version of the file if the counted maximum number
    rem     is greater than the number read from the existing file.
    if !qty! gtr !file_qty! (
   
        call "funcs_no_make.bat" :file_into_dir "!path!" "!larg_qty_txt!"
        call "funcs_no_make.bat" :file_into_dir "!path!" "!longest_encaps_words_txt!"
        rem echo !qty! > "!dest_dir!\longest\!larg_qty_txt!"
        echo !qty! > "!path!\!larg_qty_txt!"
        echo "!name!" > "!path!\!longest_encaps_words_txt!"
        
    )
exit /b