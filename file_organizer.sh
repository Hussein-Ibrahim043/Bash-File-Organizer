#!/bin/bash

# ------------------------------------------
# 🚀 Simple File Organizer with CLI Bling 🎨
# ------------------------------------------

# === CONFIG ===
VERSION="1.1"
LOGFILE="organizer.log"
CONFIG_FILE="extensions.conf"
DRY_RUN=false

# === COLORS ===
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
RESET='\033[0m'


echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════╗"
echo "║         File Organizer v$VERSION                  ║"
echo "║         Clean Your Files in Style!           ║"
echo "╚══════════════════════════════════════════════╝"
echo -e "${RESET}"


# === HELP MENU ===
if [[ "$1" == "--help" ]]; then
  echo -e "\n${YELLOW}Usage:${RESET} ./file_organizer.sh [directory] [--dry-run]"
  echo -e "\n${CYAN}Options:${RESET}"
  echo "  [directory]     Directory to organize (default: current)"
  echo "  --dry-run       Show what would be moved without moving"
  echo "  --version       Show version info"
  echo "  --help          Show this help message"
  exit 0
fi

# === VERSION ===
if [[ "$1" == "--version" ]]; then
  echo "Simple File Organizer v$VERSION"
  exit 0
fi

# === DRY-RUN ===
if [[ "$2" == "--dry-run" || "$1" == "--dry-run" ]]; then
  DRY_RUN=true
fi

# === DIRECTORY ===
[[ "$1" != "--dry-run" && "$1" != "" ]] && TARGET_DIR="$1" || TARGET_DIR="."

# === LOAD EXTENSIONS ===
declare -A TYPES
if [[ -f "$CONFIG_FILE" ]]; then
  while IFS="=" read -r ext folder; do
    ext="${ext##*.}" # Remove dot if any
    TYPES[".$ext"]="$folder"
  done < "$CONFIG_FILE"
else
  echo -e "${RED}❌ Missing $CONFIG_FILE. Please create it with extension=mapping.${RESET}"
  exit 1
fi

# === Spinner Function ===
spinner() {
  local delay=0.1
  local spinstr='|/-\\'
  printf "${MAGENTA}Preparing to organize files"
  for ((i = 0; i < 50; i++)); do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    spinstr=$temp${spinstr%$temp}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "\n${RESET}"
}

# === WAIT & SPINNER ===
# === Animated Delay with Spinner ===
echo -ne "${MAGENTA}⏳ Preparing to organize files...${RESET}\n"
spinstr='|/-\\'
for i in {1..50}; do
  printf "\r${YELLOW}[${spinstr:i%4:1}]${RESET} Waiting...."
  sleep 0.1
done
printf "\r${GREEN}✅ Ready to organize files!${RESET}\n\n"

# === ORGANIZE FILES ===
MOVED=0
SKIPPED=0

for file in "$TARGET_DIR"/*; do
  [[ -f "$file" ]] || continue
  ext=".${file##*.}"
  filename=$(basename "$file")
  folder="${TYPES[$ext]}"

  if [[ -n "$folder" ]]; then
    mkdir -p "$TARGET_DIR/$folder"
    dest="$TARGET_DIR/$folder/$filename"

    if [[ -e "$dest" ]]; then
      new_name="${filename%.*}_$(date +%s).${filename##*.}"
      dest="$TARGET_DIR/$folder/$new_name"
    fi

    if $DRY_RUN; then
      echo -e "${MAGENTA}[DRY RUN]${RESET} Would move '${YELLOW}$filename${RESET}' → ${CYAN}$TARGET_DIR/$folder/${RESET}"
    else
      mv "$file" "$dest"
      echo "[$(date)] Moved '$filename' → $TARGET_DIR/$folder/" >> "$LOGFILE"
      echo -e "${GREEN}✔️  '${YELLOW}$filename${GREEN}' moved to ${BLUE}$TARGET_DIR/$folder/${RESET}"
      ((MOVED++))
    fi
  else
    echo -e "${RED}⚠️ Skipped '$filename' (unknown extension)${RESET}"
    ((SKIPPED++))
  fi
done

# === SUMMARY ===
echo -e "\n${CYAN}✨ Summary:${RESET}"
echo -e "  📁 ${GREEN}Files moved   : $MOVED${RESET}"
echo -e "  ❓ ${RED}Files skipped : $SKIPPED${RESET}"
echo -e "  📝 ${BLUE}Log saved     : $LOGFILE${RESET}"
echo -e "\n${GREEN}✅ Organizing complete.${RESET}"

exit 0
