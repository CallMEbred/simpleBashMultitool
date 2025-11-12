#!/bin/bash
SCRIPT_PATH="$(realpath "$0")"
# Resize terminal 
printf '\033[8;30;85t'
main(){

while true; do
clear
echo "tool test"
echo
echo "1) Calculator" 
echo "2) File Organizer"
echo "3) Run shell commands"
read -p "Choose an option: " option
case $option in
    1) option1;;
    2) option2;;
    3) option3;;
    messy) makemessy;;
    man) man;;
    e)  clear
        echo "Exiting"
        exit 0;;
    r)exec "$SCRIPT_PATH";;
    *) echo "Invalid option." 
        sleep 1
    ;;
esac
done
}
# enter to exit
ete(){
echo
echo "Press Enter to return"
read -p "" input
clear
return
}



makemessy(){
    clear
    echo "Choose messy mode or type back to go back:"
    echo "1) Mixed file extensions"
    echo "2) Same extension, varied dates"
    read -p "Option: " mode

    TARGET="$HOME/Desktop/test_messy"
    mkdir -p "$TARGET"
    cd "$TARGET" || exit 1

    if [[ "$mode" == "1" ]]; then
        # Mixed extensions
        touch image1.jpg image2.PNG photo.gif
        touch doc1.pdf doc2.DOCX notes.txt spreadsheet.xlsx presentation.ppt
        touch archive1.zip archive2.tar.gz backup.rar
        touch song1.mp3 song2.wav track.flac
        touch video1.mp4 movie.mkv clip.AVI
        touch misc1.dat misc2.bin script.sh README.md

        for f in *; do
            echo "Dummy content for $f" > "$f"
        done

        echo "Created mixed-extension messy folder at: $TARGET"

    
    elif [[ "$mode" == "2" ]]; then
        # Same extension, varied dates — portable (no associative arrays)
        # Each line: "DATESTRING|FILENAME"
        dates_and_names=$(cat <<'EOF'
2019-01-15 09:00|2019-01-15_0900.txt
2020-02-20 10:30|2020-02-20_1030.txt
2010-03-10 12:00|2010-03-10_1200.txt
2012-04-05 14:15|2012-04-05_1415.txt
2013-05-22 08:45|2013-05-22_0845.txt
2025-06-30 16:20|2025-06-30_1620.txt
2024-07-18 11:10|2024-07-18_1110.txt
2017-08-25 19:55|2017-08-25_1955.txt
2015-09-09 07:30|2015-09-09_0730.txt 
2016-10-14 21:05|2016-10-14_2105.txt
2023-11-27 13:40|2023-11-27_1340.txt
2021-12-31 23:59|2021-12-31_2359.txt
EOF
)

        # Create files and set mtime
        while IFS='|' read -r datestr fname; do
            [[ -z "$datestr" || -z "$fname" ]] && continue
            echo "Dummy content for $fname" > "$fname"
            # Prefer touch -d; fallback to -t if -d unsupported
            if touch -d "$datestr" "$fname" 2>/dev/null; then
                :
            else
                # Convert "YYYY-MM-DD HH:MM" to "YYYYMMDDHHMM" for touch -t
                ts="${datestr//-/}"
                ts="${ts/:/}"
                ts="${ts/ /}"
                touch -t "$ts" "$fname"
            fi
        done <<< "$dates_and_names"

        echo "Created same-extension messy folder with varied timestamps at: $TARGET"
    elif [["$mode" == "back"]]; then
        clear
        return
    else
        echo "Invalid choice."
    fi

    cd
    ete
}


