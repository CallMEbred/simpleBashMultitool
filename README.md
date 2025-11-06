# simpleBashMultitool

A Bash-based multitool with a simple menu interface. Current features include:

- Calculator: Supports arithmetic, powers, square roots, trigonometric functions, logarithms, and exponentials (via `bc -l`).
- File Organizer: Sorts files in a directory into subfolders by type (Images, Documents, Archives, Music, Videos, Others).
- Messy Folder Generator: Creates a test folder with mixed file types on your Desktop for organizing practice.
- Man Page Viewer: Displays manual pages for specified commands.

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
   sudo apt install git bc man-db
   ```

   On Fedora:
   ```bash
   sudo dnf install git bc man-db
   ```

   On Arch:
   ```bash
   sudo pacman -S git bc man-db
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

---

### Windows

This script requires a Unix‑like shell.

**Option A: Windows Subsystem for Linux (WSL) — Recommended**

1. Install WSL: [Microsoft guide](https://learn.microsoft.com/windows/wsl/install).
2. Open your Linux terminal (Ubuntu, Debian, etc.).
3. Follow the Linux instructions above.

**Option B: Git Bash (simpler, but limited)**

1. Install [Git for Windows](https://git-scm.com/download/win) (includes Git Bash).
2. Open Git Bash.
3. Clone the repository:

   ```bash
   git clone https://github.com/CallMEbred/simpleBashMultitool.git
   cd simpleBashMultitool
   ```

4. Run the script:

   ```bash
   ./multitool.sh
   ```

Note: Some features (such as `man`) may not work in Git Bash. WSL is recommended for full compatibility.

---

## Usage

When you run the script, you will see a menu:

```
tool test

1) Calculator
2) File Organizer
3) (temp) runs man command for specified command
```

- Type `1` → Calculator (supports +, -, *, /, ^, sqrt, trig functions, logs, exponentials).  
- Type `2` → File Organizer (sorts files into Images, Documents, Archives, Music, Videos, Others).  
- Type `messy` → Creates a messy test folder on your Desktop with mixed files.  
- Type `3` → View man pages for a command.  
- Type `e` → Exit.  
- Type `r` → Restart the script.  

---

## Troubleshooting

- `permission denied: ./multitool.sh` → Run `chmod +x multitool.sh` first.  
- `command not found: bc` → Install `bc` with your package manager (`sudo apt install bc`, `sudo dnf install bc`, etc.).  
- `man` not working → Install `man-db` on Linux. Git Bash may not support `man`.  
- Messy folder not created → Check that your Desktop path is correct (`~/Desktop`).  
- Files not organizing correctly → Ensure you typed the correct directory path and have permission to move files.  
- macOS blocked the app → Right‑click → Open, or run `xattr -d com.apple.quarantine /path/to/Multitool.app`.

---

## About

This project is a learning exercise in Bash scripting, menu systems, and file organization.  
It is designed to be simple, portable, and a foundation for adding more tools in the future.
