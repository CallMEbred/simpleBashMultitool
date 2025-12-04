# simpleBashMultitool

A Bash-based multitool with a simple menu interface. Current features include:

- **Calculator**: Supports arithmetic, powers, square roots, trigonometric functions, logarithms, and exponentials (via `bc -l`).
- **File Organizer**: Sorts files in a directory by type (Images, Documents, Archives, Music, Videos, Others) or by date (year/month).
- **Shell Command Runner**: Interactive shell environment for running macOS/Unix commands with working directory support.
- **ASCII Word Art Generator**: Create ASCII art text with customizable fonts using `figlet`.
- **Password Generator**: Generate secure random passwords with custom length using special characters.
- **File Encryptor**: Encrypt and decrypt files using AES-256-CBC encryption via OpenSSL.
- **Messy Folder Generator**: Creates test folders with mixed file types or varied timestamps for testing the File Organizer.

---

## Installation

### macOS

1. Ensure you have Git installed (macOS includes it by default; if not, install via Xcode Command Line Tools).
2. Get the script:

   ```bash
   git clone https://github.com/CallMEbred/simpleBashMultitool.git
   cd simpleBashMultitool
   ```

   Or download the ZIP from the [repository page](https://github.com/CallMEbred/simpleBashMultitool) and extract it.

3. Run the script:

   ```bash
   chmod +x multitool.sh
   ./multitool.sh
   ```

4. **Dependencies**: The script will automatically check for required dependencies (`figlet` and `openssl`) and offer to install them using Nix if they're missing. You can skip installation, but some features won't work without them.

#### Creating a macOS Application Bundle (Optional)

If you prefer to launch the multitool by double‑clicking an app icon:

1. Open **Script Editor** (Applications → Utilities → Script Editor).
2. Paste the following AppleScript, adjusting the path to where your script is located:

   ```applescript
   tell application "Terminal"
       do script "cd ~/Downloads/simpleBashMultitool && chmod +x multitool.sh && ./multitool.sh; exit"
   end tell
   ```

3. Go to **File → Export…**.
   - Set **File Format** to **Application**.
   - Name it `Multitool.app`.
   - Save it to your Applications folder or Desktop.

4. Double‑click `Multitool.app` to launch the multitool.  
   If macOS blocks the app, remove the quarantine flag:

   ```bash
   xattr -d com.apple.quarantine /path/to/Multitool.app
   ```

---

### Linux

1. Install Git and dependencies:

   On Debian/Ubuntu:
   ```bash
   sudo apt update
   sudo apt install git bc figlet openssl
   ```

   On Fedora:
   ```bash
   sudo dnf install git bc figlet openssl
   ```

   On Arch:
   ```bash
   sudo pacman -S git bc figlet openssl
   ```

2. Get the script:

   ```bash
   git clone https://github.com/CallMEbred/simpleBashMultitool.git
   cd simpleBashMultitool
   ```

   Or download the ZIP and extract it.

3. Run the script:

   ```bash
   chmod +x multitool.sh
   ./multitool.sh
   ```

**Note**: The script includes automatic dependency checking and can install missing packages via Nix if desired.

---

### Windows

This script requires a Unix‑like shell.

#### Option A: Windows Subsystem for Linux (WSL) — Recommended

1. Install WSL: [Microsoft guide](https://learn.microsoft.com/windows/wsl/install).
2. Open your Linux terminal (Ubuntu, Debian, etc.).
3. Follow the Linux instructions above (including installing dependencies with your package manager).

#### Option B: Git Bash (simpler, but limited)

1. Install [Git for Windows](https://git-scm.com/download/win) (includes Git Bash).
2. Open Git Bash.
3. Clone the repository:

   ```bash
   git clone https://github.com/CallMEbred/simpleBashMultitool.git
   cd simpleBashMultitool
   ```

4. Install dependencies:
   - Git Bash does not include `bc`, `figlet`, or `openssl` by default.  
   - The easiest way is to use [Chocolatey](https://chocolatey.org/) (a Windows package manager).  
   - First, install Chocolatey by following the instructions on its website.  
   - Then run (in an **Administrator** Command Prompt or PowerShell):

     ```powershell
     choco install bc figlet openssl
     ```

   - Restart Git Bash so it can detect the new binaries.

5. Run the script:

   ```bash
   ./multitool.sh
   ```

#### Notes on Permissions in Git Bash

- **`sudo` is not available in Git Bash.**  
  Git Bash runs with your current Windows user privileges. If you need elevated rights (for example, to install packages or access protected folders), you must run Git Bash itself as Administrator:
  - Right‑click the Git Bash shortcut → **Run as administrator**.

- **Folder access:**  
  Git Bash maps Windows drives under `/c/`, `/d/`, etc. For example, your Desktop is usually `/c/Users/<YourName>/Desktop`.  
  If you get "Permission denied" errors when accessing files:
  - Verify the path is correct (`pwd` shows your current directory).
  - Ensure your Windows user account has read/write permissions for that folder.
  - Run Git Bash as Administrator if necessary.

**Example:**  
To organize files in a messy test folder created on your Desktop, you would enter:

```bash
/c/Users/<YourName>/Desktop/test_messy
```

when prompted by the File Organizer.

---

## Usage

When you run the script, you will see a menu:

```
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

+-----------------------------------------------------------+
|  [1] Calculator                                           |
|  [2] File Organizer                                       |
|  [3] Run Shell Commands                                   |
|  [4] ASCII Word Art Generator                             |
|  [5] Password Generator                                   |
|  [6] File Encryptior                                      |
|                                                           |
|  [messy] Create Messy Test Folder                         |
|                                                           |
|  [e]     Exit                                             |
|  [r]     Restart Script                                   |
+-----------------------------------------------------------+
```

### Features Overview

#### 1. Calculator
- Supports basic arithmetic: `+`, `-`, `*`, `/`
- Powers: `^`
- Square root: `sqrt(x)`
- Trigonometric: `s(x)` = sin, `c(x)` = cos, `a(x)` = arctan
- Logarithm: `l(x)` = natural log
- Exponential: `e(x)` = exp(x)
- Type `help` for syntax help, `back` to return to main menu

#### 2. File Organizer
- **Sort by Type**: Organizes files into categories (Images, Documents, Archives, Music, Videos, Others)
- **Sort by Date**: Organizes files by creation date (yearly or monthly folders)
- Supports case-insensitive file extensions
- Type `back` to return to main menu
- Tip: Use the `messy` command from the main menu to create test files

#### 3. Run Shell Commands
- Interactive shell environment for executing commands
- Maintains working directory between commands
- `cd` command works to navigate directories
- Displays current directory in prompt
- Type `back` to return to main menu

#### 4. ASCII Word Art Generator
- Generate ASCII art text using `figlet`
- Change fonts with the `font` command
- Multiple font styles available (standard, slant, banner, block, bubble, etc.)
- Type `back` to return to main menu
- **Requires**: `figlet` (auto-installed via Nix if missing)

#### 5. Password Generator
- Generate secure random passwords
- Customizable length
- Includes uppercase, lowercase, numbers, and special characters
- Uses `/dev/urandom` for cryptographic randomness
- Type `back` to return to main menu

#### 6. File Encryptor
- **Encrypt files**: AES-256-CBC encryption with PBKDF2 key derivation
- **Decrypt files**: Restores encrypted files with the correct password
- Automatically adds `.enc` extension to encrypted files
- Removes original file after successful encryption for security
- Removes encrypted file after successful decryption
- Type `back` to return to main menu
- **Requires**: `openssl` (auto-installed via Nix if missing)

#### Messy Folder Generator
Type `messy` from the main menu to access:
- **Option 1**: Mixed file extensions - creates various file types for testing type-based sorting
- **Option 2**: Same extension, varied dates - creates `.txt` files with different timestamps for testing date-based sorting
- Creates test folder at `~/Desktop/test_messy`

---

## Dependency Management

The script automatically checks for required dependencies (`figlet` and `openssl`) on startup. If any are missing, you'll be prompted to install them using the Nix package manager:

- If you don't have Nix installed, the script will offer to install it automatically
- You can choose to skip installation, but some features won't work without the required tools
- Manual installation via your system's package manager is also an option

---

## Troubleshooting

- **`permission denied: ./multitool.sh`** → Run `chmod +x multitool.sh` first.  
- **`command not found: bc`** → Install `bc` with your package manager or accept the script's offer to install dependencies.
- **`figlet not found`** → Install `figlet` or let the script install it via Nix when prompted.
- **`openssl not found`** → Install `openssl` or let the script install it via Nix when prompted.
- **Messy folder not created** → Check that your Desktop path is correct (`~/Desktop` on macOS/Linux, `/c/Users/<YourName>/Desktop` on Windows).  
- **Files not organizing correctly** → Ensure you typed the correct directory path and have permission to move files.  
- **macOS blocked the app** → Right‑click → Open, or run `xattr -d com.apple.quarantine /path/to/Multitool.app`.
- **File dates not setting correctly** → The script uses BSD `stat` format for macOS. On Linux, it may need adjustment for GNU `stat`.
- **Encryption/Decryption fails** → Verify you're using the same password and that OpenSSL is properly installed.

---

## About

This project is a learning exercise in Bash scripting, menu systems, file organization, and security utilities.  
Created by Remi Heller, it is designed to be simple, portable, and a foundation for adding more tools in the future.

### License

This project is open source. Feel free to modify and distribute as needed.

### Contributing

Contributions, bug reports, and feature requests are welcome! Please submit issues or pull requests on the [GitHub repository](https://github.com/CallMEbred/simpleBashMultitool).
