#!/bin/bash

# Bash Multitool - Created by Remi Heller

SCRIPT_PATH="$(realpath "$0")"
clear
printf '\033[8;30;85t'

main() {
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
        echo "|  [5] Password Generator                                   |"
        echo "|  [6] File Encryption                                      |"
        echo "|                                                           |"
        echo "|  [messy] Create Messy Test Folder                         |"
        echo "|                                                           |"
        echo "|  [e]     Exit                                             |"
        echo "|  [r]     Restart Script                                   |"
        echo "+-----------------------------------------------------------+"
        echo

        read -p "Select an option: " option

        case $option in
            1) option1 ;;
            2) option2 ;;
            3) option3 ;;
            4) option4 ;;
            5) option5 ;;
            6) option6 ;;
            messy) makemessy ;;
            e)
                clear
                cat << "EOF"
+-------------------------------------------------------------+
|                         SESSION CLOSED                      |
+-------------------------------------------------------------+


EOF
                exit 0
                ;;
            r) exec "$SCRIPT_PATH" ;;
            *)
                echo "Invalid option."
                sleep 1
                ;;
        esac
    done
}

# Pause and wait for Enter before returning to menu
ete() {
    echo
    echo "-------------------------------------------------------------"
    read -p "Press Enter to return..." _
    clear
    return
}

