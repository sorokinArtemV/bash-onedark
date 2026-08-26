# ============================================================================
#  One Dark — prompt + file/grep/less colors for zsh (macOS-friendly)
# ============================================================================
#  Manual by design: sourcing this file only DEFINES commands. Nothing is
#  applied until you run one of:
#
#     onedark   -> apply (truecolor if the terminal supports it, else 256)
#     od-true   -> force 24-bit truecolor
#     od-256    -> force 256-color fallback
#     od-off    -> restore the default prompt & remove the ls alias
#
#  File colors use EXACT RGB (truecolor) so directories look identical in
#  Ghostty, Terminal.app, iTerm2, etc. — independent of the terminal's theme.
#  This requires GNU coreutils `gls` (brew install coreutils). If it is not
#  found we fall back to BSD `ls -G` + LSCOLORS, whose colors are limited to
#  the 8 ANSI palette entries and therefore vary between terminal themes.
# ============================================================================

# ----- One Dark palette (hex, no '#') --------------------------------------
_OD_GREEN=98C379   # directories
_OD_BLUE=61AFEF    # path, source code
_OD_CYAN=56B6C2    # symlinks, media, ':' separator
_OD_YELLOW=E5C07B  # prompt symbol, js/ts, images, sql
_OD_ORANGE=D19A66  # archives, data/config
_OD_RED=E06C75     # username, device/danger files
_OD_PURPLE=C678DD  # executables
_OD_GRAY=ABB2BF    # scripts, text
_OD_DIM=5C6370     # git branch, dimmed

# rgb 'RRGGBB' -> 'r;g;b'   (portable hex->dec, no $(( )) base tricks)
_od_rgb() {
  local h=$1
  printf '%d;%d;%d' "0x${h[1,2]}" "0x${h[3,4]}" "0x${h[5,6]}"
}

