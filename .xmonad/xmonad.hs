--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS

import XMonad.Layout.ResizableTile
import XMonad.Layout.Grid
import XMonad.Layout.StackTile
import XMonad.Layout.Spacing
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.SimpleFloat

import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Hooks.SetWMName

import XMonad.Actions.CopyWindow
import XMonad.Actions.FloatKeys


-- Color Setting
colorBlue      = "#6699cc"
colorGreen     = "#99cc99"
colorRed       = "#f2777a"
colorYellow    = "#ffcc66"
colorGray      = "#9e9e9e"
colorWhite     = "#ffffff"
colorGrayAlt   = "#eceff1"
colorNormalbg  = "#1c1c1c"
colorfg        = "#9fa8b1"

-- bar
myBar = "xmobar"
myPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws,t]
                , ppCurrent         = xmobarColor colorYellow colorNormalbg . \s -> "■"
                , ppUrgent          = xmobarColor colorBlue   colorNormalbg . \s -> "●"
                , ppVisible         = xmobarColor colorBlue   colorNormalbg . \s -> "●"
                , ppHidden          = xmobarColor colorBlue   colorNormalbg . \s -> "●"
                , ppHiddenNoWindows = xmobarColor colorfg     colorNormalbg . \s -> "◯"
                , ppTitle           = xmobarColor colorYellow colorNormalbg . wrap "> " "" . shorten 250
                , ppOutput          = putStrLn
                , ppWsSep           = " "
                , ppSep             = "  "
                }

toggleStrutsKey XConfig { XMonad.modMask = modMask } = (modMask, xK_b)

