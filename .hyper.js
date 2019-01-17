// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: 'canary',

    // default font size in pixels for all tabs
    fontSize: 14,

    // font family with optional fallbacks
    fontFamily: '"源真ゴシック等幅", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

    // default font weight: 'normal' or 'bold'
    fontWeight: 'normal',

    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: 'bold',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    // cursorColor: 'rgba(248,28,229,0.8)',
    cursorColor: 'rgba(192,202,0,0.8)',

    // terminal text color under BLOCK cursor
    cursorAccentColor: '#000',

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for â–ˆ
    cursorShape: 'BLOCK',

    // set to `true` (without backticks and without quotes) for blinking cursor
    // cursorBlink: false,
    cursorBlink: true,

    // color of the text
    foregroundColor: '#fff',

    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: '#1D1F21',

    // terminal selection color
    // selectionColor: 'rgba(248,28,229,0.3)',
    selectionColor: 'rgba(192,202,0,0.3)',

    // border color (window, tabs)
    borderColor: '#1D1F21',

    // custom CSS to embed in the main window
    css: `
      .hyper_main {
        border: none;
      }
      .tabs_borderShim {
        display: none;
      }
      .tab_tab {
        border: none;
        color: rgba(255, 255, 255, 0.2);
        background-color: transparent;
      }
      .tab_tab:hover {
        background-color: transparent;
      }
      .tab_tab::before {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 2px;
        background-color: '#80CBC4';
        transform: scaleX(0);
        transition: none;
      }
      .tab_tab.tab_active {
        color: #FFF;
      }
      .tab_tab.tab_active::before {
        transform: scaleX(1);
        transition: all 300ms cubic-bezier(0.0, 0.0, 0.2, 1)
      }
      .tab_textInner {
        text-overflow: ellipsis;
        overflow: hidden;
        max-width: 100%;
        padding: 0px 24px 0 8px;
      }
      .splitpane_divider {
        background-color: rgba(255, 255, 255, 0.15) !important;
      }
    `,

    // custom CSS to embed in the terminal window
    termCSS: `
      .xterm-text-layer a {
        text-decoration: underline !important;
        color: '#80CBC4' !important;
      }

      *::-webkit-scrollbar {
        width: 4px;
        height: 4px;
        background-color: transparent;
      }

      *::-webkit-scrollbar-track {
        background-color: transparent;
      }

      *::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.2);
      }

      *::-webkit-scrollbar-thumb:window-inactive {
        background: transparent;
      }
    `,

    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: '',

    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: '',

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: '12px 14px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#1D1F21',
      red: '#CC6666',
      green: '#b5bd68',
      yellow: '#F0C674',
      blue: '#81A2BE',
      magenta: '#B294BB',
      cyan: '#8ABEB7',
      white: '#DDDDDD',
      lightBlack: '#686868',
      lightRed: '#CC6666',
      lightGreen: '#b5bd68',
      lightYellow: '#F0C674',
      lightBlue: '#81A2BE',
      lightMagenta: '#B294BB',
      lightCyan: '#8ABEB7',
      lightWhite: '#FFFFFF',
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Bash on Windows
    // - Example: `C:\\Windows\\System32\\bash.exe`
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    // shell: '',
    // shell: 'C:\\Windows\\System32\\bash.exe',
    // shell: 'C:\\Users\\ko-yamamoto\\bin\\zsh.bat',
    // shell: 'C:\\Users\\ko-yamamoto\\bin\\fish.bat',
    shell: 'C:\\Windows\\System32\\wsl.exe',

    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    // shellArgs: ['--login'],
    shellArgs: ['~'],

    // for environment variables
    env: {},

    // set to `false` for no bell
    bell: 'SOUND',

    // if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
    // copyOnSelect: false,
    copyOnSelect: true,

    // if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
    defaultSSHApp: true,

    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    // quickEdit: true,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg

    clearCommand: 'clear',

    broadcast: {
      debug: false,
      hotkeys: {
        selectCurrentPane: "Ctrl+Shift+1",
        selectCurrentTabPanes: "Ctrl+Shift+9",
        selectAllPanes: "",
        toggleCurrentPane: "Ctrl+Shift+0"
      },
      indicatorStyle: {
        position: "absolute",
        bottom: 0,
        right: 0,
        width: "100%",
        height: "10px",
        background: "#E68181"
      }
    },

    init: [
      {
        rule: 'once',
        commands: ['cd $HOME']
      },
      {
        rule: 'windows',
        commands: ['cd $HOME']
      },
      {
        rule: 'tabs',
        commands: ['cd $HOME']
      },
      {
        rule: 'splitted',
        commands: ['cd $HOME']
      }
    ],

    // hypercwd: {
    //   initialWorkingDirectory: ''
    // }

  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    'hyper-broadcast',
    'hyper-search',
    'hyper-tab-icons-plus',
    // 'hypercwd'
    // 'hyper-init',
    // "hyper-solarized-light",
    // "hyper-material-theme",
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],

  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
    'pane:next': ['ctrl+pageup', 'ctrl+t'],
    'tab:next': ['ctrl+tab', 'ctrl+s']
  },

};
