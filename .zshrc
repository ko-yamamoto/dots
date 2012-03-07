# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

# ignore duplication command history list
setopt hist_ignore_dups
# share command history data
setopt share_history



# キーバインドをEmacsに
bindkey -e
# キーバインドをviに
# bindkey -v
# TERM設定 Emacsからshellを実行するときの表示の乱れを防ぐ
TERM=xterm-color
[[ $TERM = "eterm-color" ]] && TERM=xterm-color

# Emacs
# export EDITOR=emacsclient

# 履歴検索のショートカット
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# インクリメンタルな履歴検索
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


zstyle :compinstall filename '/Users/nishikawasasaki/.zshrc'

# 環境変数SHELL -> viewの時/opt/local以下のzshを観に行ってしまうため
# export SHELL=/usr/local/bin/zsh

# 環境変数LANG
# export LANG=ja_JP.UTF-8
export LANG=ja_JP.utf8

#Python
# alias python='python2.7'


# JAVA
JAVA_OPTS="-Dfile.encoding=UTF-8"
export JAVA_OPTS

# Scala
export SCALA_HOME=/usr/local/scala
export PATH=$PATH:$SCALA_HOME/bin
# -deprecationつけて起動
alias scala='scala -deprecation $1'


# Lift
# liftweb path vars
# export M2_HOME=/Applications/liftweb-1.0.1/apache-maven
# export M2=$M2_HOME/bin
# export MAVEN_OPTS="-noverify"
# export PATH=$M2:$PATH

# play Framework
export PLAY_HOME=/Users/nishikawasasaki/bin/play/play-1.1
export PATH=$PLAY_HOME:$PATH

# Android SDK
export ANDROID_SDK_HOME=/Users/nishikawasasaki/android/android-sdk-mac_x86
export PATH=$ANDROID_SDK_HOME:$PATH
export ANDROID_SWT=/Users/nishikawasasaki/android/android-sdk-mac_x86/tools/lib/x86_64


# git用の補完設定 -> bashcompinit有効でエラーが起きるためコメントアウト
# autoload bashcompinit
# bashcompinit
# source ~/.git-completion.bash

alias gs='git status -s'


# プロンプトをカラー表示
autoload colors && colors

# プロンプト表示設定
setopt prompt_subst
# PROMPT='%F{red}[%f%U%n%u%F{red}@%f%m%F{red}]%f%B%F{blue}%(!.#. >)%f%b '
PROMPT='%F{green}%n%f/%m%B%(?.%F{blue}%(!.#. :))%f.%F{red}%(!.#. :()%f)%b '
# RPROMPT='%{$fg[red]%}[%{$fg[blue]%}%~%{$fg[red]%}]%{$reset_color%}'
RPROMPT='%F{red}@%f%U%F{blue}%~%f%u'


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
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
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


# 補完設定
autoload -zU compinit
compinit

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


# エイリアス
setopt Complete_Aliases



alias -g L='| less'
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'


# vi
# export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
# alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
# alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
# alias gvim='env LANG=ja_JP.UTF-8 open -a /Applications/MacVim.app "$@"'

# emacs
# alias emacsclient='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n'
# alias emacs='/Applications/Emacs.app/Contents/MacOS/emacs'
# alias ec='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n'
# alias em='/Applications/Emacs.app/Contents/MacOS/emacs'
alias ec='emacsclient -n'

# ctags
# alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'


# 拡張があれば読み込み
## 移動したディレクトリを記録し、 ディレクトリ間を j で補完して移動
## https://github.com/joelthelion/autojump
[ -f ~/.autojump/etc/profile.d/autojump.zsh ] && source ~/.autojump/etc/profile.d/autojump.zsh

# Mineファイル読み込み
# オレオレ設定はこっちに
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
[ -f ~/.zshrc.mac ] && source ~/.zshrc.mac
[ -f ~/.zshrc.cyg ] && source ~/.zshrc.cyg


