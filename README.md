# simpleBashMultitool

A simple multitool coded in Bash, packaged as a macOS app. Provides utilities like file organization, ASCII art generation, and system info.

---

## 🚀 Installation

### 1. Install [Homebrew](https://brew.sh) (if not already installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installation, add Homebrew to your PATH (the installer will print the exact command). Usually:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

---

### 2. Get the Multitool

**Option A: Clone with Git**

```bash
git clone https://github.com/CallMEbred/simpleBashMultitool.git
cd simpleBashMultitool
```

**Option B: Download as ZIP**

1. Go to the [repo page](https://github.com/CallMEbred/simpleBashMultitool).  
2. Click the green **Code** button → **Download ZIP**.  
3. Unzip it (double‑click in Finder).  
4. (Optional) Wrap it into an `.app` bundle:  
   - Open **Script Editor** on macOS.  
   - Paste this AppleScript (adjust the path if needed):

     ```applescript
     tell application "Terminal"
         do script "cd ~/Downloads/simpleBashMultitool && ./real_multitool.sh; exit"
     end tell
     ```

   - Save as **Application** format, name it `Multitool.app`.  
   - You can now launch the multitool by double‑clicking the app.  
5. If you want a clean app‑only folder, you can delete the `README.md` file after unzipping.

---

### 3. Install dependencies

Run the script once — it will check for required tools (`bc`, `figlet`, `top`, `df`, `uptime`) and prompt to install them if missing.

Or install manually:

```bash
brew install bc figlet
```

(`top`, `df`, and `uptime` are built into macOS.)

---

### 4. Unquarantine the app (if needed)

If you downloaded `Multitool.app` directly, macOS may block it. To remove the quarantine flag:

```bash
xattr -d com.apple.quarantine /path/to/Multitool.app
```

---

### 5. Run Multitool

- If you’re using the `.app` bundle: double‑click **Multitool.app** in Finder.  
- If you’re running the script directly:

```bash
chmod +x real_multitool.sh
./real_multitool.sh
```

---

## 🛠 Troubleshooting

### Homebrew not found

```
command not found: brew
```

Re‑install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent
