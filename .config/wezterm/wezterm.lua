-- Import the wezterm module
local wezterm = require 'wezterm'
-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

-- (This is where our config will go)

-- カスタムカラースキーマ（iTerm2からインポート）
config.colors = {
  foreground = "#bcc1cd",
  background = "#1d2025",
  cursor_bg = "#a7a0dc",
  cursor_fg = "#1b1b1b",
  cursor_border = "#a7a0dc",
  selection_fg = "#bcc1cd",
  selection_bg = "#424349",
  ansi = {
    "#000000",  -- black
    "#ed756f",  -- red
    "#9fbc6f",  -- green
    "#e4bf84",  -- yellow
    "#a7a1dc",  -- blue
    "#bb7bd7",  -- magenta
    "#69ace9",  -- cyan
    "#bcc1cd",  -- white
  },
  brights = {
    "#000000",  -- bright black
    "#ec6f5d",  -- bright red
    "#9fb970",  -- bright green
    "#e4bf84",  -- bright yellow
    "#a7a1dc",  -- bright blue
    "#bb7bd7",  -- bright magenta
    "#69ace9",  -- bright cyan
    "#bebebe",  -- bright white
  },
  -- タブ同士の境界線を非表示
  tab_bar = {
    inactive_tab_edge = "none",
  },
}

-- フォント設定
config.font = wezterm.font_with_fallback({
  {
    family = "Guguru Sans Code Console NF",
    weight = "Regular",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },  -- リガチャ無効
  },
  {
    family = "PlemolJP Console NF",  -- 非ASCII用フォールバック
    weight = "Regular",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  },
})
config.font_size = 14.0
config.cell_width = 1.01   -- 101%
config.line_height = 1.06  -- 106%
config.command_palette_font_size = 18.0
config.command_palette_bg_color = '#4D07FF'
config.use_ime = true
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"  -- IME入力中にCtrl+hでバックスペースを有効化


-- タイトルバーを非表示
config.window_decorations = "RESIZE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true
-- タブが一つの時は非表示
config.hide_tab_bar_if_only_one_tab = true
-- falseにするとタブバーの透過が効かなくなる
-- config.use_fancy_tab_bar = false

-- タブバーを背景色に合わせる
config.window_background_gradient = {
  colors = { "#000000" },
}

-- タブタイトルにパディングを追加
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  -- タブ番号を表示する場合
  local index = tab.tab_index + 1
  -- 前後にスペースを追加（数を増やすと隙間が広がる）
  return '  ' .. index .. ': ' .. title .. '  '
end)

config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
  font = wezterm.font("Guguru Sans Code Console NF", { weight = "Regular" }),
  font_size = 12.0,
}

config.window_background_opacity = 0.85
config.macos_window_background_blur = 20




wezterm.on('update-status', function(window)
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

	local color_scheme = window:effective_config().resolved_palette
	local bg = color_scheme.background
	local fg = color_scheme.foreground

	local f = io.open(os.getenv('HOME') .. '/.wezstatus', 'r')
	local status = ''
	if f then
		status = f:read('l')
		f:close()
	end

	window:set_right_status(wezterm.format({
		{ Background = { Color = 'none' } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = ' ' .. status .. ' ' },
	}))
end)


----------------------------------------------------
-- keybinds
----------------------------------------------------
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }


-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config