option1(){
while true; do
clear
echo "Calculator"
echo "Type "help" for instructions or "back" to return to menu."
echo
read -p "Calc> " input
if [[ "$input" == "back" ]]; then
    clear
    return
elif [[ "$input" == "Help" || "$input" == "help" ]]; then
    echo "Basic arithmetic: +  -  *  /"
    echo "Powers: ^"
    echo "Square root: sqrt(x)"
    echo "Sine: s(x)   (x in radians)"
    echo "Cosine: c(x)"
    echo "Arctangent: a(x)"
    echo "Natural log: l(x)"
    echo "Exponential: e(x)"
    echo
    read -p "Press Enter when ready to return..." _
    clear
    continue
fi
result=$(echo "$input" | bc -l)
echo "Result: $result"
read -p "Press Enter to continue..." _
clear
done
}
option2(){
clear
     echo "This tool will organise items in a directory into subfolders based on file types or date created."
     echo "Enter "messy" into the menu to create a messy folder on your desktop to test this tool."
     echo
    read -p "Enter directory to organize (or type 'back' to cancel): " dir
    if [[ "$dir" == "back" ]]; then
    echo "Cancelled. Returning to menu."
    ete
    return
    fi


    echo
    echo "You entered: $dir"
    read -p "Is this correct? (y/n): " confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo "Cancelled. Returning to menu."
        ete
        return
    fi
   #!/bin/bash


read -p "Sort by file type (t) or date created (d)? " input

if [[ "$input" == "d" || "$input" == "D" ]]; then
    read -p "Sort by year or month? (y/m): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        # Sort by year
        for file in "$dir"/*; do
            if [[ -f "$file" ]]; then
                year=$(stat -f "%Sm" -t "%Y" "$file")   # macOS/BSD stat
                mkdir -p "$dir/$year"
                mv "$file" "$dir/$year/"
            fi
        done

    elif [[ "$choice" == "m" || "$choice" == "M" ]]; then
        # Sort by month
        for file in "$dir"/*; do
            if [[ -f "$file" ]]; then
                month=$(stat -f "%Sm" -t "%Y-%m" "$file")   # e.g. 2025-11
                mkdir -p "$dir/$month"
                mv "$file" "$dir/$month/"
            fi
        done

    else
        echo "Invalid option. Returning to menu."
        return
    fi

elif [[ "$input" == "t" || "$input" == "T" ]]; then
    mkdir -p "$dir"/{Images,Documents,Archives,Music,Videos,Others}
    shopt -s nullglob nocaseglob
    for file in "$dir"/*; do
        if [[ -f "$file" ]]; then
            case "$file" in
                *.jpg|*.jpeg|*.png|*.gif|*.bmp) mv "$file" "$dir/Images/" ;;
                *.pdf|*.doc|*.docx|*.txt|*.xls|*.xlsx|*.ppt|*.pptx) mv "$file" "$dir/Documents/" ;;
                *.zip|*.tar|*.gz|*.rar) mv "$file" "$dir/Archives/" ;;
                *.mp3|*.wav|*.flac) mv "$file" "$dir/Music/" ;;
                *.mp4|*.mkv|*.avi|*.mov) mv "$file" "$dir/Videos/" ;;
                *) mv "$file" "$dir/Others/" ;;
            esac
        fi
    done
    shopt -u nullglob nocaseglob

else
    echo "Invalid option. Returning to menu."
    return
fi

echo
echo "Files in '$dir' have been organized."
ete
}
option3() {
    clear
    cd "$HOME"
    echo "Run default macOS shell commands. Type 'back' to go back."
    while true; do
        cwd=$(pwd)
        if [[ "$cwd" == "$HOME" ]]; then
            prompt="~ $ "
        else
            prompt="$cwd $ "
        fi
        read -p "$prompt" cmd
        [[ "$cmd" == "back" ]] && { clear; return; }
        if [[ "$cmd" =~ ^cd[[:space:]] ]]; then
            builtin $cmd
        else
            bash -c "$cmd"
        fi
    done
}





man() {
    while true; do
        clear
        echo "man page"

        echo
        read -p "Command (or type back to exit): " cmd
        if [ "$cmd" == "back" ]; then
            clear
            return
        fi
        man "$cmd"
    done
    
    
}
main
