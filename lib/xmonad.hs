import           Control.Monad                  ( forM_ )

import           XMonad                  hiding ( config )

import           XMonad.Hooks.EwmhDesktops      ( ewmh
                                                , ewmhDesktopsEventHook
                                                , ewmhDesktopsStartup
                                                )
import           XMonad.Config.Desktop          ( desktopConfig )
import           XMonad.Hooks.ManageDocks       ( docks )
import           XMonad.Layout.Fullscreen       ( fullscreenSupport )

import           XMonad.Hooks.SetWMName         ( setWMName )
import           XMonad.Config.Kde              ( kdeConfig )
import           XMonad.Util.Replace            ( replace )
import           XMonad.Util.Run                ( safeSpawn )

import           Bind.Keys                      ( descrKeys )
import           Bind.Mouse                     ( mouse )

import           Bus.Hooks                      ( hooks )
import           App.Alias
import           Container.Layout               ( layout )

-- config :: XConfig a
config = kdeConfig
  { terminal           = term applications
  , focusFollowsMouse  = True
  , modMask            = mod4Mask
  , workspaces         = show <$> [1 .. 9 :: Int]
  , normalBorderColor  = "#111111"
  , focusedBorderColor = "#000000"
  , mouseBindings      = mouse
  , layoutHook         = layout
  , manageHook         = manageHook kdeConfig <+> hooks
  , handleEventHook    = ewmhDesktopsEventHook
  , startupHook        = ewmhDesktopsStartup >> do
                           setWMName "XMonad"
                           mapM_ spawnAppOnce startup
  }
main :: IO ()
main = do
  replace
  xmonad . docks . ewmh . fullscreenSupport . descrKeys $ config
