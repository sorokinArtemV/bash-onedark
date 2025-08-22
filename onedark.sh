# One Dark prompt + LS_COLORS (auto: truecolor → else 256)

# ----- helpers -----
_is_interactive() { case "$-" in *i*) return 0;; *) return 1;; esac; }

# ----- TRUECOLOR (24-bit) -----
__od_set_truecolor() {
  # Prompt colors (for PS1)
  RESET='\[\e[0m\]'
  GRN='\[\e[38;2;152;195;121m\]'    # #98C379
  BLU='\[\e[38;2;97;175;239m\]'     # #61AFEF
  CYA='\[\e[38;2;86;182;194m\]'     # #56B6C2
  DIM='\[\e[38;2;92;99;112m\]'      # #5C6370
  YLW='\[\e[38;2;229;192;123m\]'    # #E5C07B
  RED='\[\e[38;2;224;108;117m\]'    # #E06C75

  # Git adornment (safe if git not present)
  git_prompt() {
    local b; b="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" || return
    local dirty=""; git diff --quiet --ignore-submodules 2>/dev/null || dirty="*"
    printf " %s⎇ %s%s" "${DIM}" "${b}" "${dirty}"
  }
  prompt_symbol() { [[ $EUID -eq 0 ]] && printf "#" || printf "$"; }

  # PS1 only for interactive shells
  if _is_interactive; then
    PS1="${RED}\u${CYA}:${BLU}\w${CYA}\$(git_prompt) ${YLW}\$(prompt_symbol) ${RESET}"
    export PROMPT_DIRTRIM=3
  fi

  # ---- LS_COLORS parts (comments are OUTSIDE strings) ----
  LSC_di='di=01;38;2;152;195;121'
  LSC_ln='ln=01;38;2;86;182;194'
  LSC_ex='ex=01;38;2;198;120;221'

  LSC_so='so=38;2;180;180;140'
  LSC_pi='pi=38;2;180;180;140'
  LSC_bd='bd=01;38;2;224;108;117'
  LSC_cd='cd=01;38;2;224;108;117'
  LSC_su='su=01;38;2;224;108;117'
  LSC_sg='sg=01;38;2;224;108;117'
  LSC_tw='tw=01;38;2;224;108;117'
  LSC_ow='ow=01;38;2;224;108;117'

  # Archives → ORANGE #D19A66
  LSC_tar='*.tar=38;2;209;154;102'
  LSC_gz='*.gz=38;2;209;154;102'
  LSC_bz2='*.bz2=38;2;209;154;102'
  LSC_xz='*.xz=38;2;209;154;102'
  LSC_zip='*.zip=38;2;209;154;102'
  LSC_7z='*.7z=38;2;209;154;102'

  # Images → YELLOW #E5C07B
  LSC_jpg='*.jpg=38;2;229;192;123'
  LSC_jpeg='*.jpeg=38;2;229;192;123'
  LSC_png='*.png=38;2;229;192;123'
  LSC_gif='*.gif=38;2;229;192;123'
  LSC_webp='*.webp=38;2;229;192;123'
  LSC_svg='*.svg=38;2;229;192;123'

  # Media (audio/video) → CYAN #56B6C2
  LSC_mp3='*.mp3=38;2;86;182;194'
  LSC_flac='*.flac=38;2;86;182;194'
  LSC_wav='*.wav=38;2;86;182;194'
  LSC_mp4='*.mp4=38;2;86;182;194'
  LSC_mkv='*.mkv=38;2;86;182;194'
  LSC_mov='*.mov=38;2;86;182;194'

  # Scripts → GRAY #ABB2BF
  LSC_sh='*.sh=38;2;171;178;191'
  LSC_bash='*.bash=38;2;171;178;191'
  LSC_zsh='*.zsh=38;2;171;178;191'
  LSC_ps1='*.ps1=38;2;171;178;191'

  # Code → BLUE #61AFEF
  LSC_py='*.py=38;2;97;175;239'
  LSC_rb='*.rb=38;2;97;175;239'
  LSC_pl='*.pl=38;2;97;175;239'
  LSC_java='*.java=38;2;97;175;239'
  LSC_kt='*.kt=38;2;97;175;239'
  LSC_scala='*.scala=38;2;97;175;239'
  LSC_c='*.c=38;2;97;175;239'
  LSC_h='*.h=38;2;97;175;239'
  LSC_cpp='*.cpp=38;2;97;175;239'
  LSC_hpp='*.hpp=38;2;97;175;239'
  LSC_cs='*.cs=38;2;97;175;239'
  LSC_go='*.go=38;2;97;175;239'
  LSC_rs='*.rs=38;2;97;175;239'

  # JS / TS → YELLOW #E5C07B
  LSC_js='*.js=38;2;229;192;123'
  LSC_ts='*.ts=38;2;229;192;123'
  LSC_tsx='*.tsx=38;2;229;192;123'
  LSC_jsx='*.jsx=38;2;229;192;123'

  # Data / Config → ORANGE #D19A66
  LSC_json='*.json=38;2;209;154;102'
  LSC_yml='*.yml=38;2;209;154;102'
  LSC_yaml='*.yaml=38;2;209;154;102'
  LSC_toml='*.toml=38;2;209;154;102'
  LSC_xml='*.xml=38;2;209;154;102'

  # Text → GRAY #ABB2BF
  LSC_md='*.md=38;2;171;178;191'
  LSC_txt='*.txt=38;2;171;178;191'
  LSC_log='*.log=38;2;171;178;191'

  # SQL / DB → YELLOW #E5C07B
  LSC_sql='*.sql=38;2;229;192;123'
  LSC_db='*.db=38;2;229;192;123'
  LSC_sqlite='*.sqlite=38;2;229;192;123'

  LS_COLORS="$LSC_di:$LSC_ln:$LSC_ex:$LSC_so:$LSC_pi:$LSC_bd:$LSC_cd:$LSC_su:$LSC_sg:$LSC_tw:$LSC_ow:\
$LSC_tar:$LSC_gz:$LSC_bz2:$LSC_xz:$LSC_zip:$LSC_7z:\
$LSC_jpg:$LSC_jpeg:$LSC_png:$LSC_gif:$LSC_webp:$LSC_svg:\
$LSC_mp3:$LSC_flac:$LSC_wav:$LSC_mp4:$LSC_mkv:$LSC_mov:\
$LSC_sh:$LSC_bash:$LSC_zsh:$LSC_ps1:\
$LSC_py:$LSC_rb:$LSC_pl:$LSC_java:$LSC_kt:$LSC_scala:$LSC_c:$LSC_h:$LSC_cpp:$LSC_hpp:$LSC_cs:$LSC_go:$LSC_rs:\
$LSC_js:$LSC_ts:$LSC_tsx:$LSC_jsx:\
$LSC_json:$LSC_yml:$LSC_yaml:$LSC_toml:$LSC_xml:\
$LSC_md:$LSC_txt:$LSC_log:\
$LSC_sql:$LSC_db:$LSC_sqlite"
  export LS_COLORS

  alias ls='ls --color=auto'

  # less/grep (RGB caps)
  export GREP_COLORS='ms=01;38;2;224;108;117:mc=01;38;2;224;108;117:sl=:cx=:fn=38;2;171;178;191:ln=38;2;92;99;112:bn=38;2;92;99;112:se=38;2;171;178;191'
  export LESS='-R'
  export LESS_TERMCAP_mb=$'\e[01;38;2;224;108;117m'
  export LESS_TERMCAP_md=$'\e[01;38;2;198;120;221m'
  export LESS_TERMCAP_me=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_so=$'\e[48;2;92;99;112;38;2;171;178;191m'
  export LESS_TERMCAP_ue=$'\e[0m'
  export LESS_TERMCAP_us=$'\e[01;38;2;97;175;239m'
}

