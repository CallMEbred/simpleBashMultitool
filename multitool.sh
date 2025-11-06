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
echo "3) (temp) runs man command for specified command"
read -p "Choose an option: " option
case $option in
    1) option1;;
    2) option2;;
    3) option3;;
    messy) makemessy;;
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
read -p "This will create a messy folder on your desktop for testing. Continue? (y/n): " input
if [[ "$input" != "y" && "$input" != "Y" ]]; then
    echo "Cancelled. Returning to menu."
    ete
    return
fi
TARGET="$HOME/Desktop/test messy"

mkdir -p "$TARGET"
cd "$TARGET" || exit 1

touch image1.jpg image2.PNG photo.gif
touch doc1.pdf doc2.DOCX notes.txt spreadsheet.xlsx presentation.ppt
touch archive1.zip archive2.tar.gz backup.rar
touch song1.mp3 song2.wav track.flac
touch video1.mp4 movie.mkv clip.AVI
touch misc1.dat misc2.bin script.sh README.md

for f in *; do
    echo "Dummy content for $f" > "$f"
done

echo "Created test folder with messy files at: $TARGET"
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
     echo "This tool will organise items in a directory into subfolders based on file types."
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

    mkdir -p "$dir"/{Images,Documents,Archives,Music,Videos,Others}
    # Enable nullglob and nocaseglob for case-insensitive matching and to handle no matches
    shopt -s nullglob nocaseglob
    for file in "$dir"/*; do
        if [[ -f "$file" ]]; then
            case "$file" in
                *.jpg|*.jpeg|*.png|*.gif|*.bm) mv "$file" "$dir/Images/" ;;
                *.pdf|*.doc|*.docx|*.txt|*.xls|*.xlsx|*.ppt|*.pptx) mv "$file" "$dir/Documents/" ;;
                *.zip|*.tar|*.gz|*.rar) mv "$file" "$dir/Archives/" ;;
                *.mp3|*.wav|*.flac) mv "$file" "$dir/Music/" ;;
                *.mp4|*.mkv|*.avi|*.mov) mv "$file" "$dir/Videos/" ;;
                *) mv "$file" "$dir/Others/" ;;
            esac
        fi
    done
    shopt -u nullglob nocaseglob

    echo
    echo "Files in '$dir' have been organized into subfolders."
    ete
}

option3() {
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
