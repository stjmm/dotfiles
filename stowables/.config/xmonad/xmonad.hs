import XMonad
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.ManageDocks

myLayoutHook = avoidStruts $ layoutHook def

myXmobarPP :: PP
myXmobarPP = def
	{ ppCurrent = xmobarColor "#eeeeee" "#005577"
	, ppVisible = xmobarColor "#eeeeee" "#005577"
	, ppHidden = xmobarColor "#bbbbbb" "#222222"
	, ppHiddenNoWindows = xmobarColor "#666666" "#222222"
	}

myStatusBar = statusBarProp "xmobar" (pure myXmobarPP)

myKeys =
	[ ("M-S-<Return>", spawn "alacritty")
	, ("M-S-r", spawn "xmonad --recompile" >> spawn "xmonad --restart")
	]

main = xmonad $  withEasySB myStatusBar defToggleStrutsKey $ def
	{ modMask = mod4Mask
	, terminal = "alacritty"
	, normalBorderColor = "#2b2b2b"
	, focusedBorderColor = "#4c566a"
	, layoutHook = myLayoutHook
	}
	`additionalKeysP` myKeys
