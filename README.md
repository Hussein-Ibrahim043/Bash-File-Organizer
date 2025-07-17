# 📂 File Organizer

A **bash script** that helps you clean up messy directories by automatically organizing files into folders based on their file types.

---

## ✨ Features

- Organize files by extension into folders (e.g. `.txt` → `TextFiles/`)
- Interactive CLI spinner animation ✨
- Dry-run mode to preview changes
- Configurable extension-to-folder mappings
- Colorful and fun terminal output

---
## 🏗️ Installation

**Clone the repo:**
```bash
git clone https://github.com/Hussein-Ibrahim043/Bash-File-Organizer.git
cd motiquote
```

**Make the script executable:**
```bash
chmod +x file_organizer.sh
```

## 📊 Usage

```bash
./file_organizer.sh [directory] [--dry-run]
```

### Options

| Option      | Description                                 |
| ----------- | ------------------------------------------- |
| `directory` | Target directory to organize (default: `.`) |
| `--dry-run` | Show what would be moved, without doing it  |
| `--version` | Show script version info                    |
| `--help`    | Show help message                           |

---

## 📁 Example

```bash
# Basic organization
./file_organizer.sh Downloads/

# Test without moving files
./file_organizer.sh Projects/ --dry-run
```

---

## ⚙️ Configuration

Create a file named `extensions.conf` in the same directory as the script with the following format:

```ini
.txt=Documents
.pdf=Documents
.jpg=Images
.png=Images
.mp3=Audio
.mp4=Videos
.sh=Scripts
.py=Scripts
.c=Code
.cpp=Code
.zip=Archives
.tar.gz=Archives
```

---

## 📸 Output Example

```text
🏡 Directory: Projects/
⌛ Preparing to organize files...

[DRY RUN] Would move 'file1.txt' → Documents/
[DRY RUN] Would move 'image1.jpg' → Images/
⚠️ Skipped 'unknown.xyz' (unknown extension)

🌟 Summary:
📁 Files moved   : 0
❓ Files skipped : 1
📑 Log saved     : organizer.log
```

---

## 🚀 Features To Improve

- Add support for nested folder traversal
- Support custom log file location
- Add config option for unknown extensions folder

---

## 💪 Author

GitHub (https://github.com/Hussein-Ibrahim043)
LinkedIn (https://linkedin.com/in/hussein-ibrahim043)

---

## 💾 License

This project is licensed under the MIT License. Feel free to use and modify!