check_dependency() {
    local pkg="$1"
    
    if ! command -v "$pkg" &> /dev/null; then
        echo "$pkg is not installed."
        echo -n "Install $pkg using Nix? [y/N]: "
        read response

        if [[ "$response" =~ ^[yY]$ ]]; then
            # Ensure Nix is installed first
            if ! command -v nix-env &> /dev/null; then
                echo "Nix is not installed."
                echo -n "Install Nix now? [y/N]: "
                read nix_response

                if [[ "$nix_response" =~ ^[yY]$ ]]; then
                    sh <(curl -L https://nixos.org/nix/install) --daemon

                    if ! command -v nix-env &> /dev/null; then
                        echo "Nix installation failed. Please install manually."
                        return 1
                    fi
                else
                    echo "Cannot proceed without Nix."
                    return 1
                fi
            fi

            # Install the package
            nix-env -iA "nixpkgs.$pkg"

            if ! command -v "$pkg" &> /dev/null; then
                echo "$pkg installation failed. Please install manually."
                return 1
            else
                echo "$pkg installed successfully!"
            fi
        else
            echo "$pkg is required for some features."
            return 1
        fi
    fi
    return 0
}

# Check all required dependencies
dependencies() {
    local required_packages=("figlet" "openssl")
    local missing_packages=()
    
    # Check which packages are missing
    for pkg in "${required_packages[@]}"; do
        if ! command -v "$pkg" &> /dev/null; then
            missing_packages+=("$pkg")
        fi
    done
    
    # If any packages are missing, ask to install them
    if [ ${#missing_packages[@]} -gt 0 ]; then
        echo "Missing dependencies: ${missing_packages[*]}"
        echo -n "Would you like to install missing dependencies using Nix? [y/N]: "
        read response
        
        if [[ "$response" =~ ^[yY]$ ]]; then
            for pkg in "${missing_packages[@]}"; do
                check_dependency "$pkg"
            done
        else
            echo
            echo "Some features may not work without these dependencies."
            echo "Press Enter to continue anyway..."
            read
        fi
    fi
}

makemessy() {
    while true; do
        clear
        cat << "EOF"
+-------------------------------------------------------------+
|                   MESSY FOLDER GENERATOR                    |
+-------------------------------------------------------------+
EOF

        echo
        echo "Generate test files for the File Organizer"
        echo "-------------------------------------------------------------"
        echo "[1] Mixed file extensions"
        echo "[2] Same extension, varied dates"
        echo "[back] Return to main menu"
        echo
        read -p "Choose an option: " mode

        if [[ "$mode" == "back" ]]; then
            clear
            return
        fi

        TARGET="$HOME/Desktop/test_messy"
        mkdir -p "$TARGET"
        cd "$TARGET" || exit 1

        if [[ "$mode" == "1" ]]; then
            touch image1.jpg image2.PNG photo.gif
            touch doc1.pdf doc2.DOCX notes.txt spreadsheet.xlsx presentation.ppt
            touch archive1.zip archive2.tar.gz backup.rar
            touch song1.mp3 song2.wav track.flac
            touch video1.mp4 movie.mkv clip.AVI
            touch misc1.dat misc2.bin script.sh README.md

            for f in *; do
                echo "Dummy content for $f" > "$f"
            done

            echo
            echo "✓ Created mixed-extension messy folder at: $TARGET"
            cd
            ete
            return

        elif [[ "$mode" == "2" ]]; then
            # Store date/filename pairs as pipe-separated values
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

            # Parse and set modification times for each file
            while IFS='|' read -r datestr fname; do
                [[ -z "$datestr" || -z "$fname" ]] && continue
                echo "Dummy content for $fname" > "$fname"

                # Try GNU touch format (-d), fallback to BSD format (-t)
                if touch -d "$datestr" "$fname" 2>/dev/null; then
                    :
                else
                    # Convert "YYYY-MM-DD HH:MM" to "YYYYMMDDHHMM" for BSD touch
                    ts="${datestr//-/}"
                    ts="${ts/:/}"
                    ts="${ts/ /}"
                    touch -t "$ts" "$fname"
                fi
            done <<< "$dates_and_names"

            echo
            echo "✓ Created same-extension messy folder with varied timestamps at: $TARGET"
            cd
            ete
            return

        else
            echo "Invalid option."
            sleep 1
        fi
    done
}

option1() {
    while true; do
        clear
        cat << "EOF"
+-------------------------------------------------------------+
|                        CALCULATOR                           |
+-------------------------------------------------------------+
EOF

        echo
        echo "Type expressions to evaluate"
        echo "-------------------------------------------------------------"
        echo "[help] View syntax help"
        echo "[back] Return to main menu"
        echo
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
        elif [[ -n "$input" ]]; then
            result=$(echo "$input" | bc -l 2>/dev/null)
            if [[ $? -eq 0 ]]; then
                echo "-------------------------------------------------------------"
                echo "Result: $result"
            else
                echo "-------------------------------------------------------------"
                echo "Error: Invalid expression"
            fi
            echo
            read -p "Press Enter to continue..." _
        fi
    done
}

option2() {
    while true; do
        clear
        cat << "EOF"
+-------------------------------------------------------------+
|                     FILE ORGANIZER                          |
+-------------------------------------------------------------+
EOF

        echo
        echo "Organize files by type or creation date"
        echo "-------------------------------------------------------------"
        echo "[t] Sort by file type"
        echo "[d] Sort by date created"
        echo "[back] Return to main menu"
        echo
        echo "Tip: Type 'messy' in the main menu to generate test files"
        echo
        read -p "Enter directory to organize: " dir

        if [[ "$dir" == "back" ]]; then
            clear
            return
        fi

        # Validate directory exists
        if [[ ! -d "$dir" ]]; then
            echo
            echo "✗ Error: Directory not found."
            sleep 2
            continue
        fi

        echo
        echo "You entered: $dir"
        read -p "Is this correct? (y/n): " confirm
        if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
            continue
        fi

        echo
        read -p "Sort by file type (t) or date created (d)? " input

        if [[ "$input" == "d" || "$input" == "D" ]]; then
            echo
            read -p "Sort by year (y) or month (m)? " choice

            if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
                for file in "$dir"/*; do
                    if [[ -f "$file" ]]; then
                        # Get year from file modification time (macOS/BSD stat)
                        year=$(stat -f "%Sm" -t "%Y" "$file" 2>/dev/null)
                        if [[ -n "$year" ]]; then
                            mkdir -p "$dir/$year"
                            mv "$file" "$dir/$year/"
                        fi
                    fi
                done
                echo
                echo "✓ Files organized by year in: $dir"

            elif [[ "$choice" == "m" || "$choice" == "M" ]]; then
                for file in "$dir"/*; do
                    if [[ -f "$file" ]]; then
                        # Get year-month from file modification time
                        month=$(stat -f "%Sm" -t "%Y-%m" "$file" 2>/dev/null)
                        if [[ -n "$month" ]]; then
                            mkdir -p "$dir/$month"
                            mv "$file" "$dir/$month/"
                        fi
                    fi
                done
                echo
                echo "✓ Files organized by month in: $dir"

            else
                echo "Invalid option."
                sleep 1
                continue
            fi

        elif [[ "$input" == "t" || "$input" == "T" ]]; then
            mkdir -p "$dir"/{Images,Documents,Archives,Music,Videos,Others}
            
            # Enable nullglob (empty on no match) and nocaseglob (case-insensitive matching)
            shopt -s nullglob nocaseglob

            for file in "$dir"/*; do
                if [[ -f "$file" ]]; then
                    case "$file" in
                        *.jpg|*.jpeg|*.png|*.gif|*.bmp)
                            mv "$file" "$dir/Images/"
                            ;;
                        *.pdf|*.doc|*.docx|*.txt|*.xls|*.xlsx|*.ppt|*.pptx)
                            mv "$file" "$dir/Documents/"
                            ;;
                        *.zip|*.tar|*.gz|*.rar)
                            mv "$file" "$dir/Archives/"
                            ;;
                        *.mp3|*.wav|*.flac)
                            mv "$file" "$dir/Music/"
                            ;;
                        *.mp4|*.mkv|*.avi|*.mov)
                            mv "$file" "$dir/Videos/"
                            ;;
                        *)
                            mv "$file" "$dir/Others/"
                            ;;
                    esac
                fi
            done

            shopt -u nullglob nocaseglob
            echo
            echo "✓ Files organized by type in: $dir"

        else
            echo "Invalid option."
            sleep 1
            continue
        fi

        ete
        return
    done
}

option3() {
    clear
    cat << "EOF"
+-------------------------------------------------------------+
|                    SHELL COMMAND RUNNER                     |
+-------------------------------------------------------------+
EOF
    echo
    echo "Run default macOS shell commands"
    echo "-------------------------------------------------------------"
    echo "[back] Return to main menu"
    echo

    cd "$HOME"

    while true; do
        cwd=$(pwd)

        # Display ~ for home directory, otherwise show full path
        if [[ "$cwd" == "$HOME" ]]; then
            prompt="~ $ "
        else
            prompt="$cwd $ "
        fi

        read -p "$prompt" cmd
        [[ "$cmd" == "back" ]] && { clear; return; }

        # Use builtin for cd to change directory in current shell
        if [[ "$cmd" =~ ^cd[[:space:]] ]]; then
            builtin $cmd
        else
            bash -c "$cmd"
        fi
    done
}

option4() {
    # Check if figlet is available
    if ! command -v figlet &> /dev/null; then
        clear
        cat << "EOF"
+-------------------------------------------------------------+
|                        ASCII WORD ART                       |
+-------------------------------------------------------------+
EOF
        echo
        echo "ERROR: figlet is not installed."
        echo "Please run the script again to install dependencies."
        ete
        return
    fi

    clear
    cat << "EOF"
+-------------------------------------------------------------+
|                        ASCII WORD ART                       |
+-------------------------------------------------------------+
EOF

    echo
    echo "Generate ASCII art using figlet"
    echo "-------------------------------------------------------------"
    echo "[font] Change font style"
    echo "[back] Return to main menu"
    echo

    current_font="standard"

    while true; do
        read -p "ASCII> " input

        if [[ "$input" == "back" ]]; then
            clear
            return

        elif [[ "$input" == "font" ]]; then
            echo
            echo "Available fonts:"
            echo "-------------------------------------------------------------"
            figlet -l 2>/dev/null || echo "standard, slant, banner, block, bubble, digital, ivrit, lean, mini, script, shadow, smscript, smslant, smshadow, smblock, term"
            echo
            read -p "Enter font name: " fontname
            current_font="$fontname"
            echo "✓ Font set to '$current_font'."
            echo

        elif [[ -n "$input" ]]; then
            echo
            figlet -f "$current_font" "$input" 2>/dev/null || echo "✗ Error: Font not found or figlet unavailable."
            echo
        fi
    done
}

option5() {
    while true; do
        clear
        cat << "EOF"
+-------------------------------------------------------------+
|                      PASSWORD GENERATOR                     |
+-------------------------------------------------------------+
EOF

        echo
        echo "Generate secure random passwords"
        echo "-------------------------------------------------------------"
        echo "[back] Return to main menu"
        echo
        read -p "Enter password length: " length

        if [[ "$length" == "back" ]]; then
            clear
            return
        fi

        # Validate input is a number
        if ! [[ "$length" =~ ^[0-9]+$ ]]; then
            echo
            echo "✗ Error: Please enter a valid number."
            sleep 2
            continue
        fi

        chars='A-Za-z0-9!@#$%^&*()_+{}[]:;<>,.?~'
        password=""

        # Generate password character by character from /dev/urandom
        # LC_ALL=C prevents locale issues with tr
        while [ ${#password} -lt $length ]; do
            random_char=$(LC_ALL=C tr -dc "$chars" < /dev/urandom | head -c 1)
            password="${password}${random_char}"
        done

        echo
        echo "Generated Password:"
        echo "-------------------------------------------------------------"
        echo "$password"
        ete
        return
    done
}

option6() {
    # Check if openssl is available
    if ! command -v openssl &> /dev/null; then
        clear
        cat << "EOF"
+-------------------------------------------------------------+
|                        FILE ENCRYPTOR                       |
+-------------------------------------------------------------+
EOF
        echo
        echo "ERROR: OpenSSL is not installed."
        echo "Please run the script again to install dependencies."
        ete
        return
    fi

    while true; do
        clear
        cat << "EOF"
+-------------------------------------------------------------+
|                        FILE ENCRYPTOR                       |
+-------------------------------------------------------------+
EOF

        echo
        echo "AES-256-CBC Encryption/Decryption"
        echo "-------------------------------------------------------------"
        echo "[1] Encrypt a file"
        echo "[2] Decrypt a file"
        echo "[back] Return to main menu"
        echo
        read -p "Choose an option: " choice

        if [[ "$choice" == "back" ]]; then
            clear
            return

        elif [[ "$choice" == "1" ]]; then
            # ENCRYPTION MODE
            echo
            read -p "Enter the path to the file to encrypt: " input_file
            
            # Check if file exists
            if [[ ! -f "$input_file" ]]; then
                echo "✗ Error: File not found."
                sleep 2
                continue
            fi

            # Automatically set output filename with .enc extension
            output_file="${input_file}.enc"

            echo
            echo "Encrypting '$input_file'..."
            echo "You will be prompted to enter a password."
            echo
            
            # Use openssl with AES-256-CBC encryption
            # -aes-256-cbc: Use AES 256-bit encryption in CBC mode
            # -salt: Add salt to increase security
            # -pbkdf2: Use PBKDF2 key derivation function (more secure than default)
            # -in: Input file to encrypt
            # -out: Output encrypted file
            openssl enc -aes-256-cbc -salt -pbkdf2 -in "$input_file" -out "$output_file"
            
            # Check if encryption was successful
            if [[ $? -eq 0 ]]; then
                # Delete the original unencrypted file
                rm "$input_file"
                echo
                echo "✓ File encrypted successfully: $output_file"
                echo "✓ Original file deleted for security"
            else
                echo
                echo "✗ Encryption failed."
                # Remove failed encrypted file if it was created
                [[ -f "$output_file" ]] && rm "$output_file"
            fi
            
            echo
            read -p "Press Enter to continue..." _

        elif [[ "$choice" == "2" ]]; then
            # DECRYPTION MODE
            echo
            read -p "Enter the path to the encrypted file to decrypt: " input_file
            
            # Check if file exists
            if [[ ! -f "$input_file" ]]; then
                echo "✗ Error: File not found."
                sleep 2
                continue
            fi

            # Remove .enc extension to restore original filename
            # If file ends with .enc, strip it; otherwise add .dec
            if [[ "$input_file" == *.enc ]]; then
                output_file="${input_file%.enc}"
            else
                output_file="${input_file}.dec"
            fi

            echo
            echo "Decrypting '$input_file'..."
            echo "You will be prompted to enter the password used during encryption."
            echo
            
            # Use openssl to decrypt the file
            # -aes-256-cbc: Use AES 256-bit decryption in CBC mode
            # -d: Decrypt mode
            # -pbkdf2: Use PBKDF2 key derivation (must match encryption)
            # -in: Input encrypted file
            # -out: Output decrypted file
            openssl enc -aes-256-cbc -d -pbkdf2 -in "$input_file" -out "$output_file"
            
            # Check if decryption was successful
            if [[ $? -eq 0 ]]; then
                # Delete the encrypted file after successful decryption
                rm "$input_file"
                echo
                echo "✓ File decrypted successfully: $output_file"
                echo "✓ Encrypted file deleted"
            else
                echo
                echo "✗ Decryption failed. Check your password."
                # Remove failed output file if it was created
                [[ -f "$output_file" ]] && rm "$output_file"
            fi
            
            echo
            read -p "Press Enter to continue..." _

        else
            echo "✗ Invalid option."
            sleep 1
        fi
    done
}

# Check and install dependencies before starting
dependencies
main
