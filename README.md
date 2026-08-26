# 🎨 One Dark — Shell Prompt & File Colors

A **One Dark** color scheme for your shell: a clean prompt with a git branch
indicator, plus consistent coloring for `ls`, `grep`, and `less`.

Two flavors are included:

| Shell / OS            | File          | Notes                                            |
|-----------------------|---------------|--------------------------------------------------|
| **Bash** (Linux)      | `onedark.sh`  | Original version. Auto-applies on shell startup. |
| **zsh** (macOS)       | `onedark.zsh` | For macOS default shell. Applied by command.     |

Both support **truecolor (24-bit)** with an automatic **256-color** fallback.

---

## ✨ Features

- One Dark colors for the prompt: `user : path ⎇ branch $`
- Git branch name with a `*` marker when the working tree is dirty
- Auto-detects **truecolor** vs **256-color** terminals
- Colored `ls`, with distinct colors for:
  - Directories, symlinks, executables
  - Archives, images, audio/video, scripts
  - Source code (C, Go, Rust, Java, Python, …)
  - Config/data files (JSON, YAML, XML, SQL, …)
- Colored `grep` matches and `less` output

Check your terminal supports truecolor first:

```bash
echo $COLORTERM   # should contain "truecolor" or "24bit"
```

---

## 🐧 Bash (Linux)

The Bash version is **sourced** into your shell and applies automatically.

### 1. Install

```bash
mkdir -p ~/onedark
cp onedark.sh ~/onedark/onedark.sh
```

> `onedark.sh` is meant to be **sourced**, not executed.
> Don't add a shebang and don't `chmod +x` it.

### 2. Enable on startup

Add to the **end** of your `~/.bashrc`:

```bash
# One Dark prompt
if [ -f "$HOME/onedark/onedark.sh" ]; then
  source "$HOME/onedark/onedark.sh"
fi
```

> **Git Bash on Windows only:** make sure `~/.bash_profile` loads `.bashrc`:
> ```bash
> [ -f ~/.bashrc ] && source ~/.bashrc
> ```

### 3. Reload

```bash
source ~/.bashrc   # or open a new terminal
```

---

## 🍎 macOS (zsh)

On macOS the default login shell is **zsh** (used by Terminal.app, iTerm2,
Ghostty, …), and the system `ls` is **BSD ls** — it doesn't understand Bash
prompt escapes, `--color=auto`, or `LS_COLORS`. Use **`onedark.zsh`** here.

What's different from the Bash version:

- Prompt rewritten with zsh escapes (`%n`, `%3~`, `%F{#hex}`) — same look.
- `ls` coloring auto-detects **GNU coreutils**: if `gls` is installed it uses
  the full per-extension `LS_COLORS` palette; otherwise it falls back to BSD
  `ls -G` + `LSCOLORS` (8 base colors, no per-extension coloring).
- Applied **by command**, not automatically.

### 1. Install

```bash
mkdir -p ~/.config/onedark
cp onedark.zsh ~/.config/onedark/onedark.zsh
```

### 2. Register the commands

Add to the **end** of your `~/.zshrc`. This only *defines* the commands — it
does **not** apply the theme on startup:

```bash
# One Dark theme (manual): defines `onedark` / `od-true` / `od-256`.
[ -f "$HOME/.config/onedark/onedark.zsh" ] && source "$HOME/.config/onedark/onedark.zsh"
```

### 3. Enable

```bash
source ~/.zshrc   # or open a new terminal
onedark           # turn the theme on
```

> **Recommended: install GNU coreutils.** With `gls` present the theme uses
> **exact RGB colors**, so directories (and everything else) look identical in
> every terminal — Ghostty, Terminal.app, iTerm2. Without it, macOS `ls` can
> only use the 8 ANSI palette colors, which each terminal theme remaps
> differently (that's why folder colors can look off in some terminals). The
> theme detects `gls` automatically:
> ```bash
> brew install coreutils
> ```

---

## ⚡ Commands

Available after the theme is loaded (both flavors):

| Command   | Effect                                                  |
|-----------|---------------------------------------------------------|
| `onedark` | Apply the theme — truecolor if supported, else 256-color |
| `od-true` | Force the 24-bit truecolor profile                      |
| `od-256`  | Force the 256-color fallback profile                    |
| `od-off`  | Restore the default prompt and remove the `ls` alias (zsh) |

---

## 🎨 Palette

| Role                | Hex        |
|---------------------|------------|
| Green (dirs)        | `#98C379`  |
| Blue (path/code)    | `#61AFEF`  |
| Cyan (links/media)  | `#56B6C2`  |
| Yellow (js/ts/data) | `#E5C07B`  |
| Orange (archives)   | `#D19A66`  |
| Red (user/errors)   | `#E06C75`  |
| Purple (exec)       | `#C678DD`  |
| Gray (text/dim)     | `#5C6370`  |

---

Enjoy your One Dark themed terminal ✨
