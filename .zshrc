UNAME=`uname`


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


# 共通のPATH
export PATH=$HOME/bin:$PATH

# 環境変数LANG
# export LANG=ja_JP.utf8
export LANG=ja_JP.UTF-8

# JAVA
JAVA_OPTS="-Dfile.encoding=UTF-8"
export JAVA_OPTS

# Scala
export SCALA_HOME=/usr/local/scala
export PATH=$PATH:$SCALA_HOME/bin
# -deprecationつけて起動
alias scala='scala -deprecation $1'


# プロンプトをカラー表示
autoload colors && colors

# プロンプト表示設定
setopt prompt_subst
# PROMPT='%F{green}%n%f/%m%B%(?.%F{blue}%(!.#. :))%f.%F{red}%(!.#. :()%f)%b '

# PROMPT='%F{green}%n%f/%m  %F{blue}%(10~,%-4~/.../%6~,%~)%f
# %B%(?.%F{blue}%(!.#.／^o^＼)%f.%F{red}%(!.#.＼^o^／)%f)%b '
PROMPT='%F{green}%n%f/%m  %F{blue}%(10~,%-4~/.../%6~,%~)%f
%B%(?.%F{blue}%(!.#.>)%f.%F{red}%(!.#.!)%f)%b '


# バージョン管理情報表示
# setopt prompt_subst
# autoload -Uz vcs_info
# zstyle ':vcs_info:*' actionformats \
#     '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
# zstyle ':vcs_info:*' formats       \
#     '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
# zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

# zstyle ':vcs_info:*' enable git cvs svn

# # or use pre_cmd, see man zshcontrib
# vcs_info_wrapper() {
#   vcs_info
#   if [ -n "$vcs_info_msg_0_" ]; then
#     echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
#   fi
# }

# # バージョン管理 短縮したカレントディレクトリ
# RPROMPT=$'$(vcs_info_wrapper)%F{red}@%f%F{blue}%(5~,%-1~/.../%2~,%~)%f'



# RPROMPT 設定
if [ `echo $UNAME | grep 'CYGWIN'` ] ; then
# CYGWIN は重いのでシンプル
    # RPROMPT="%F{blue}%(5~,%-1~/.../%2~,%~)%f"
else
# CYGWIN 以外
    # vcs_info 設定

    RPROMPT=""

    autoload -Uz vcs_info
    autoload -Uz add-zsh-hook
    autoload -Uz is-at-least
    autoload -Uz colors

    # 以下の3つのメッセージをエクスポートする
    #   $vcs_info_msg_0_ : 通常メッセージ用 (緑)
    #   $vcs_info_msg_1_ : 警告メッセージ用 (黄色)
    #   $vcs_info_msg_2_ : エラーメッセージ用 (赤)
    zstyle ':vcs_info:*' max-exports 3

    zstyle ':vcs_info:*' enable git svn hg bzr
    # 標準のフォーマット(git 以外で使用)
    # misc(%m) は通常は空文字列に置き換えられる
    zstyle ':vcs_info:*' formats '(%s)-[%b]'
    zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
    zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
    zstyle ':vcs_info:bzr:*' use-simple true


    if is-at-least 4.3.10; then
        # git 用のフォーマット
        # git のときはステージしているかどうかを表示
        zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
        zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
        zstyle ':vcs_info:git:*' check-for-changes true
        zstyle ':vcs_info:git:*' stagedstr "+"    # %c で表示する文字列
        zstyle ':vcs_info:git:*' unstagedstr "-"  # %u で表示する文字列
    fi

    # hooks 設定
    if is-at-least 4.3.11; then
        # git のときはフック関数を設定する

        # formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
        # のメッセージを設定する直前のフック関数
        # 今回の設定の場合はformat の時は2つ, actionformats の時は3つメッセージがあるので
        # 各関数が最大3回呼び出される。
        zstyle ':vcs_info:git+set-message:*' hooks \
            git-hook-begin \
            git-untracked \
            git-push-status \
            git-nomerge-branch \
            git-stash-count

        # フックの最初の関数
        # git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
        # (.git ディレクトリ内にいるときは呼び出さない)
        # .git ディレクトリ内では git status --porcelain などがエラーになるため
        function +vi-git-hook-begin() {
            if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
                # 0以外を返すとそれ以降のフック関数は呼び出されない
                return 1
            fi

            return 0
        }

        # untracked フィアル表示
        #
        # untracked ファイル(バージョン管理されていないファイル)がある場合は
        # unstaged (%u) に ? を表示
        function +vi-git-untracked() {
            # zstyle formats, actionformats の2番目のメッセージのみ対象にする
            if [[ "$1" != "1" ]]; then
                return 0
            fi

            if command git status --porcelain 2> /dev/null \
                | awk '{print $1}' \
                | command grep -F '??' > /dev/null 2>&1 ; then

                # unstaged (%u) に追加
                hook_com[unstaged]+='?'
            fi
        }

        # push していないコミットの件数表示
        #
        # リモートリポジトリに push していないコミットの件数を
        # pN という形式で misc (%m) に表示する
        function +vi-git-push-status() {
            # zstyle formats, actionformats の2番目のメッセージのみ対象にする
            if [[ "$1" != "1" ]]; then
                return 0
            fi

            if [[ "${hook_com[branch]}" != "master" ]]; then
                # master ブランチでない場合は何もしない
                return 0
            fi

            # push していないコミット数を取得する
            local ahead
            ahead=$(command git rev-list origin/master..master 2>/dev/null \
                | wc -l \
                | tr -d ' ')

            if [[ "$ahead" -gt 0 ]]; then
                # misc (%m) に追加
                hook_com[misc]+="(p${ahead})"
            fi
        }

        # マージしていない件数表示
        #
        # master 以外のブランチにいる場合に、
        # 現在のブランチ上でまだ master にマージしていないコミットの件数を
        # (mN) という形式で misc (%m) に表示
        function +vi-git-nomerge-branch() {
            # zstyle formats, actionformats の2番目のメッセージのみ対象にする
            if [[ "$1" != "1" ]]; then
                return 0
            fi

            if [[ "${hook_com[branch]}" == "master" ]]; then
                # master ブランチの場合は何もしない
                return 0
            fi

            local nomerged
            nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

            if [[ "$nomerged" -gt 0 ]] ; then
                # misc (%m) に追加
                hook_com[misc]+="(m${nomerged})"
            fi
        }


        # stash 件数表示
        #
        # stash している場合は :SN という形式で misc (%m) に表示
        function +vi-git-stash-count() {
            # zstyle formats, actionformats の2番目のメッセージのみ対象にする
            if [[ "$1" != "1" ]]; then
                return 0
            fi

            local stash
            stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
            if [[ "${stash}" -gt 0 ]]; then
                # misc (%m) に追加
                hook_com[misc]+=":S${stash}"
            fi
        }

    fi

    function _update_vcs_info_msg() {
        local -a messages
        local prompt

        LANG=en_US.UTF-8 vcs_info

        if [[ -z ${vcs_info_msg_0_} ]]; then
        # vcs_info で何も取得していない場合はプロンプトを表示しない
            prompt=""
        else
        # vcs_info で情報を取得した場合
        # $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_ を
        # それぞれ緑、黄色、赤で表示する
            [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
            [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
            [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # 間にスペースを入れて連結する
            prompt="${(j: :)messages}"
        fi

        RPROMPT="$prompt"
    }
    add-zsh-hook precmd _update_vcs_info_msg

fi




# 自動/Tram 用プロンプト
case "${TERM}" in
    dumb | emacs)
        PROMPT="%n@%~%(!.#.$)"
        RPROMPT=""
        unsetopt zle
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

# 補完用ファイル置き場追加
fpath=(~/.zsh/functions(N-/) ${fpath})

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

# C-w は一つ上のパスまでを消す
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

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

compdef _git g='git' # g でも git として補完
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



# ssh-agent 用
agentPID=`ps gxww|grep "ssh-agent]*$"|awk '{print $1}'`
agentSOCK=`/bin/ls -t /tmp/ssh*/agent*|head -1`
if [ "$agentPID" = "" -o "$agentSOCK" = "" ]; then
    unset SSH_AUTH_SOCK SSH_AGENT_PID
    eval `ssh-agent`
    # ssh-add < /dev/null
else
    export SSH_AGENT_PID=$agentPID
    export SSH_AUTH_SOCK=$agentSOCK
    # if [ `ssh-add -l` = "" ]; then
    #     ssh-add < /dev/null
    # fi
fi







# plugins######################################################

# zaw
if [ -f ~/bin/zaw/zaw.zsh ]; then
    source ~/bin/zaw/zaw.zsh
    bindkey '^Q;' zaw
    bindkey '^R' zaw-history
    zstyle ':filter-select' max-lines $(($LINES / 3))
fi


# zsh-completions
# cd ~/bin
# git clone https://github.com/zsh-users/zsh-completions.git
if [ -d ~/bin/zsh-completions ]; then
    fpath=($HOME/bin/zsh-completions/src $fpath)
    rm -f ~/.zcompdump; autoload -U compinit; compinit
fi

# Mineファイル読み込み
# オレオレ設定はこっちに
[ -f ~/.zshrc.mac ] && source ~/.zshrc.mac
[ -f ~/.zshrc.cyg ] && source ~/.zshrc.cyg
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine




# 補完用 #####################################################
# mosh
# Thx! "zsh+MoshでHostnameを補完出来るようにした - Glide Note - グライドノート"
# http://blog.glidenote.com/blog/2012/04/14/mosh-hostname-completion/
function _mosh_hosts {
  local -a config_hosts
  local config
  integer ind

  # If users-hosts matches, we shouldn't complete anything else.
  if [[ "$IPREFIX" == *@ ]]; then
    _combination -s '[:@]' my-accounts users-hosts "users=${IPREFIX/@}" hosts "$@" && return
  else
    _combination -s '[:@]' my-accounts users-hosts \
      ${opt_args[-l]:+"users=${opt_args[-l]:q}"} hosts "$@" && return
  fi
  if (( ind = ${words[(I)-F]} )); then
    config=${~words[ind+1]}
  else
    config="$HOME/.ssh/config"
  fi
  if [[ -r $config ]]; then
    local IFS=$'\t ' key hosts host
    while read key hosts; do
      if [[ "$key" == (#i)host ]]; then
	 for host in ${(z)hosts}; do
	    case $host in
	    (*[*?]*) ;;
	    (*) config_hosts+=("$host") ;;
	    esac
	 done
      fi
    done < "$config"
    if (( ${#config_hosts} )); then
      _wanted hosts expl 'remote host name' \
	compadd -M 'm:{a-zA-Z}={A-Za-z} r:|.=* r:|=*' "$@" $config_hosts
    fi
  fi
}
compdef _mosh_hosts mosh



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


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
