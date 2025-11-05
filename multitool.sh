# === Dependency Check ===
DEPENDENCIES=(bc figlet top df uptime)

# Detect package manager
if command -v brew >/dev/null 2>&1; then
    PKG_MANAGER="brew install"
elif command -v apt-get >/dev/null 2>&1; then
    PKG_MANAGER="sudo apt-get install -y"
elif command -v yum >/dev/null 2>&1; then
    PKG_MANAGER="sudo yum install -y"
else
    echo "No supported package manager found. Please install dependencies manually."
    exit 1
fi

MISSING=()

# Collect missing dependencies
for cmd in "${DEPENDENCIES[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        MISSING+=("$cmd")
    fi
done

# If any are missing, ask user before installing
if [ ${#MISSING[@]} -gt 0 ]; then
    echo "The following dependencies are missing: ${MISSING[*]}"
    read -p "Do you want to install them now? (y/n): " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        for pkg in "${MISSING[@]}"; do
            echo "Installing $pkg..."
            $PKG_MANAGER "$pkg"
        done
    else
        clear
        echo "Exiting script due to missing dependencies."
        exit 0
    fi
fi


echo "Checking dependencies..."
for cmd in "${DEPENDENCIES[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Missing: $cmd — installing..."
        $PKG_MANAGER "$cmd"
    else
        echo "Found: $cmd"
    fi
done
# Ensure figlet and extra fonts are installed together
if ! command -v figlet >/dev/null 2>&1; then
    echo "Installing figlet and fonts..."
    $PKG_MANAGER figlet figlet-fonts
fi

echo "All dependencies satisfied."
sleep 1

# Resize terminal (works in most Linux terminals)
printf '\033[8;30;80t'  # 30 rows, 80 columns

pause() {
    echo
    read -p "Press Enter to return to the menu..."
}

# Default banner text
BANNER_TEXT="MULTITOOL"
BANNER_FONT="slant"

banner() {
    clear
    if command -v figlet >/dev/null 2>&1; then
        figlet -f "$BANNER_FONT" "$BANNER_TEXT" 2>/dev/null || echo "$BANNER_TEXT"
    else
        echo "$BANNER_TEXT"
    fi
    echo
}

# Option 1: Calculator
option1() {
    while true; do
        clear
        echo "=== Advanced Calculator ==="
        echo "Type a math expression and press Enter."
        echo "Type 'help' for available commands."
        echo "Type 'back' to return to the main menu."
        echo
        read -p "Calc> " expr

        if [[ "$expr" == "back" ]]; then
            break
        elif [[ "$expr" == "help" ]]; then
            echo
            echo "Available functions:"
            echo "  sqrt(x)   → square root"
            echo "  x^y       → power"
            echo "  s(x)      → sine (x in radians)"
            echo "  c(x)      → cosine"
            echo "  a(x)      → arctangent"
            echo "  l(x)      → natural log"
            echo "  e(x)      → exponential (e^x)"
            echo
            read -p "Press Enter to continue..."
            continue
        fi

        result=$(echo "$expr" | bc -l 2>/dev/null)

        if [[ $? -ne 0 || -z "$result" ]]; then
            echo "Invalid expression. Try again."
        else
            printf "Result: %f\n" "$result" | sed 's/\(\.[0-9]*[1-9]\)0*$/\1/;s/\.0$//'
        fi

        echo
        read -p "Press Enter to continue..."
    done
}

# Option 2: System Monitor
option2() {
    clear
    echo "=== System Monitor ==="
    echo

    echo "Uptime:"
    uptime -p 2>/dev/null || uptime
    echo

    echo "CPU Load:"
    if command -v mpstat >/dev/null 2>&1; then
        mpstat 1 1 | awk '/Average/ {printf "  Usage: %.1f%%\n", 100-$NF}'
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        awk -v FS=" " '/^cpu / {usage=($2+$4)*100/($2+$4+$5); printf "  Usage: %.1f%%\n", usage}' /proc/stat
    else
        top -l 1 | grep "CPU usage"
    fi
    echo

    echo "Memory Usage:"
    if command -v free >/dev/null 2>&1; then
        total=$(free -m | awk '/Mem:/ {print $2}')
        used=$(free -m | awk '/Mem:/ {print $3}')
        percent=$(( used * 100 / total ))
        filled=$(( percent * 50 / 100 ))
        empty=$(( 50 - filled ))
        bar="$(printf "%${filled}s" | tr ' ' '#')$(printf "%${empty}s")"
        printf "  [%-50s] %d%% (%dMB / %dMB)\n" "$bar" "$percent" "$used" "$total"
    else
        vm_stat | head -5
    fi
    echo

    echo "Disk Usage:"
    df -h | awk 'NR==1 || /^\/dev/ {printf "  %-15s %5s used of %5s mounted on %s\n", $1, $3, $2, $6}'
    echo

    pause
}

# Option 3: ASCII Art Generator with dynamic font switching
option3() {
    clear
    echo "=== ASCII Art Generator ==="
    echo "Type text to convert into ASCII art."
    echo "Commands:"
    echo "  font   → change font"
    echo "  back   → return to main menu"
    echo

    current_font="standard"

    while true; do
        read -p "Text> " text
        case "$text" in
            back)
                break
                ;;
            font)
                echo "Available fonts:"
                ls "$(figlet -I2)" | sed -E 's/\.(flf|flc|tlf|txt)$//'
                read -p "Choose a font: " newfont
                if [[ -n "$newfont" ]]; then
                    current_font="$newfont"
                    echo "Font changed to: $current_font"
                fi
                ;;
            *)
                if command -v figlet >/dev/null 2>&1; then
                    figlet -f "$current_font" "$text" 2>/dev/null || figlet "$text"
                elif command -v toilet >/dev/null 2>&1; then
                    toilet -f "$current_font" "$text" 2>/dev/null || toilet "$text"
                else
                    echo "Neither figlet nor toilet is installed. Please install one."
                    break
                fi
                ;;
        esac
        echo
    done
}

