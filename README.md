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
4. (Optional) Wrap into an `.app` bundle using Script Editor if you want a double‑clickable app.  
5. You can delete the `README.md` if you want a clean app‑only folder.

#### 3. Install dependencies
- note: Only do this if the built-in dependency installer doesn't work, or you want to install dependencies manually.
```bash
brew install bc figlet
```

(`top`, `df`, and `uptime` are built into macOS.)

#### 4. Unquarantine the app (if needed)

```bash
xattr -d com.apple.quarantine /path/to/Multitool.app
```

#### 5. Run Multitool

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

The multitool is a Bash script, so you’ll need a Unix‑like environment:

#### Option A: Windows Subsystem for Linux (WSL)

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
   - `bc` and `figlet` are not included in Git Bash by default. You can either:
     - Use a package manager like [Chocolatey](https://chocolatey.org/) to install them, or  
     - Run the script inside WSL instead (recommended for full compatibility).

5. Run the script:

   ```bash
   ./real_multitool.sh
   ```

---

## 🛠 Troubleshooting

- **`command not found: brew`** → Re‑install Homebrew and add it to your PATH.  
- **`permission denied: ./real_multitool.sh`** → Run `chmod +x real_multitool.sh`.  
- **macOS blocked the app** → Right‑click → Open, or run `xattr -d com.apple.quarantine /path/to/Multitool.app`.  
- **Dependencies missing** → Ensure `bc` and `figlet` are installed and in your PATH.  
- **Fonts missing in ASCII Art Generator** → Install extra fonts: `brew install figlet-fonts` (macOS) or `sudo apt install figlet` (Linux).

---

## 📖 About

This project was built as a school project to explore Bash scripting and packaging scripts as macOS apps.
