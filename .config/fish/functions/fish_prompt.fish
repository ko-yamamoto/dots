set fish_color_search_match --background=blue
set fish_color_command green
set fish_color_error red
set fish_color_autosuggestion blue
set fish_color_param white

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch blue
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '!'
set __fish_git_prompt_char_stagedstate 's'
set __fish_git_prompt_char_untrackedfiles '?'
set __fish_git_prompt_char_stashstate ''
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'


function fish_prompt

    function prompt_pwd
    # ディレクトリ名の省略をしないように関数を上書き
      echo $PWD | sed -e "s|^$HOME|~|"
    end

	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

    # Main
    echo -n \n(set_color white)@ (set_color yellow)(prompt_pwd)

    # Git
    set last_status $status
    printf ' %s ' (set_color normal)(__fish_git_prompt)
    set_color normal

    # Main
    echo -n \n(set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '(set_color normal)
end
