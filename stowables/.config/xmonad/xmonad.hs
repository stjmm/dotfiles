import XMonad
import XMonad.Util.EZConfig (additionalKeysP)

myKeys =
	[ ("M-S-<Return>", spawn "alacritty") ]

main = xmonad $ def
	{ modMask = mod4Mask
	, terminal = "alacritty"
	}
	`additionalKeysP` myKeys
