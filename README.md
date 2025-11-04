# simpleBashMultitool

A simple multitool coded in Bash. Provides utilities like file organization, ASCII art generation, and system info. Originally created as a school project.

---

## 🚀 Installation

### macOS

#### 1. Install [Homebrew](https://brew.sh) (if not already installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installation, add Homebrew to your PATH (the installer will print the exact command). Usually:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

---

#### 2. Get the Multitool

**Option A: Clone with Git**

```bash
git clone https://github.com/CallMEbred/simpleBashMultitool.git
cd simpleBashMultitool
```

**Option B: Download as ZIP**

1. Go to the [repo page](https://github.com/CallMEbred/simpleBashMultitool).  
2. Click the green **Code** button → **Download ZIP**.  
3. Unzip it (double‑click in Finder).  
4. (Optional) Wrap into an `.app` bundle using Script Editor if you want a double‑clickable app:  
   - Open **Script Editor**.  
   - Paste this AppleScript (adjust the path if needed):

     ```applescript
     tell application "Terminal"
         do script "cd ~/Downloads/simpleBashMultitool && ./real_multitool.sh; exit"
     end tell
     ```

   - Save as **Application** format, name it `Multitool.app`.  
   - You can now launch the multitool by double‑clicking the app.  
5. If you want a clean app‑only folder, delete the `README.md` file after unzipping.

---

#### 3. Install dependencies

Run the script once — it will check for required tools (`bc`, `figlet`, `top`, `df`, `uptime`) and prompt to install them if missing.

Or install manually:

```bash
brew install bc figlet
```

(`top`, `df`, and `uptime` are built into macOS.)

---

#### 4. Unquarantine the app (if needed)

If you downloaded `Multitool.app` directly, macOS may block it. To remove the quarantine flag:

```bash
xattr -d com.apple.quarantine /path/to/Multitool.app
```

---

#### 5. Run Multitool

- If you’re using the `.app` bundle: double‑click **Multitool.app** in Finder.  
- If you’re running the script directly:

```bash
chmod +x real_multitool.sh
./real_multitool.sh
```

---

### Linux

#### 1. Install Git and dependencies

On Debian/Ubuntu:

```bash
sudo apt update
sudo apt install git bc figlet
```

On Fedora:

```bash
sudo dnf install git bc figlet
```

On Arch:

```bash
sudo pacman -S git bc figlet
```

#### 2. Get the Multitool

```bash
git clone https://github.com/CallMEbred/simpleBashMultitool.git
cd simpleBashMultitool
```

Or download the ZIP from GitHub and extract it.

#### 3. Run Multitool

```bash
chmod +x real_multitool.sh
./real_multitool.sh
```

---

### Windows

The multitool is a Bash script, so you’ll need a Unix‑like environment.

#### Option A: Windows Subsystem for Linux (WSL) — Recommended

1. [Install WSL](https://learn.microsoft.com/windows/wsl/install).  
2. Open your Linux terminal (Ubuntu, Debian, etc.).  
3. Follow the **Linux instructions** above (install dependencies, clone repo, run script).

#### Option B: Git Bash (simpler, but limited)

1. Install [Git for Windows](https://git-scm.com/download/win) (includes Git Bash).  
2. Open **Git Bash**.  
3. Clone the repo:

   ```bash
   git clone https://github.com/CallMEbred/simpleBashMultitool.git
   cd simpleBashMultitool
   ```

4. Install dependencies manually:  
   - `bc` and `figlet` are not included in Git Bash by default.  
   - You can try installing them with [Chocolatey](https://chocolatey.org/) or use WSL for full compatibility.

5. Run the script:

   ```bash
   ./real_multitool.sh
   ```

---

## 🛠 Troubleshooting

### Homebrew not found (macOS)

```
command not found: brew
```

Re‑install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then add it to your shell environment:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

---

### Permission denied when running the script

```
permission denied: ./real_multitool.sh
```

Fix with:

```bash
chmod +x real_multitool.sh
```

---

### macOS blocked the app

If you see “can’t be opened because it is from an unidentified developer”:

- Right‑click the app → **Open** → confirm.  
- Or run:

```bash
xattr -d com.apple.quarantine /path/to/Multitool.app
```

---

### Dependencies still missing after install

If the script still says something like `Missing: figlet`:

- Make sure your package manager’s bin directory is in your PATH:

```bash
echo $PATH
```

On macOS you should see `/opt/homebrew/bin` (Apple Silicon) or `/usr/local/bin` (Intel).  
On Linux, ensure `/usr/bin` or `/usr/local/bin` is present.

---

### Fonts not showing up in ASCII Art Generator

On macOS:

```bash
brew install figlet-fonts
```

On Linux (Debian/Ubuntu):

```bash
sudo apt install figlet
```

Restart the script and fonts should appear.

---

### Still stuck?

Run from inside the repo folder:

```bash
cd simpleBashMultitool
./real_multitool.sh
```

If issues persist, open an [Issue](https://github.com/CallMEbred/simpleBashMultitool/issues) with your OS version and error message.

---

## 📖 About

This project was built as a school project to explore Bash scripting and packaging scripts as macOS apps.
