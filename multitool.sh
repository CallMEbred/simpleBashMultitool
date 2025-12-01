#!/bin/bash
SCRIPT_PATH="$(realpath "$0")"
clear
# Resize terminal 
printf '\033[8;30;85t'

main(){
while true; do
clear

cat << "EOF"
                  ___    __        __                   ___      
 /'\_/`\         /\_ \  /\ \__  __/\ \__               /\_ \     
/\      \  __  __\//\ \ \ \ ,_\/\_\ \ ,_\   ___     ___\//\ \    
\ \ \__\ \/\ \/\ \ \ \ \ \ \ \/\/\ \ \ \/  / __`\  / __`\\ \ \   
 \ \ \_/\ \ \ \_\ \ \_\ \_\ \ \_\ \ \ \ \_/\ \L\ \/\ \L\ \\_\ \_ 
  \ \_\\ \_\ \____/ /\____\\ \__\\ \_\ \__\ \____/\ \____//\____\
   \/_/ \/_/\/___/  \/____/ \/__/ \/_/\/__/\/___/  \/___/ \/____/                                                        
═══════════════════════════════════════════════════════════════
                    Created by Remi Heller
═══════════════════════════════════════════════════════════════
EOF

echo
echo "+-----------------------------------------------------------+"
echo "|  [1] Calculator                                           |"
echo "|  [2] File Organizer                                       |"
echo "|  [3] Run Shell Commands                                   |"
echo "|  [4] ASCII Word Art Generator                             |"
echo "|                                                           |"
echo "|  [messy] Create Messy Test Folder                         |"
echo "|  [man]   View Man Pages                                   |"
echo "|                                                           |"
echo "|  [e]     Exit                                             |"
echo "|  [r]     Restart Script                                   |"
echo "+-----------------------------------------------------------+"
echo
read -p "Select an option: " option
case $option in
    1) option1;;
    2) option2;;
    3) option3;;
    4) option4;;
    messy) makemessy;;
    man) man;;
    e)
    clear
    cat << "EOF"
+-------------------------------------------------------------+
|                         SESSION CLOSED                      |
+-------------------------------------------------------------+


EOF
    exit 0;;

    r) exec "$SCRIPT_PATH";;
    *) echo "Invalid option."
       sleep 1
    ;;
esac
done
}

# enter to exit
ete(){
echo
echo "-------------------------------------------------------------"
read -p "Press Enter to return..." _
clear
return
}


dependencies(){
# Check for figlet
if ! command -v figlet &> /dev/null; then
    echo "figlet is not installed."
    echo -n "Install figlet using Nix? [y/N]: "
    read response
    if [[ "$response" =~ ^[yY]$ ]]; then
        # Check for nix
        if ! command -v nix-env &> /dev/null; then
            echo "Nix is not installed."
            echo -n "Install Nix now? [y/N]: "
            read response
            if [[ "$response" =~ ^[yY]$ ]]; then
                # Install Nix (multi-user installer)
                sh <(curl -L https://nixos.org/nix/install) --daemon
                if ! command -v nix-env &> /dev/null; then
                    echo "Nix installation failed. Please install manually."
                    exit 1
                fi
            else
                echo "Cannot proceed without Nix. Exiting."
                exit 1
            fi
        fi

        # Install figlet via nix
        nix-env -iA nixpkgs.figlet
        if ! command -v figlet &> /dev/null; then
            echo "figlet installation failed. Please install manually."
            exit 1
        else
            echo "figlet installed successfully!"
        fi
    else
        echo "figlet is required. Exiting."
        exit 1
    fi
fi

}

makemessy(){
    clear
  clear
cat << "EOF"
+-------------------------------------------------------------+
|                   MESSY FOLDER GENERATOR                    |
+-------------------------------------------------------------+
EOF

echo
echo "Choose a mode or type 'back' to return."
echo "-------------------------------------------------------------"
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
cat << "EOF"
+-------------------------------------------------------------+
|                        CALCULATOR                           |
+-------------------------------------------------------------+
EOF

echo
echo "Type expressions to evaluate. Type 'help' for syntax or 'back' to return."
echo "-------------------------------------------------------------"
read -p "Calc> " input

if [[ "$input" == "back" ]]; then
    clear
    return
elif [[ "$input" == "help" ]]; then
    clear
    cat << "EOF"
+-------------------------------------------------------------+
|                       CALCULATOR HELP                       |
+-------------------------------------------------------------+
EOF
    echo
    echo "Supported operations:"
    echo "-------------------------------------------------------------"
    echo "• Basic arithmetic: +  -  *  /"
    echo "• Powers: ^"
    echo "• Square root: sqrt(x)"
    echo "• Trig: s(x) = sin, c(x) = cos, a(x) = arctan"
    echo "• Logarithm: l(x) = ln(x)"
    echo "• Exponential: e(x) = exp(x)"
    echo
    read -p "Press Enter to return..." _
    continue
fi

result=$(echo "$input" | bc -l)
echo "-------------------------------------------------------------"
echo "Result: $result"
read -p "Press Enter to continue..." _
done
}

option2(){
clear
  clear
cat << "EOF"
+-------------------------------------------------------------+
|                     FILE ORGANIZER                          |
+-------------------------------------------------------------+
EOF

echo
echo "Organize files by type or creation date."
echo "Type 'messy' in the main menu to generate test files."
echo "-------------------------------------------------------------"

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
option4() {
    clear
    cat << "EOF"
+-------------------------------------------------------------+
|                        ASCII WORD ART                       |
+-------------------------------------------------------------+
EOF
    echo
    echo "Type any word to generate ASCII art using figlet."
    echo "Type 'font' to change the font or 'back' to go back."
    echo "-------------------------------------------------------------"

    current_font="standard"   
    while true; do
        read -p "ASCII> " input
        if [[ "$input" == "back" ]]; then
            clear
            return
        elif [[ "$input" == "font" ]]; then
            echo "Available fonts:"
            figlist
            read -p "Enter font name: " fontname
            current_font="$fontname"
            echo "Font set to '$current_font'."
        elif [[ -n "$input" ]]; then
            figlet -f "$current_font" "$input"
        fi
    done
}





man() {
    while true; do
        clear
        clear
cat << "EOF"
+-------------------------------------------------------------+
|                        MAN PAGE VIEWER                      |
+-------------------------------------------------------------+
EOF

echo
echo "Type a command to view its manual. Type 'back' to return."
echo "-------------------------------------------------------------"

        read -p "Command (or type back to exit): " cmd
        if [ "$cmd" == "back" ]; then
            clear
            return
        fi
        man "$cmd"
    done
    
    
}
dependencies
main