# Option 4: File Organizer (with explanation + confirmation)
option4() {
    clear
    echo "=== File Organizer ==="
    echo
    echo "This tool will scan the directory you specify and move files into subfolders"
    echo "based on their type. The following folders will be created if they don't exist:"
    echo "  - Images (jpg, png, gif, bmp, etc.)"
    echo "  - Documents (pdf, doc, txt, xls, ppt, etc.)"
    echo "  - Archives (zip, tar, gz, rar)"
    echo "  - Music (mp3, wav, flac)"
    echo "  - Videos (mp4, mkv, avi, mov)"
    echo "  - Others (everything else)"
    echo
    read -p "Enter directory to organize (or type 'back' to cancel): " dir
    if [[ "$dir" == "back" ]]; then
    echo "Cancelled. Returning to menu."
    pause
    return
fi


    echo
    echo "You entered: $dir"
    read -p "Is this correct? (y/n): " confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo "Cancelled. Returning to menu."
        pause
        return
    fi

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

    echo
    echo "Files in '$dir' have been organized into subfolders."
    pause
}

# Option 5: Command Runner
option5() {
    clear
    echo "=== Command Runner ==="
    echo "Type commands as you would in macOS Terminal."
    echo "Type 'back' to return."
    echo
    while true; do
        read -p "Shell> " cmd
        if [[ "$cmd" == "back" ]]; then
            break
        fi
        eval "$cmd"
        rc=$?
        if [[ $rc -ne 0 ]]; then
            echo "(command exited with status $rc)"
        fi
    done
}

# Easter Egg: Rename banner
option_rename() {
    clear
    echo "=== Rename the Banner ==="
    echo "Type new text for the main menu banner."
    echo "Commands:"
    echo "  font   → change font"
    echo "  back   → return to main menu"
    echo

    local font="standard"

    while true; do
        read -p "Rename> " input
        case "$input" in
            back)
                break
                ;;
            font)
                echo "if you found this you should know the font you want"
                read -p "Choose a font: " newfont
                [[ -n "$newfont" ]] && font="$newfont"
                ;;
            *)
                figlet -f "$font" "$input" 2>/dev/null || echo "$input"
                echo
                read -p "Use this as the new banner? (y/n): " confirm
                if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                    BANNER_TEXT="$input"
                    BANNER_FONT="$font"
                    banner() {
                        clear
                        figlet -f "$BANNER_FONT" "$BANNER_TEXT" 2>/dev/null || echo "$BANNER_TEXT"
                        echo
                    }
                    echo "Banner updated!"
                    sleep 1
                    break
                fi
                ;;
        esac
    done
}
option6() {
    clear
    echo "=== Extra ==="
    echo "This is a page for any notes I wanted to write about the tool."
    echo
    echo "Additional commands in main menu:"
    echo "r - reloads script for whatever reason you need"
    echo "rename - easter egg to change the banner with new ascii art"
    pause
}

# === Main loop ===
while true; do
    banner
    echo "1. Calculator"
    echo "2. System Monitor"
    echo "3. ASCII Art Generator"
    echo "4. File Organizer"
    echo "5. Command Runner"
    echo "6. Extra"
    echo "7. Exit"
    echo
    read -p "Choose an option: " option

    case $option in
        1) option1 ;;
        2) option2 ;;
        3) option3 ;;
        4) option4 ;;
        5) option5 ;;
        6) option6 ;;
        7)
            clear
            echo "Exiting..."
            sleep 1
            clear
            exit 0
            ;;
        
        r)  # hidden devtool: reload script
            clear
            echo "Reloading script"
            sleep 1
            exec "$0"
            ;;
        rename)  # hidden easter egg: rename banner
            option_rename
            ;;
        *)
            echo "Invalid option. Please try again."
            sleep 1
            ;;
    esac
done