-- gridselect
myGsconfig = defaultGSConfig { gs_cellheight = 100, gs_cellwidth = 260 }

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
-- myTerminal      = "xterm -fa ricty +cjk_width -fs 9"
-- myTerminal      = "xterm -fa Hermit -fd 07YasashisaGothic +cjk_width -fs 10"
myTerminal      = "lilyterm"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
-- myModMask       = mod1Mask
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Width of the window border in pixels.
--
myBorderWidth   = 1
-- Border colors for unfocused and focused windows, respectively.
-- Border color
myNormalBorderColor  = colorNormalbg
myFocusedBorderColor = colorfg

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
-- myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
myKeys = \conf -> mkKeymap conf $
    -- launch a terminal
    [ ("M-<Return>", spawn $ XMonad.terminal conf)

    -- launch dmenu
    -- , ("M-p", spawn "dmenu_run -fn \"Gen Shin Gothic Monospace-13\"")
    , ("M-p", spawn "dmenu_run -fn \"M+ 1mn-11\"")

    -- launch gmrun
    , ("M-S-p", spawn "gmrun")

    -- launch gvim
    , ("M-S-g", spawn "gvim")

    -- close focused window -> Close the focused window
    , ("M-S-c", kill)
    , ("M-w", kill1)
    , ("M-q", kill)

     -- Rotate through the available layout algorithms
    , ("M-<Space>", sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ("M-S-<Space>", setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    -- , ("M-n", refresh)

    -- Move focus to the next window
    , ("M-<Tab>", windows W.focusDown)

    -- Move focus to the next window
    , ("M-j", windows W.focusDown)

    -- Move focus to the previous window
    , ("M-k", windows W.focusUp  )

    -- Move focus to the master window
    , ("M-m", windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ("M-S-<Return>", windows W.swapMaster)

    -- Swap the focused window with the next window
    , ("M-S-j", windows $ W.swapDown . W.focusDown)

    -- Swap the focused window with the previous window
    , ("M-S-k", windows $ W.swapUp . W.focusUp)

    -- フルスクリーンをトグル(MultiToggle)
    , ("M-f", sendMessage $ Toggle FULL)

    -- Shrink the master area
    , ("M--", sendMessage Shrink)

    -- Expand the master area
    , ("M-=", sendMessage Expand)
    , ("M-^", sendMessage Expand)

    -- Shrink a window vertically
    , ("M-z", sendMessage MirrorShrink)
    , ("M-S-=", sendMessage MirrorShrink)
    , ("M-S-^", sendMessage MirrorShrink)
    -- Expand a window vertically
    , ("M-a", sendMessage MirrorExpand)
    , ("M-S--", sendMessage MirrorExpand)

    -- Push window back into tiling
    , ("M-t", withFocused $ windows . W.sink)

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ("M-S-q", io (exitWith ExitSuccess))

    -- Restart xmonad
    , ("M-r", spawn "xmonad --recompile; xmonad --restart")

    -- GridSelect
    , ("M-g", goToSelected myGsconfig)
    , ("M-s", nextWS)
    , ("M-S-s", prevWS)

    -- @@ Make focused window always visible
    , ("M-v", windows copyToAll)
    -- @@ Toggle window state back
    , ("M-S-v",  killAllOtherCopies)

    ]

    ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [(m ++ (show k), windows $ f i)
         | (i, k) <- zip (XMonad.workspaces conf) [1 .. 9]
    , (f, m) <- [(W.greedyView, "M-"), (W.shift, "M-S-")]
    ]

    ++
    -- moving and resizing floating window with key
    [(c ++ m ++ k, withFocused $ f (d x))
         | (d, k) <- zip [\a->(a, 0), \a->(0, a), \a->(0-a, 0), \a->(0, 0-a)] ["<Right>", "<Down>", "<Left>", "<Up>"]
         , (f, m) <- zip [keysMoveWindow, \d -> keysResizeWindow d (0, 0)] ["M-", "M-S-"]
         , (c, x) <- zip ["", "C-"] [50, 5]
    ]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
-- myLayout = (ResizableTall 1 (3/100) (1/2) []) ||| tiled ||| Mirror tiled ||| Full
-- myLayout = (ResizableTall 1 (3/100) (1/2) []) ||| Mirror tiled ||| Full
-- myLayout = (ResizableTall 1 (3/100) (3/5) [])||| (ResizableTall 2 (3/100) (2/5) []) ||| Grid ||| (Mirror $ ResizableTall 1 (3/100) (1/2) []) ||| Full
-- myLayout = mkToggle1 FULL $ (spacing spaceSize $ ResizableTall 1 delta ratio []) ||| (spacing spaceSize $ ResizableTall 2 delta ratio []) ||| (spacing spaceSize $ Grid) ||| simpleFloat
myLayout = mkToggle1 FULL $ ( ResizableTall 1 delta ratio []) ||| ( ResizableTall 2 delta ratio []) ||| ( Grid ) ||| simpleFloat
  where
     -- Default proportion of screen occupied by master pane
     ratio   = 3/5
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
     -- spacing size
     spaceSize = 3


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Eog"           --> doCenterFloat
    , className =? "Qt4-ssh-askpass"           --> doCenterFloat
    , className =? "Nautilus"           --> doFloat
    , className =? "Thunderbird" <&&> role =? "3pane" --> doFloat -- Thunderbird main window
    , className =? "Thunderbird" <&&> role =? "Msgcompose" --> doRightFloat -- Thunderbird new message window
    , role =? "mikutter_image_preview"           --> doFloat
    , role =? "bubble"           --> doFloat
    , role =? "pop-up"           --> doFloat
    , appName =? "crx_hmjkmjkepdijhoojdojkdfohbdgmmhki"           --> doFloat -- google keep
    , appName =? "crx_nckgahadagoaajjgafhacjanaoiihapd"           --> doFloat -- google hangouts
    , appName =? "crx_knipolnnllmklapflnccelgolnpehhpl"           --> doFloat -- google hangouts
    , title =? "Pocket" --> doCenterFloat
    , title =? "Ediff"           --> doFloat
    , title =? "Firebug"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]
    where role = stringProperty "WM_WINDOW_ROLE"
          doRightFloat = customFloating $ W.RationalRect (4.5/6) (0.1/6) (1/4) (4.9/5)  -- 左上から x y 幅 高

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = setWMName "LG3D"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad =<< statusBar myBar myPP toggleStrutsKey defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
