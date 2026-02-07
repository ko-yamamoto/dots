UNAME=`uname`

# PATH の重複を防ぐ
typeset -U path PATH

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history         # コマンド履歴ファイルを共有する


# キーバインドをEmacsに
bindkey -e
# キーバインドをviに
# bindkey -v
# TERM設定 Emacsからshellを実行するときの表示の乱れを防ぐ
TERM=xterm-256color
[[ $TERM = "eterm-color" ]] && TERM=xterm-256color

# 履歴検索のショートカット
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# 共通のPATH
export PATH=$HOME/bin:$PATH

# 環境変数LANG
# export LANG=ja_JP.utf8
export LANG=ja_JP.UTF-8

# プロンプトをカラー表示
autoload colors && colors


# Emacs Tramp 用プロンプト
# set terminal title including current directory
case "${TERM}" in
# for emacs tramp setting
dumb | emacs)
    # for tramp to not hang, need the following. cf:
    # http://www.emacswiki.org/emacs/TrampMode
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PROMPT="%n@%~%(!.#.$)"
    RPROMPT=""
    # PS1='%(?..[%?])%!:%~%# '
    PS1='$ '

    ;;
esac


# lsカラー表示
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# 補完をカラーに
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
alias ls="ls -G"


# 補完パターン 大文字小文字区別なしなど
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# プロセス補完でメニュー内にカーソル移動
zstyle ':completion:*:processes' menu yes select=2

# タイトルの設定
case "${TERM}" in
    kterm*|xterm*)
        precmd() {
            echo -ne "\033]0;${PWD##*/}\007"
        }
        ;;
esac

# C-^で上へcd
function cdup() {
    echo
    cd ..
    zle reset-prompt
}
zle -N cdup
bindkey '^^' cdup

# 複数ファイル一括リネーム
autoload -Uz zmv
alias zmv='noglob zmv -W'

# 補完用ファイル置き場追加
fpath=(~/.zsh/functions(N-/) ${fpath})

# 最後の"/"を削除しない
setopt noautoremoveslash

# 自動cd
setopt auto_cd

# cd一覧表示
setopt auto_pushd

# cdしたらls
function chpwd(){ls -G}

# コマンド入力ミス指摘
setopt correct

# 補完を詰めて表示
setopt list_packed

# Beepオフ
setopt nolistbeep

# コマンド予測オン
# autoload predict-on
# predict-on

# 日本語のファイル名表示
setopt print_eight_bit

# 補完候補をカーソルで選択できる
zstyle ':completion:*:default' menu select=1

# C-w は一つ上のパスまでを消す
export WORDCHARS='*?_.[]~&;!#$%^(){}<>'

# エイリアス
setopt complete_aliases



alias -g L='| less'
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'


alias screen='screen -xRU'

alias diff='diff -u'

# いろいろな拡張しを実行
function multi-run() {
    case $1 in
        *.lisp|*.li) ccl --load $1 --eval '(quit)';; # ccl を使って lisp を ./hoge.lisp で起動する
        *.hs) runghc $1;; # haskell の main 関数実行
    esac
}
alias -s {lisp,li,hs}=multi-run

alias gvim='gvim --remote-silent'
alias gv='gvim --remote-silent'

alias ec='emacsclient -n'

alias g='git'