# 指定したコマンドを指定した時間ごとに実行
function timer() {
    if [ $# -lt 2 ]; then
        echo "Needs 2 args." 1>&2
        echo "arg1 -> command, arg2 -> seconds" 1>&2
    else
        while true; do  $2 $3 $4 $5 $6 $7 ; echo ""; sleep $1 ; done
    fi
}




## 以下 zsh vi モード


# #zshプロンプトにモード表示####################################
# function zle-line-init zle-keymap-select {
#   case $KEYMAP in
#     vicmd)
#     PROMPT="%{$fg[red]%}[%{$reset_color%}%n/%{$fg_bold[red]%}NOR%{$reset_color%}%{$fg[red]%}]%#%{$reset_color%} "
#     # ssh接続時はホスト名表示
#     [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#         PROMPT="%{$fg[red]%}[%{$reset_color%}%n/%{$fg_bold[red]%}NOR%{$reset_color%}%{$fg[red]%}]:${HOST%%.*}%#%{$reset_color%} "
#     ;;

#     main|viins)
#     PROMPT="%{$fg[red]%}[%{$reset_color%}%n/%{$fg_bold[cyan]%}INS%{$reset_color%}%{$fg[red]%}]%#%{$reset_color%} "

#     # ssh接続時はホスト名表示
#     [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#         PROMPT="%{$fg[red]%}[%{$reset_color%}%n/%{$fg_bold[cyan]%}INS%{$reset_color%}%{$fg[red]%}]:${HOST%%.*}%#%{$reset_color%} "
#     ;;

#   esac
#   zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select



# #zshでvisual mode####################################
# bindkey -a 'v' vi-v
# zle -N vi-v
# function vi-v() {
# 	VI_VIS_MODE=0
# 	bindkey -a 'v' vi-vis-reset
# 	bindkey -a '' vi-c-v
# 	bindkey -a 'V' vi-V
# 	MARK=$CURSOR
# 	zle vi-vis-mode
# }
# #
# bindkey -a '' vi-c-v
# zle -N vi-c-v
# function vi-c-v() {
# 	VI_VIS_MODE=1
# 	bindkey -a 'v' vi-v
# 	bindkey -a '' vi-vis-reset
# 	bindkey -a 'V' vi-V
# 	MARK=$CURSOR
# 	zle vi-vis-mode
# }
# #
# bindkey -a 'V' vi-V
# zle -N vi-V
# function vi-V() {
# 	VI_VIS_MODE=2
# 	bindkey -a 'v' vi-v
# 	bindkey -a '' vi-c-v
# 	bindkey -a 'V' vi-vis-reset
# 	CURSOR_V_START=$CURSOR
# 	zle vi-end-of-line
# 	MARK=$(($CURSOR - 1))
# 	zle vi-digit-or-beginning-of-line
# 	zle vi-vis-mode
# }
# #
# ##########################################################
# #
# zle -N vi-vis-mode
# function vi-vis-mode() {
# 	zle exchange-point-and-mark
# 	VI_VIS_CURSOR_MARK=1
# #移動系コマンド
# 	bindkey -a 'f' vi-vis-find
# 	bindkey -a 'F' vi-vis-Find
# 	bindkey -a 't' vi-vis-tskip
# 	bindkey -a 'T' vi-vis-Tskip
# 	bindkey -a ';' vi-vis-repeatfind
# 	bindkey -a ',' vi-vis-repeatfindrev
# 	bindkey -a 'w' vi-vis-word
# 	bindkey -a 'W' vi-vis-Word
# 	bindkey -a 'e' vi-vis-end
# 	bindkey -a 'E' vi-vis-End
# 	bindkey -a 'b' vi-vis-back
# 	bindkey -a 'B' vi-vis-Back
# 	bindkey -a 'h' vi-vis-hidari
# 	bindkey -a 'l' vi-vis-leftdenai
# 	bindkey -a '%' vi-vis-percent
# 	bindkey -a '^' vi-vis-hat
# 	bindkey -a '0' vi-vis-zero
# 	bindkey -a '$' vi-vis-doller
# #削除、コピーetc
# 	bindkey -a 'd' vi-vis-delete
# 	bindkey -a 'D' vi-vis-Delete
# 	bindkey -a 'x' vi-vis-delete
# 	bindkey -a 'X' vi-vis-Delete
# 	bindkey -a 'y' vi-vis-yank
# 	bindkey -a 'Y' vi-vis-Yank
# 	bindkey -a 'c' vi-vis-change
# 	bindkey -a 'C' vi-vis-Change
# 	bindkey -a 'r' vi-vis-change
# 	bindkey -a 'R' vi-vis-Change
# 	bindkey -a 'p' vi-vis-paste
# 	bindkey -a 'P' vi-vis-Paste
# 	bindkey -a 'o' vi-vis-open
# 	bindkey -a 'O' vi-vis-open
# #インサートへ移行
# 	bindkey -a 'a' vi-vis-add
# 	bindkey -a 'A' vi-vis-Add
# 	bindkey -a 'i' vi-vis-insert
# 	bindkey -a 'I' vi-vis-Insert
# #その他
# 	bindkey -a 'u' vi-vis-undo
# 	bindkey -a '.' vi-vis-repeat
# 	bindkey -a '' vi-vis-reset
# 	bindkey -a 's' vi-vis-reset
# 	bindkey -a 'S' vi-vis-reset
# }
# zle -N vi-vis-key-reset
# function vi-vis-key-reset() {
# 	bindkey -M vicmd 'f' vi-find-next-char
# 	bindkey -M vicmd 'F' vi-find-prev-char
# 	bindkey -M vicmd 't' vi-find-next-char-skip
# 	bindkey -M vicmd 'T' vi-find-prev-char-skip
# 	bindkey -M vicmd ';' vi-repeat-find
# 	bindkey -M vicmd ',' vi-rev-repeat-find
# 	bindkey -M vicmd 'w' vi-forward-word
# 	bindkey -M vicmd 'W' vi-forward-blank-word
# 	bindkey -M vicmd 'e' vi-forward-word-end
# 	bindkey -M vicmd 'E' vi-forward-blank-word-end
# 	bindkey -M vicmd 'b' vi-backward-word
# 	bindkey -M vicmd 'B' vi-backward-blank-word
# 	bindkey -M vicmd 'h' vi-h-moto
# 	bindkey -M vicmd 'l' vi-l-moto
# 	bindkey -M vicmd '%' vi-match-bracket
# 	bindkey -M vicmd '^' vi-first-non-blank
# 	bindkey -M vicmd '0' vi-digit-or-beginning-of-line
# 	bindkey -M vicmd '$' vi-end-of-line
# 	bindkey -M vicmd 'd' vi-delete
# 	bindkey -M vicmd 'D' vi-kill-eol
# 	bindkey -M vicmd 'x' vi-delete-char  
# 	bindkey -M vicmd 'X' vi-backward-delete-char
# 	bindkey -M vicmd 'y' vi-yank
# 	bindkey -M vicmd 'Y' vi-yank-whole-line
# 	bindkey -M vicmd 'c' vi-change
# 	bindkey -M vicmd 'C' vi-change-eol
# 	bindkey -M vicmd 'r' vi-replace-chars
# 	bindkey -M vicmd 'R' vi-replace
# 	bindkey -M vicmd 'p' vi-put-after
# 	bindkey -M vicmd 'P' vi-put-before
# 	bindkey -M vicmd 'o' vi-open-line-below
# 	bindkey -M vicmd 'O' vi-open-line-above
# 	bindkey -M vicmd 'a' vi-add-next
# 	bindkey -M vicmd 'A' vi-add-eol
# 	bindkey -M vicmd 'i' vi-insert
# 	bindkey -M vicmd 'I' vi-insert-bol
# 	bindkey -M vicmd 'u' vi-undo-change
# 	bindkey -M vicmd '.' vi-repeat-change
# 	bindkey -M vicmd 'v' vi-v
# 	bindkey -M vicmd '' vi-c-v
# 	bindkey -M vicmd 'V' vi-V
# 	bindkey -M vicmd 's' vi-substitute
# 	bindkey -M vicmd 'S' vi-change-whole-line 
# }
# #
# ##########################################################
# #
# zle -N vi-vis-cursor-shori_before
# function vi-vis-cursor-shori_before() {
# 	if [ $MARK -lt $(( $CURSOR + 1 )) ] ;then
# 		VI_VIS_CURSOR_MARK=1
# 	elif [ $MARK -eq $(( $CURSOR + 1 )) ] ;then 
# 		VI_VIS_CURSOR_MARK=0
# 	else
# 		VI_VIS_CURSOR_MARK=-1
# 	fi
# }
# #
# zle -N vi-vis-cursor-shori_after
# function vi-vis-cursor-shori_after() {
# 	if [ $MARK -lt $(( $CURSOR + 1 )) ] ;then
# 		if [ ${VI_VIS_CURSOR_MARK} -eq 1 ] ;then
# 			MARK=$MARK
# 			CURSOR=$CURSOR
# 			VI_VIS_CURSOR_MARK=1
# 		elif [ ${VI_VIS_CURSOR_MARK} -eq 0 ] ;then
# 			MARK=$(( $MARK - 1 ))
# 			VI_VIS_CURSOR_MARK=1
# 		else
# 			MARK=$(( $MARK - 1 ))
# 			CURSOR=$CURSOR
# 			VI_VIS_CURSOR_MARK=1
# 		fi
# 	elif [ $MARK -eq $(( $CURSOR + 1 )) ] ;then 
# 		if [ ${VI_VIS_CURSOR_MARK} -eq 1 ] ;then
# 			MARK=$(( $MARK + 1 ))
# 			CURSOR=$CURSOR
# 			VI_VIS_CURSOR_MARK=-1
# 		elif [ ${VI_VIS_CURSOR_MARK} -eq 0 ] ;then
# 			MARK=$MARK
# 			CURSOR=$CURSOR
# 			VI_VIS_CURSOR_MARK=-1
# 		else
# 			MARK=$(( $MARK - 1 ))
# 			VI_VIS_CURSOR_MARK=+1
# 		fi
# 	else
# 		if [ ${VI_VIS_CURSOR_MARK} -eq 1 ] ;then
# 			MARK=$(( $MARK + 1 ))
# 			CURSOR=$CURSOR
# 			VI_VIS_CURSOR_MARK=-1
# 		elif [ ${VI_VIS_CURSOR_MARK} -eq 0 ] ;then
# 			MARK=$MARK
# 			CURSOR=$CURSOR
# 			VI_VIS_CURSOR_MARK=-1

# 		else
# 			MARK=$MARK
# 			CURSOR=$CURSOR
# 			VI_VIS_CURSOR_MARK=-1
# 		fi
# 	fi
# }
# #
# zle -N vi-h-moto
# function vi-h-moto() {
# 	CURSOR=$(( $CURSOR - 1 ))
# }
# #
# zle -N vi-l-moto
# function vi-l-moto() {
# 	CURSOR=$(( $CURSOR + 1 ))
# }
# #
# ##########################################################
# #
# zle -N vi-vis-find
# function vi-vis-find() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-find-next-char
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-Find
# function vi-vis-Find() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-find-prev-char
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-tskip
# function vi-vis-tskip() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-find-next-char-skip
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-Tskip
# function vi-vis-Tskip() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-find-prev-char-skip
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-repeatfind
# function vi-vis-repeatfind() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-repeat-find
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-repeatfindrev
# function vi-vis-repeatfindrev() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-rev-repeat-find
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-word
# function vi-vis-word() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-forward-word
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-Word
# function vi-vis-Word() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-forward-blank-word
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-end
# function vi-vis-end() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-forward-word-end
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-End
# function vi-vis-End() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-forward-blank-word-end
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-back
# function vi-vis-back() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-backward-word
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-Back
# function vi-vis-Back() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-backward-blank-word
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-hidari
# function vi-vis-hidari() {
# 	zle vi-vis-cursor-shori_before
# 	CURSOR=$(( $CURSOR - 1 ))
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-leftdenai
# function vi-vis-leftdenai() {
# 	zle vi-vis-cursor-shori_before
# 	CURSOR=$(( $CURSOR + 1 ))
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-percent
# function vi-vis-percent() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-match-bracket
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-hat
# function vi-vis-hat() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-first-non-blank
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-zero
# function vi-vis-zero() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-digit-or-beginning-of-line
# 	zle vi-vis-cursor-shori_after
# }
# #
# zle -N vi-vis-doller
# function vi-vis-doller() {
# 	zle vi-vis-cursor-shori_before
# 	zle vi-end-of-line
# 	zle vi-vis-cursor-shori_after
# }
# #
# ##########################################################
# #
# zle -N vi-vis-delete
# function vi-vis-delete() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	CURSOR=$(($CURSOR + 1))
# 	zle kill-region
# }
# #
# zle -N vi-vis-Delete
# function vi-vis-Delete() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	CURSOR=$(($CURSOR + 1))
# 	zle kill-buffer
# }
# #
# zle -N vi-vis-yank
# function vi-vis-yank() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	CURSOR=$(($CURSOR + 1))
# 	zle kill-region
# 	zle vi-put-before
# }
# #
# zle -N vi-vis-Yank
# function vi-vis-Yank() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	zle vi-yank-whole-line
# }
# #
# zle -N vi-vis-change
# function vi-vis-change() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	CURSOR=$(($CURSOR + 1))
# 	zle kill-region
# 	zle vi-insert
# }
# #
# zle -N vi-vis-Change
# function vi-vis-Change() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	zle kill-buffer
# 	zle vi-insert
# }
# #
# zle -N vi-vis-paste
# function vi-vis-paste() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	zle vi-put-after
# }
# #
# zle -N vi-vis-Paste
# function vi-vis-Paste() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	zle vi-put-before
# }
# #
# zle -N vi-vis-open
# function vi-vis-open() {
# 	CURSOR_MARK_TMP=$MARK
# 	MARK=$(($CURSOR + 1))
# 	CURSOR=$(( ${CURSOR_MARK_TMP} - 1))
# 	if [ $MARK -lt $(( $CURSOR + 1 )) ] ;then
# 		MARK=$(( $MARK - 1 ))
# 	fi
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR + 1 ))
# 	fi
# }
# #
# ##########################################################
# #
# zle -N vi-vis-add
# function vi-vis-add() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	if [ $CURSOR -lt $MARK ] ;then 
# 		CURSOR=$(($CURSOR + 1))
# 	fi
# 	MARK=$(($CURSOR + 1))
# 	zle vi-vis-key-reset
# 	zle vi-add-next
# }
# #
# zle -N vi-vis-Add
# function vi-vis-Add() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	zle vi-end-of-line
# 	MARK=$(($CURSOR + 1))
# 	zle vi-add-eol
# }
# #
# zle -N vi-vis-insert
# function vi-vis-insert() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	if [ $CURSOR -lt $MARK ] ;then 
# 		CURSOR=$(($CURSOR + 1))
# 	fi
# 	MARK=$(($CURSOR + 1))
# 	zle vi-vis-key-reset
# 	zle vi-insert
# }
# #
# zle -N vi-vis-Insert
# function vi-vis-Insert() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	zle vi-digit-or-beginning-of-line
# 	MARK=$CURSOR
# 	zle vi-insert-bol
# }
# #
# ##########################################################
# #
# zle -N vi-vis-undo
# function vi-vis-undo() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	zle vi-undo-change
# }
# #
# zle -N vi-vis-repeat
# function vi-vis-repeat() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	zle vi-vis-key-reset
# 	zle vi-repeat-change
# }
# #
# zle -N vi-vis-reset
# function vi-vis-reset() {
# 	if [ $MARK -gt $(( $CURSOR + 1 )) ] ;then
# 		CURSOR=$(( $CURSOR - 1 ))
# 	fi
# 	if [ ${VI_VIS_MODE} -eq 2 ] ;then
# 		CURSOR=$CURSOR_V_START
# 	fi
# 	zle vi-vis-key-reset
# 	zle vi-cmd-mode
# }


# 戦闘力
function scouter() {
  sed -e '/^\s*$/d' -e '/^\s*#/d' ${ZDOTDIR:-$HOME}/.zshrc | wc -l
}
