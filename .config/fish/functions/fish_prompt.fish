function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

  # User
  set_color $fish_color_user
  echo -n (whoami)
  set_color normal

  echo -n '@'

  # Host
  set_color $fish_color_host
  # echo -n (hostname -s)
  echo -n (hostname)
  set_color normal

  echo -n ':'

  # PWD
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal

  __terlar_git_prompt
  echo

  switch (echo $last_status)
	case 0
		set_color $fish_color_command
	case '*'
		set_color $fish_color_error
  end

  echo -n '> '
  set_color normal

  # for z.fish
  z --add "$PWD"

  # for autojump
  autojump -a $PWD > /dev/null &
end
