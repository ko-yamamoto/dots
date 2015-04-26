# -*- coding:utf-8; mode:ruby; -*-

# sudo rbindkeys --config ~/.rbindkeys.rb /dev/input/event0

## user settings

# if you use a keyboard which have a left ctrl key at the left of "A" key,
# then you must set false
# @swap_left_ctrl_with_caps = true

# for apple keyboard
# @swap_left_opt_with_left_cmd = true

##

# pre_bind_key: pre-proccessed keybinding
if @swap_left_ctrl_with_caps
  pre_bind_key KEY_CAPSLOCK, KEY_LEFTCTRL
  pre_bind_key KEY_LEFTCTRL, KEY_CAPSLOCK
end

if @swap_left_opt_with_left_cmd
  pre_bind_key KEY_LEFTMETA, KEY_LEFTALT
  pre_bind_key KEY_LEFTALT, KEY_LEFTMETA
end


@pre_spc_flg = false


def quit(operator)
  if !@pre_spc_flg
    operator.press_key KEY_ESC
    operator.release_key KEY_ESC
  end
  @pre_spc_flg = false
end

def delete_char(operator)
  operator.release_key KEY_LEFTCTRL
  operator.press_key KEY_DELETE
  operator.release_key KEY_DELETE
  @pre_spc_flg = false
end

def delete_backward_char(operator)
  operator.release_key KEY_LEFTCTRL
  operator.press_key KEY_BACKSPACE
  operator.release_key KEY_BACKSPACE
  @pre_spc_flg = false
end

def kill_region(operator)
  operator.press_key KEY_LEFTCTRL
  operator.press_key KEY_X
  operator.release_key KEY_X
  operator.release_key KEY_LEFTCTRL
  @pre_spc_flg = false
end

def kill_ring_save(operator)
  operator.release_key KEY_LEFTALT
  operator.press_key KEY_LEFTCTRL
  operator.press_key KEY_C
  operator.release_key KEY_C
  operator.release_key KEY_LEFTCTRL
  @pre_spc_flg = false
end

def yank_paste(operator)
  operator.release_key KEY_LEFTALT
  operator.press_key KEY_LEFTCTRL
  operator.press_key KEY_V
  operator.release_key KEY_V
  operator.release_key KEY_LEFTCTRL
  @pre_spc_flg = false
end

def move_caret(operator, direction)
  operator.release_key KEY_LEFTCTRL
  if @pre_spc_flg
    operator.press_key KEY_LEFTSHIFT
    operator.press_key direction
    operator.release_key direction
    operator.release_key KEY_LEFTSHIFT
  else
    operator.press_key direction
    operator.release_key direction
  end
end

def forward_char(operator)
  move_caret(operator, KEY_RIGHT)
end

def backward_char(operator)
  move_caret(operator, KEY_LEFT)
end

def next_line(operator)
  move_caret(operator, KEY_DOWN)
end

def previous_line(operator)
  move_caret(operator, KEY_UP)
end

def forward_word(operator)
  operator.release_key KEY_LEFTALT
  if @pre_spc_flg
    operator.press_key KEY_LEFTSHIFT
    operator.press_key KEY_LEFTCTRL
    operator.press_key KEY_RIGHT
    operator.release_key KEY_RIGHT
    operator.release_key KEY_LEFTCTRL
    operator.release_key KEY_LEFTSHIFT
  else
    operator.press_key KEY_LEFTCTRL
    operator.press_key KEY_RIGHT
    operator.release_key KEY_RIGHT
    operator.release_key KEY_LEFTCTRL
  end
end

def backward_word(operator)
  operator.release_key KEY_LEFTALT
  if @pre_spc_flg
    operator.press_key KEY_LEFTSHIFT
    operator.press_key KEY_LEFTCTRL
    operator.press_key KEY_LEFT
    operator.release_key KEY_LEFT
    operator.release_key KEY_LEFTCTRL
    operator.release_key KEY_LEFTSHIFT
  else
    operator.press_key KEY_LEFTCTRL
    operator.press_key KEY_LEFT
    operator.release_key KEY_LEFT
    operator.release_key KEY_LEFTCTRL
  end
end


def move_beginning_of_line(operator)
  operator.release_key KEY_LEFTCTRL
  if @pre_spc_flg
    operator.press_key KEY_LEFTSHIFT
    operator.press_key KEY_HOME
    operator.release_key KEY_HOME
    operator.release_key KEY_LEFTSHIFT
  else
    operator.press_key KEY_HOME
    operator.release_key KEY_HOME
  end
end

def move_end_of_line(operator)
  operator.release_key KEY_LEFTCTRL
  if @pre_spc_flg
    operator.press_key KEY_LEFTSHIFT
    operator.press_key KEY_END
    operator.release_key KEY_END
    operator.release_key KEY_LEFTSHIFT
  else
    operator.press_key KEY_END
    operator.release_key KEY_END
  end
end


def undo(operator)
  operator.press_key KEY_LEFTCTRL
  operator.press_key KEY_Z
  operator.release_key KEY_Z
  operator.release_key KEY_LEFTCTRL
  @pre_spc_flg = false
end

def undo_redo(operator)
  operator.release_key KEY_LEFTALT
  operator.press_key KEY_LEFTCTRL
  operator.press_key KEY_Y
  operator.release_key KEY_Y
  operator.release_key KEY_LEFTCTRL
  @pre_spc_flg = false
end

bind_key [KEY_LEFTCTRL, KEY_SPACE] do
  if @pre_spc_flg
    @pre_spc_flg = false
  else
    @pre_spc_flg = true
  end
  operator.press_key KEY_LEFTCTRL
  operator.press_key KEY_SPACE
  operator.release_key KEY_SPACE
  operator.release_key KEY_LEFTCTRL