# ----- 256-COLOR fallback -----
__od_set_256() {
  if _is_interactive; then
    RESET='\[\e[0m\]'; GRN='\[\e[38;5;114m\]'; BLU='\[\e[38;5;39m\]'; CYA='\[\e[38;5;44m\]'; YLW='\[\e[38;5;179m\]'
    git_prompt() { local b; b="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" || return; local d=""; git diff --quiet --ignore-submodules 2>/dev/null || d="*"; printf " ⎇ %s%s" "$b" "$d"; }
    prompt_symbol() { [[ $EUID -eq 0 ]] && printf "#" || printf "$"; }
    PS1="${GRN}\u ${BLU}\w${CYA}\$(git_prompt) ${YLW}\$(prompt_symbol) ${RESET}"
    export PROMPT_DIRTRIM=3
  fi

  export LS_COLORS="di=01;38;5;114:ln=01;38;5;44:ex=01;38;5;171:so=38;5;180:pi=38;5;180:bd=01;38;5;203:cd=01;38;5;203:su=01;38;5;203:sg=01;38;5;203:tw=01;38;5;203:ow=01;38;5;203:*.tar=38;5;173:*.gz=38;5;173:*.bz2=38;5;173:*.xz=38;5;173:*.zip=38;5;173:*.7z=38;5;173:*.jpg=38;5;179:*.jpeg=38;5;179:*.png=38;5;179:*.gif=38;5;179:*.webp=38;5;179:*.svg=38;5;179:*.mp3=38;5;44:*.flac=38;5;44:*.wav=38;5;44:*.mp4=38;5;44:*.mkv=38;5;44:*.mov=38;5;44:*.sh=38;5;110:*.bash=38;5;110:*.zsh=38;5;110:*.ps1=38;5;110:*.py=38;5;39:*.rb=38;5;39:*.pl=38;5;39:*.js=38;5;179:*.ts=38;5;179:*.tsx=38;5;179:*.jsx=38;5;179:*.java=38;5;39:*.kt=38;5;39:*.scala=38;5;39:*.c=38;5;39:*.h=38;5;39:*.cpp=38;5;39:*.hpp=38;5;39:*.cs=38;5;39:*.go=38;5;39:*.rs=38;5;39:*.json=38;5;173:*.yml=38;5;173:*.yaml=38;5;173:*.toml=38;5;173:*.xml=38;5;173:*.md=38;5;145:*.txt=38;5;145:*.log=38;5;145:*.sql=38;5;179:*.db=38;5;179:*.sqlite=38;5;179"
  alias ls='ls --color=auto'
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

# ----- Auto-apply on load -----
onedark
