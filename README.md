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

1.  Copy `onedark.sh` and `onedark` into `~/bin/`:

    ``` bash
    mkdir -p ~/bin
    cp onedark.sh ~/bin/
    cp onedark ~/bin/
    chmod +x ~/bin/onedark
    ```

2.  Add this line to your `~/.bashrc`:

    ``` bash
    source ~/bin/onedark
    ```

3.  Reload shell:

    ``` bash
    source ~/.bashrc
    ```

4.  Or run manually anytime:

    ``` bash
    ~/bin/onedark
    ```

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