# 指定したコマンドを指定した時間ごとに実行
function timer() {
    if [ $# -lt 2 ]; then
        echo "Needs 2 args." 1>&2
        echo "arg1 -> command, arg2 -> seconds" 1>&2
    else
        while true; do  $2 $3 $4 $5 $6 $7 ; echo ""; sleep $1 ; done
    fi
}


# Mineファイル読み込み
# オレオレ設定はこっちに
[ -f ~/.zshrc.mac ] && source ~/.zshrc.mac
[ -f ~/.zshrc.cyg ] && source ~/.zshrc.cyg
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine


# plugins######################################################

# zsh-completions
# cd ~/bin
# git clone https://github.com/zsh-users/zsh-completions.git
if [ -d ~/bin/zsh-completions ]; then
    fpath=($HOME/bin/zsh-completions/src $fpath)
fi
autoload -zU compinit && compinit

compdef _git g='git' # g でも git として補完

# zsh-defer: プラグインの遅延ロード
# git clone https://github.com/romkatv/zsh-defer.git ~/.local/share/zsh-defer
source "$HOME/.local/share/zsh-defer/zsh-defer.plugin.zsh"

# zsh-abbr
# brew install olets/tap/zsh-abbr
zsh-defer source /opt/homebrew/share/zsh-abbr/zsh-abbr.zsh
# abbr b="brew"
# abbr d="docker"
# abbr dc="docker compose"
# abbr di="git diff"
# abbr e="exit"
# abbr g="git"
# abbr gd="git diff --cached"
# abbr ggrep="git grep"
# abbr gl="git log"
# abbr gr="git restore"
# abbr gs="git switch"
# abbr l="git log"
# abbr p="git pull"
# abbr pick="git cherry-pick"
# abbr pop="git stash pop"
# abbr s="git status -sb"
# abbr st="git stash"
# abbr kx="kubectx"


# fzf
# brew install fzf
zsh-defer -c 'source <(fzf --zsh)'

zsh-defer -c "bindkey '^[t' fzf-file-widget"

# cdrの履歴からディレクトリを移動する
fzf-cdr(){
    local dir=$(cdr -l | fzf --preview 'f(){ zsh -c "exa -h --long --icons --classify --git --no-permissions --no-user --no-filesize --git-ignore --sort modified --reverse --tree --level 2 $1" }; f {2}')
    if [ -n "$dir" ]; then
        dir=$(echo $dir | awk '{ print $1 }')
        BUFFER="cdr ${dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-cdr
bindkey '^[r' fzf-cdr

# require unbuffer
# brew install expect
fzf-add() {
    local selected
    selected=$(unbuffer git status -s | fzf -m --ansi --preview-window="bottom,75%" --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
    if [[ -n "$selected" ]]; then
        selected=$(tr '\n' ' ' <<< "$selected")
        selected="${selected%"${selected##*[![:space:]]}"}" # 行末のスペースを削除する
        git add $selected
        echo "Completed: git add $selected"
    fi
}
zle -N fzf-add
bindkey '^[a' fzf-add

# ブランチを選択して switch する
fzf-branch() {
  target_br=$(
    git branch -a |
      fzf --exit-0 --info=hidden --no-multi --preview-window="bottom,65%" --prompt="CHECKOUT BRANCH > " --preview="echo {} | tr -d ' *' | xargs git lgn --color=always" |
      head -n 1 |
      perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
  )
  if [ -n "$target_br" ]; then
    BUFFER="git switch $target_br"
    zle accept-line
  fi
}
zle -N fzf-branch
bindkey '^[gb' fzf-branch

# PR 選択して switch する
# brew install gh
fzf-pullreq() {
  local pullreq=$(CLICOLOR_FORCE=1 GH_FORCE_TTY=100% gh pr list | tail -n+4 | fzf --preview-window="bottom,85%" --ansi --bind "change:reload:CLICOLOR_FORCE=1 GH_FORCE_TTY=100% gh pr list -S {q} | tail -n+4 || true" --disabled --preview "CLICOLOR_FORCE=1 GH_FORCE_TTY=100% gh pr view {1} | bat --color=always --style=grid --file-name a.md")
  if [ -n "$pullreq" ]; then
    pullreq=$(echo $pullreq | awk '{ print $1 }')
    BUFFER="gh pr checkout \"${pullreq}\""
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-pullreq
bindkey '^[gp' fzf-pullreq

# brew install zsh-autosuggestions
zsh-defer -c 'source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999999"'

# 戦闘力
function scouter() {
    sed -e '/^\s*$/d' -e '/^\s*#/d' ${ZDOTDIR:-$HOME}/.zshrc | wc -l
}



# starship.rs: キャッシュによる高速初期化
_starship_cache="${XDG_CACHE_HOME:-$HOME/.cache}/starship-init.zsh"
if [[ ! -f "$_starship_cache" ]] || [[ "$(command -v starship)" -nt "$_starship_cache" ]]; then
  mkdir -p "${_starship_cache:h}"
  starship init zsh > "$_starship_cache"
fi
source "$_starship_cache"
unset _starship_cache


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/kosei.yamamoto/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# bun completions
[ -s "/Users/kosei.yamamoto/.bun/_bun" ] && source "/Users/kosei.yamamoto/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias claude-mem='/Users/kosei.yamamoto/.bun/bin/bun "/Users/kosei.yamamoto/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'
