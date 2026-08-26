# One Dark prompt + ls colors for zsh on macOS
# Manual only: sourcing this file just DEFINES commands. Type `onedark` to apply.
#   onedark   -> auto: truecolor if COLORTERM says so, else 256
#   od-true   -> force 24-bit truecolor
#   od-256    -> force 256-color fallback
#
# ls colors: uses GNU `gls` + LS_COLORS (rich, per-extension) if coreutils is
# installed; otherwise falls back to BSD `ls -G` + LSCOLORS (8 base colors only).

# ----- shared: ls / grep / less coloring -----
__od_set_lscolors() {
  if command -v gls >/dev/null 2>&1; then
    # GNU coreutils available -> full One Dark palette, per extension
    export LS_COLORS="di=01;38;2;152;195;121:ln=01;38;2;86;182;194:ex=01;38;2;198;120;221:\
so=38;2;180;180;140:pi=38;2;180;180;140:bd=01;38;2;224;108;117:cd=01;38;2;224;108;117:\
su=01;38;2;224;108;117:sg=01;38;2;224;108;117:tw=01;38;2;224;108;117:ow=01;38;2;224;108;117:\
*.tar=38;2;209;154;102:*.gz=38;2;209;154;102:*.bz2=38;2;209;154;102:*.xz=38;2;209;154;102:*.zip=38;2;209;154;102:*.7z=38;2;209;154;102:\
*.jpg=38;2;229;192;123:*.jpeg=38;2;229;192;123:*.png=38;2;229;192;123:*.gif=38;2;229;192;123:*.webp=38;2;229;192;123:*.svg=38;2;229;192;123:\
*.mp3=38;2;86;182;194:*.flac=38;2;86;182;194:*.wav=38;2;86;182;194:*.mp4=38;2;86;182;194:*.mkv=38;2;86;182;194:*.mov=38;2;86;182;194:\
*.sh=38;2;171;178;191:*.bash=38;2;171;178;191:*.zsh=38;2;171;178;191:*.ps1=38;2;171;178;191:\
*.py=38;2;97;175;239:*.rb=38;2;97;175;239:*.pl=38;2;97;175;239:*.java=38;2;97;175;239:*.kt=38;2;97;175;239:*.scala=38;2;97;175;239:*.c=38;2;97;175;239:*.h=38;2;97;175;239:*.cpp=38;2;97;175;239:*.hpp=38;2;97;175;239:*.cs=38;2;97;175;239:*.go=38;2;97;175;239:*.rs=38;2;97;175;239:\
*.js=38;2;229;192;123:*.ts=38;2;229;192;123:*.tsx=38;2;229;192;123:*.jsx=38;2;229;192;123:\
*.json=38;2;209;154;102:*.yml=38;2;209;154;102:*.yaml=38;2;209;154;102:*.toml=38;2;209;154;102:*.xml=38;2;209;154;102:\
*.md=38;2;171;178;191:*.txt=38;2;171;178;191:*.log=38;2;171;178;191:\
*.sql=38;2;229;192;123:*.db=38;2;229;192;123:*.sqlite=38;2;229;192;123"
    alias ls='gls --color=auto'
  else
    # BSD ls -> LSCOLORS: 11 fg/bg pairs, only 8 base colors, no per-extension.
    # order: dir sym socket pipe exec block char setuid setgid dir+sticky dir+nosticky
    # C=bold green (dir) G=bold cyan (link) F=bold magenta (exec) d=brown B=bold red
    export LSCOLORS="CxGxdxdxFxBxBxBxBxBxBx"
    export CLICOLOR=1
    alias ls='ls -G'
  fi

  # grep (BSD grep on macOS honors GREP_COLORS)
  export GREP_COLORS='ms=01;38;2;224;108;117:mc=01;38;2;224;108;117:sl=:cx=:fn=38;2;171;178;191:ln=38;2;92;99;112:bn=38;2;92;99;112:se=38;2;171;178;191'

  # less (RGB caps)
  export LESS='-R'
  export LESS_TERMCAP_mb=$'\e[01;38;2;224;108;117m'
  export LESS_TERMCAP_md=$'\e[01;38;2;198;120;221m'
  export LESS_TERMCAP_me=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_so=$'\e[48;2;92;99;112;38;2;171;178;191m'
  export LESS_TERMCAP_ue=$'\e[0m'
  export LESS_TERMCAP_us=$'\e[01;38;2;97;175;239m'
}

# ----- git adornment (used by both prompt variants) -----
__od_git_prompt() {
  local b; b="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" || return
  local dirty=""; git diff --quiet --ignore-submodules 2>/dev/null || dirty="*"
  print -n " %F{#5C6370}⎇ ${b}${dirty}%f"
}

# ----- TRUECOLOR (24-bit) -----
__od_set_truecolor() {
  __od_set_lscolors
  setopt prompt_subst
  # user:cwd git-branch  $      (RED user, CYAN colon, BLUE cwd, YELLOW symbol)
  PROMPT='%F{#E06C75}%n%F{#56B6C2}:%F{#61AFEF}%3~%F{#56B6C2}$(__od_git_prompt) %F{#E5C07B}%(!.#.$)%f '
}

# ----- 256-COLOR fallback -----
__od_set_256() {
  __od_set_lscolors
  setopt prompt_subst
  PROMPT='%F{114}%n %F{39}%3~%F{44}$(__od_git_prompt) %F{179}%(!.#.$)%f '
}

# ----- Manual commands -----
onedark() {
  if [[ "$COLORTERM" == *truecolor* || "$COLORTERM" == *24bit* ]]; then
    __od_set_truecolor
  else
    __od_set_256
  fi
}
od-true() { __od_set_truecolor; }
od-256()  { __od_set_256; }

# NOTE: intentionally NOT applied on load. Run `onedark` to enable.