# ----- ls / grep / less colors ---------------------------------------------
_od_apply_filecolors() {
  local g b c y o r p a d
  g=$(_od_rgb $_OD_GREEN);  b=$(_od_rgb $_OD_BLUE);   c=$(_od_rgb $_OD_CYAN)
  y=$(_od_rgb $_OD_YELLOW); o=$(_od_rgb $_OD_ORANGE); r=$(_od_rgb $_OD_RED)
  p=$(_od_rgb $_OD_PURPLE); a=$(_od_rgb $_OD_GRAY);   d=$(_od_rgb $_OD_DIM)

  if command -v gls >/dev/null 2>&1; then
    # Exact truecolor, per file type / extension.
    export LS_COLORS="\
di=01;38;2;${g}:ln=01;38;2;${c}:ex=01;38;2;${p}:\
so=38;2;${c}:pi=38;2;${c}:bd=01;38;2;${r}:cd=01;38;2;${r}:\
su=01;38;2;${r}:sg=01;38;2;${r}:tw=01;38;2;${g}:ow=01;38;2;${g}:\
*.tar=38;2;${o}:*.tgz=38;2;${o}:*.gz=38;2;${o}:*.bz2=38;2;${o}:*.xz=38;2;${o}:*.zst=38;2;${o}:*.zip=38;2;${o}:*.7z=38;2;${o}:*.rar=38;2;${o}:\
*.jpg=38;2;${y}:*.jpeg=38;2;${y}:*.png=38;2;${y}:*.gif=38;2;${y}:*.webp=38;2;${y}:*.svg=38;2;${y}:*.heic=38;2;${y}:\
*.mp3=38;2;${c}:*.flac=38;2;${c}:*.wav=38;2;${c}:*.mp4=38;2;${c}:*.mkv=38;2;${c}:*.mov=38;2;${c}:*.webm=38;2;${c}:\
*.sh=38;2;${a}:*.bash=38;2;${a}:*.zsh=38;2;${a}:*.fish=38;2;${a}:*.ps1=38;2;${a}:\
*.py=38;2;${b}:*.rb=38;2;${b}:*.pl=38;2;${b}:*.java=38;2;${b}:*.kt=38;2;${b}:*.scala=38;2;${b}:*.c=38;2;${b}:*.h=38;2;${b}:*.cpp=38;2;${b}:*.hpp=38;2;${b}:*.cc=38;2;${b}:*.cs=38;2;${b}:*.go=38;2;${b}:*.rs=38;2;${b}:*.swift=38;2;${b}:\
*.js=38;2;${y}:*.mjs=38;2;${y}:*.cjs=38;2;${y}:*.ts=38;2;${y}:*.tsx=38;2;${y}:*.jsx=38;2;${y}:\
*.json=38;2;${o}:*.yml=38;2;${o}:*.yaml=38;2;${o}:*.toml=38;2;${o}:*.xml=38;2;${o}:*.ini=38;2;${o}:*.env=38;2;${o}:\
*.md=38;2;${a}:*.txt=38;2;${a}:*.log=38;2;${a}:*.rst=38;2;${a}:\
*.sql=38;2;${y}:*.db=38;2;${y}:*.sqlite=38;2;${y}"
    alias ls='gls --color=auto --group-directories-first'
  else
    # BSD ls: only 8 base colors, remapped by the terminal theme.
    export CLICOLOR=1
    export LSCOLORS="CxGxdxdxFxBxBxBxBxBxBx"
    alias ls='ls -G'
  fi

  # grep matches (BSD grep on macOS honors GREP_COLORS)
  export GREP_COLORS="ms=01;38;2;${r}:mc=01;38;2;${r}:sl=:cx=:fn=38;2;${a}:ln=38;2;${d}:bn=38;2;${d}:se=38;2;${a}"

  # less (man pages, etc.)
  export LESS='-R'
  export LESS_TERMCAP_mb=$'\e[01;38;2;'"${r}"'m'
  export LESS_TERMCAP_md=$'\e[01;38;2;'"${p}"'m'
  export LESS_TERMCAP_me=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_so=$'\e[48;2;'"${d}"';38;2;'"${a}"'m'
  export LESS_TERMCAP_ue=$'\e[0m'
  export LESS_TERMCAP_us=$'\e[01;38;2;'"${b}"'m'
}

# ----- git branch adornment (rendered via prompt_subst) --------------------
_od_git() {
  command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  local ref
  ref=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null) \
    || ref=$(command git rev-parse --short HEAD 2>/dev/null) \
    || return
  local dirty=''
  command git diff --quiet --ignore-submodules HEAD 2>/dev/null || dirty='*'
  print -rn -- " %F{#${_OD_DIM}}⎇ ${ref}${dirty}%f"
}

# ----- prompts --------------------------------------------------------------
_od_prompt_true() {
  setopt prompt_subst
  PROMPT='%F{#'"${_OD_RED}"'}%n%F{#'"${_OD_CYAN}"'}:%F{#'"${_OD_BLUE}"'}%3~%F{#'"${_OD_CYAN}"'}$(_od_git) %F{#'"${_OD_YELLOW}"'}%(!.#.$)%f '
}

_od_prompt_256() {
  setopt prompt_subst
  PROMPT='%F{114}%n%F{44}:%F{39}%3~%F{44}$(_od_git) %F{179}%(!.#.$)%f '
}

# ----- public commands ------------------------------------------------------
od-true() { _od_apply_filecolors; _od_prompt_true; }
od-256()  { _od_apply_filecolors; _od_prompt_256; }

onedark() {
  if [[ "$COLORTERM" == *(truecolor|24bit)* ]]; then
    od-true
  else
    od-256
  fi
}

od-off() {
  unalias ls 2>/dev/null
  unset LS_COLORS LSCOLORS
  PROMPT='%n@%m %1~ %# '
  print -r -- "One Dark disabled for this shell."
}

# NOTE: intentionally not applied on load. Run `onedark` to enable.
