import App.Alias
  ( applications,
    term,
  )
import Bind.Keys (descrKeys)
import Bind.Mouse (mouse)
import Bus.Hooks (hooks)
import Config.Projects (projects)
import Container.Layout (layout)
import Control.Monad (forM_)
import XMonad hiding (config)
import XMonad.Actions.DynamicProjects (dynamicProjects)
import XMonad.Config.Desktop (desktopConfig)
import XMonad.Config.Kde (kdeConfig)
import XMonad.Hooks.EwmhDesktops
  ( ewmh,
    ewmhDesktopsEventHook,
    ewmhDesktopsStartup,
  )
import XMonad.Hooks.InsertPosition
  ( Focus (Newer),
    Position (End, Master),
    insertPosition,
  )
import XMonad.Hooks.ManageDocks (docks)
import XMonad.Hooks.Minimize (minimizeEventHook)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.Fullscreen (fullscreenSupport)
import XMonad.Util.Replace (replace)
import XMonad.Util.Run (safeSpawn)

-- config :: XConfig a
config =
  kdeConfig
    { terminal = term applications,
      focusFollowsMouse = True,
      modMask = mod4Mask,
      workspaces = show <$> [1 .. 9 :: Int],
      normalBorderColor = "#111111",
      focusedBorderColor = "#000000",
      mouseBindings = mouse,
      layoutHook = layout,
      manageHook = insertPosition Master Newer <+> manageHook kdeConfig <+> hooks,
      handleEventHook = ewmhDesktopsEventHook <+> minimizeEventHook,
      startupHook = ewmhDesktopsStartup >> do
        setWMName "XMonad"
        mapM_ spawnAppOnce startup
    }

main :: IO ()
main = do
  replace
  xmonad
    . dynamicProjects projects
    . docks
    . ewmh
    . fullscreenSupport
    . descrKeys
    $ config
