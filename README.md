# simpleBashMultitool

A Bash-based multitool with a simple menu interface. Current features include:

- Calculator: Supports basic arithmetic, powers, square roots, trigonometric functions, logarithms, and exponentials (via `bc -l`).
- File Organizer: Sorts files in a directory into subfolders by type (Images, Documents, Archives, Music, Videos, Others).
- Messy Folder Generator: Creates a test folder with mixed file types on your Desktop for organizing practice.
- Man Page Viewer: Displays manual pages for specified commands.

---

## Installation

### macOS

#### 1. Install Homebrew (if not already installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installation, add Homebrew to your PATH (the installer will print the exact command). Usually:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### 2. Get the script

Option A: Clone with Git

```bash
git clone https://github.com/CallMEbred/simpleBashMultitool.git
cd simpleBashMultitool
```

Option B: Download as ZIP

1. Go to the [repository page](https://github.com/CallMEbred/simpleBashMultitool).  
2. Click the green **Code** button → **Download ZIP**.  
3. Unzip it (double‑click in Finder).  
4. Move into the extracted folder.

#### 3. Install dependencies

```bash
brew install bc
```

(`man` is built into macOS.)

#### 4. Run the script

```bash
chmod +x tooltest.sh
./tooltest.sh
```

---

### Linux

#### 1. Install Git and dependencies

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

#### 2. Get the script

```bash
git clone https://github.com/CallMEbred/simpleBashMultitool.git
cd simpleBashMultitool
```

Or download the ZIP from GitHub and extract it.

#### 3. Run the script

```bash
chmod +x tooltest.sh
./tooltest.sh
```

---

### Windows

This script requires a Unix‑like shell.

Option A: Windows Subsystem for Linux (WSL) — Recommended

1. Install WSL: [Microsoft guide](https://learn.microsoft.com/windows/wsl/install).  
2. Open your Linux terminal (Ubuntu, Debian, etc.).  
3. Follow the Linux instructions above.

Option B: Git Bash (simpler, but limited)

1. Install [Git for Windows](https://git-scm.com/download/win) (includes Git Bash).  
2. Open Git Bash.  
3. Clone the repository:

   ```bash
   git clone https://github.com/CallMEbred/simpleBashMultitool.git
   cd simpleBashMultitool
   ```

4. Run the script:

   ```bash
   ./tooltest.sh
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

- `permission denied: ./tooltest.sh` → Run `chmod +x tooltest.sh` first.  
- `command not found: bc` → Install `bc` with your package manager (`brew install bc`, `sudo apt install bc`, etc.).  
- `man` not working → Install `man-db` on Linux. Git Bash may not support `man`.  
- Messy folder not created → Check that your Desktop path is correct (`~/Desktop`).  
- Files not organizing correctly → Ensure you typed the correct directory path and have permission to move files.

---

## About

This project is a learning exercise in Bash scripting, menu systems, and file organization.  
It is designed to be simple, portable, and a foundation for adding more tools in the future.
