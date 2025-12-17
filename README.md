# One Dark Bash Prompt & LS_COLORS

This script configures your Bash prompt and `LS_COLORS` theme to use the
**One Dark** color scheme.\
It supports both **truecolor (24-bit)** and **256-color fallback**
terminals.

------------------------------------------------------------------------

## 📂 Files

-   **`~/bin/onedark.sh`**\
    Main script with color definitions and prompt setup.\
    It is meant to be *sourced* into your current shell, not executed
    directly.

-   **`~/bin/onedark`**\
    Small launcher script that sources `onedark.sh`:

    ``` bash
    #!/bin/bash
    . "${HOME}/bin/onedark.sh"
    ```

------------------------------------------------------------------------

## 🎨 Features

-   One Dark colors for:
    -   Directories, symlinks, executables
    -   Archives, images, audio/video, scripts
    -   Source code files (C, Java, Python, etc.)
    -   Config/data formats (JSON, YAML, XML, SQL, DB, etc.)
-   Git branch and dirty marker in prompt
-   Auto-detects **truecolor** vs **256-color** terminal
-   Aliases `ls` to always use colors
-   Proper colors in `grep` and `less`

------------------------------------------------------------------------

## 🚀 Installation

This setup automatically enables the OneDark Bash prompt for every new Bash session.

### 1. Place the OneDark configuration script

Create a directory for the theme and copy the configuration file:

```bash
mkdir -p ~/onedark
cp onedark.sh ~/onedark/onedark.sh
```

> **Note**  
> `onedark.sh` is a Bash configuration script and must be **sourced**, not executed.  
> Do **not** mark it as executable (`chmod +x` is not required).

---

### 2. Ensure `.bashrc` is loaded (Git Bash users only)

On Ubuntu, this step is not required.

For Git Bash on Windows, ensure `~/.bash_profile` loads `.bashrc`:

```bash
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
```

---

### 3. Enable automatic loading of the OneDark prompt

Add the following to the **end** of your `~/.bashrc`:

```bash
# OneDark prompt
if [ -f "$HOME/onedark/onedark.sh" ]; then
  source "$HOME/onedark/onedark.sh"
fi
```

---

### 4. Reload the shell

Apply the changes without restarting the terminal:

```bash
source ~/.bashrc
```

Or simply open a new terminal window.

---

### 5. (Optional) Manual activation

You can enable the theme manually in the current shell at any time:

```bash
source ~/onedark/onedark.sh
```

---

## ℹ️ Notes

- Do not run `onedark.sh` as a program (`./onedark.sh`)
- Do not add execute permissions (`chmod +x`)
- Prompt configuration must be sourced to affect the current shell

------------------------------------------------------------------------

## ⚡ Manual overrides

-   Force truecolor profile:

    ``` bash
    od-true
    ```

-   Force 256-color profile:

    ``` bash
    od-256
    ```

------------------------------------------------------------------------

## ✅ Notes

-   **Do not add shebang** (`#!/usr/bin/env bash`) to `onedark.sh`,
    since it is sourced.
-   Make sure your terminal supports truecolor (`echo $COLORTERM` should
    contain `truecolor` or `24bit`).

------------------------------------------------------------------------

Enjoy your One Dark themed terminal ✨
