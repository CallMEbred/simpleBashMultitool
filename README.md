# simpleBashMultitool
A simple multitool coded in bash made for a school project

Installation
Follow these steps to install and run Multitool on macOS:

1. Install Homebrew (if not already installed)
bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
After installation, make sure Homebrew is on your PATH. The installer will print instructions — usually something like:

bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
2. Clone the repository
bash
git clone https://github.com/yourusername/multitool.git
cd multitool
3. Install dependencies
Run the script once — it will check for required tools (bc, figlet, top, df, uptime) and prompt to install them if missing.

Or install manually:

bash
brew install bc figlet
4. Unquarantine the app (if needed)
If you downloaded Multitool.app directly, macOS may block it. To remove the quarantine flag:

bash
xattr -d com.apple.quarantine /path/to/Multitool.app
5. Run Multitool
If you’re using the .app bundle: double‑click Multitool.app in Finder.

If you’re running the script directly:

bash
chmod +x real_multitool.sh
./real_multitool.sh
🛠 Troubleshooting
Homebrew not found
Code
command not found: brew
Re‑install Homebrew:

bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
Then add it to your shell environment:

bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
Permission denied when running the script
Code
permission denied: ./real_multitool.sh
Fix with:

bash
chmod +x real_multitool.sh
macOS blocked the app
If you see “can’t be opened because it is from an unidentified developer”:

Right‑click the app → Open → confirm.

Or run:

bash
xattr -d com.apple.quarantine /path/to/Multitool.app
Dependencies still missing after install
If the script still says something like Missing: figlet:

Make sure Homebrew’s bin directory is in your PATH:

bash
echo $PATH
You should see /opt/homebrew/bin (Apple Silicon) or /usr/local/bin (Intel).

Fonts not showing up in ASCII Art Generator
bash
brew install figlet-fonts
Restart the script and fonts should appear.

Still stuck?
Run from inside the repo folder:

bash
cd multitool
./real_multitool.sh
If issues persist, open an Issue with your OS version and error message.
