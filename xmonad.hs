import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "/home/phil/.cabal/bin/xmobar /home/phil/.config/xmobar/xmobarrc"
    xmonad $ docks defaultConfig
        { layoutHook = avoidStruts  $  layoutHook defaultConfig
        , terminal = "kitty"
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask
        , normalBorderColor = "#202020"
        , focusedBorderColor = "#008080"
        , borderWidth = 1
        } `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ,  ((mod4Mask, xK_p), spawn "dmenu_run -nb black -fn 'Terminus-9'") 
        ]