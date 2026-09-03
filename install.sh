#!/usr/bin/env bash
# One Dark — Bash installer
# Usage: curl -fsSL https://raw.githubusercontent.com/sorokinArtemV/bash-onedark/main/install.sh | bash
set -euo pipefail

REPO_RAW_URL="https://raw.githubusercontent.com/sorokinArtemV/bash-onedark/main/onedark.sh"
THEME_DIR="$HOME/onedark"
THEME_FILE="$THEME_DIR/onedark.sh"
BASHRC="$HOME/.bashrc"
MARKER_START="# >>> onedark theme >>>"
MARKER_END="# <<< onedark theme <<<"

mkdir -p "$THEME_DIR"
curl -fsSL "$REPO_RAW_URL" -o "$THEME_FILE"

if ! grep -qF "$MARKER_START" "$BASHRC" 2>/dev/null; then
  {
    echo ""
    echo "$MARKER_START"
    echo "# sshd on most minimal images only forwards LANG/LC_* (see AcceptEnv"
    echo "# in /etc/ssh/sshd_config), so COLORTERM never reaches SSH sessions"
    echo "# (e.g. 'multipass shell') even when the local terminal supports it."
    echo "if [ -z \"\$COLORTERM\" ]; then"
    echo "  export COLORTERM=truecolor"
    echo "fi"
    echo "if [ -f \"$THEME_FILE\" ]; then"
    echo "  source \"$THEME_FILE\""
    echo "fi"
    echo "$MARKER_END"
  } >> "$BASHRC"
  echo "Added onedark to ~/.bashrc"
else
  echo "~/.bashrc already wired up for onedark"
fi

echo "onedark theme installed/updated at $THEME_FILE"
echo "Run 'source ~/.bashrc' (or open a new terminal) to apply."