end


bind_key [KEY_LEFTCTRL, KEY_F] do |event, operator|
  forward_char(operator)
end

# bind_key [KEY_LEFTCTRL, KEY_B], KEY_LEFT
bind_key [KEY_LEFTCTRL, KEY_B] do |event, operator|
  backward_char(operator)
end

bind_key [KEY_LEFTCTRL, KEY_P] do |event, operator|
  previous_line(operator)
end

bind_key [KEY_LEFTCTRL, KEY_N] do |event, operator|
  next_line(operator)
end

bind_key [KEY_LEFTALT, KEY_F] do |event, operator|
  forward_word(operator)
end

bind_key [KEY_LEFTALT, KEY_B] do |event, operator|
  backward_word(operator)
end


bind_key [KEY_LEFTCTRL, KEY_A] do |event, operator|
  move_beginning_of_line(operator)
end

bind_key [KEY_LEFTCTRL, KEY_E] do |event, operator|
  move_end_of_line(operator)
end

# page scroll
bind_key [KEY_LEFTCTRL, KEY_V], KEY_PAGEDOWN
bind_key [KEY_LEFTALT, KEY_V], KEY_PAGEUP

# edit
bind_key [KEY_LEFTCTRL, KEY_D] do |event, operator|
  delete_char(operator)
end

bind_key [KEY_LEFTCTRL, KEY_H] do |event, operator|
  delete_backward_char(operator)
end

bind_key [KEY_LEFTCTRL, KEY_M], KEY_ENTER
bind_key [KEY_LEFTCTRL, KEY_I], KEY_TAB

bind_key [KEY_LEFTCTRL, KEY_LEFTBRACE] do |event, operator|
  quit(operator)
end

bind_key [KEY_LEFTCTRL, KEY_G] do |event, operator|
  quit(operator)
end

bind_key [KEY_LEFTCTRL, KEY_S], [KEY_LEFTCTRL, KEY_F]
bind_key [KEY_LEFTCTRL, KEY_R], [KEY_LEFTCTRL, KEY_LEFTSHIFT, KEY_F]

bind_key [KEY_LEFTCTRL, KEY_SLASH]  do |event, operator|
  undo(operator)
end

bind_key [KEY_LEFTALT, KEY_SLASH]  do |event, operator|
  undo_redo(operator)
end

# bind_key [KEY_LEFTALT, KEY_Y], [KEY_LEFTCTRL, KEY_LEFTALT, KEY_Y]

# give a block sample
@caps_led_state = 0
bind_key KEY_CAPSLOCK do |event, operator|
  @caps_led_state = @caps_led_state ^ 1
  puts "########## CAPSLOCK LED #{@caps_led_state.zero? ? 'off' : 'on'} ##########"
  operator.send_event EV_LED, LED_CAPSL, @caps_led_state
end

# cut, copy and paste
bind_key [KEY_LEFTCTRL, KEY_W] do |event, operator|
  kill_region(operator)
end

bind_key [KEY_LEFTALT, KEY_W] do |event, operator|
  kill_ring_save(operator)
end

bind_key [KEY_LEFTCTRL, KEY_Y] do |event, operator|
  yank_paste(operator)
end

# kill line
bind_key [KEY_LEFTCTRL, KEY_K] do |event, operator|
  # Shift+End : select text to end of line
  operator.press_key KEY_LEFTSHIFT
  operator.press_key KEY_END
  operator.release_key KEY_END
  operator.release_key KEY_LEFTSHIFT

  # Ctrl+x : cut
  operator.press_key KEY_LEFTCTRL
  operator.press_key KEY_X
  operator.release_key KEY_X
  operator.release_key KEY_LEFTCTRL
end

# 2 stroke key binds
# if your input was not hit any bind_key, the input will be ignored
bind_prefix_key [KEY_LEFTCTRL, KEY_X] do

  # C-xk: close tab, etc.
  bind_key KEY_K, [KEY_LEFTCTRL, KEY_W]

  # C-xC-s: save
  bind_key [KEY_LEFTCTRL, KEY_S], [KEY_LEFTCTRL, KEY_S]

  # C-xb: next tab, etc.
  bind_key KEY_B, [KEY_LEFTCTRL, KEY_TAB]

  # C-xC-g: ignore C-x prefix bind
  bind_key [KEY_LEFTCTRL, KEY_G], :ignore

  # C-xC-c: close window
  bind_key [KEY_LEFTCTRL, KEY_C], [KEY_LEFTMETA, KEY_Q] # awesome

  # C-xC-r: reload window
  bind_key [KEY_LEFTCTRL, KEY_R], [KEY_LEFTCTRL, KEY_R]

end

bind_prefix_key [KEY_LEFTCTRL, KEY_Q] do

  # C-qC-g: ignore C-q prefix bind
  bind_key [KEY_LEFTCTRL, KEY_G], :ignore

  # C-qx: close tab, etc.
  bind_key KEY_X, [KEY_LEFTCTRL, KEY_W]

end

# settings per window class (or title)

# through all key inputs if active
window(:through, :class => /gnome-terminal/)
window(:through, :class => /lilyterm/)
window(:through, :class => /emacs/)
window(:through, :class => /gvim/)
window(:through, :class => /Navigator/) # firefox

# # add new bind_key to default binds
# window(@default_bind_resolver, :class => /google-chrome/) do
#   bind_key [KEY_LEFTCTRL, KEY_S], [KEY_LEFTCTRL, KEY_F]
# end
