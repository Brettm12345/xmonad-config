-- |

module Bind.Master where

import           System.Exit

import           XMonad
import           XMonad.Actions.FloatKeys
import           XMonad.Actions.CopyWindow      ( kill1 )
import           XMonad.Actions.WindowBringer
import           XMonad.Actions.WithAll
import           XMonad.Hooks.ManageDocks       ( ToggleStruts(..) )

import           XMonad.Layout.AvoidFloats
import           XMonad.Layout.LayoutCombinators
                                         hiding ( (|||) )

import           XMonad.Prompt.XMonad

import           XMonad.Util.Dmenu              ( dmenuMap )
import           XMonad.Util.Scratchpad
import           XMonad.Util.Ungrab

import qualified Data.Map                      as M
import qualified XMonad.Actions.FlexibleManipulate
                                               as F
import qualified XMonad.Actions.Search         as S
import qualified XMonad.StackSet               as W

-- local
import           App.Alias
import           App.Launcher
import           Bind.Util  -- replaces EZConfig, adds <S>
import           Config.Options
import           Theme.ChosenTheme


-- Keymaps ----------------------------------------------------------------------



-- default keymap
defaultKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
defaultKeys c =
  mkKeymap c
    $  [ ("<S> <Return>", spawnApp term)
       , ("<S> <Space>" , sendMessage NextLayout)
       , ("<S> <Tab>"   , windows W.focusDown)
       , ("<S> S-<Tab>" , windows W.focusUp)
       , ( "<S> p"
         , spawn appLauncher
         )
       -- , ( "<S> `"
       --   , scratchpadSpawnActionCustom scratch applications
       --   )

  -- APPLICATIONS --
       , ("<S> a q", kill1)
       , ("<S> a f", spawnApp browser)
       , ( "<S> a e"
         , spawnApp code
         )


  -- window manipulation
       , ("<S> w g", gotoMenuArgs $ dmenuTheme base12 "Go to window:  ")
       , ("<S> w b", bringMenuArgs $ dmenuTheme base12 "Bring window:  ")
       , ("<S> g"  , withFocused $ keysMoveWindow (0, 0))
       , ("<S> w h", sendMessage Shrink)
       , ("<S> w l", sendMessage Expand)
       , ("<S> w .", sendMessage $ IncMasterN 1)
       , ("<S> w ,", sendMessage $ IncMasterN (-1))
       , ("<S> w m", windows W.focusMaster)
       , ("<S> w h", windows $ W.swapUp . W.focusUp)
       , ("<S> w l", windows $ W.swapDown . W.focusDown)
       , ( "<S> w t"
         , sinkAll
         ) -- maybe: withFocused $ windows . W.sink
       , ("<S> w f", sendMessage AvoidFloatToggle)
       , ( "<S> w s"
         , sendMessage ToggleStruts
         )


  -- SESSION --
       , ("<S> q r", broadcastMessage ReleaseResources >> restart "xmonad" True)
       , ("<S> q q", io exitSuccess)
       , ( "<S> q m"
         , unGrab >> powerMenu
         )


  -- PROMPTS --
       , ( "<S> / /"
         , xmonadPromptC actions promptConfig
         )

  -- media keys
       , ("<XF86AudioPlay>"       , spawn "playerctl play-pause")
       , ("<XF86AudioStop>"       , spawn "playerctl stop")
       , ("<XF86AudioNext>"       , spawn "playerctl next")
       , ("<XF86AudioPrev>"       , spawn "playerctl previous")
       , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume 0 -5%")
       , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume 0 +5%")
       , ("<XF86AudioMute>"       , spawn "pactl set-sink-mute 0 toggle")
       ]
    ++

  -- search engine submap
       [ ("<S> / s " ++ k, S.selectSearch f) | (k, f) <- searchList ]
    ++ [ ("<S> / p " ++ k, S.promptSearch promptConfig f)
       | (k, f) <- searchList
       ]
  -- standard jumping around workspaces etc.
  -- @end keys

-- Menu for less common actions
actions :: [(String, X ())]
actions =
  [ ("increaseM"   , sendMessage (IncMasterN 1))
  , ("decreaseM"   , sendMessage (IncMasterN (-1)))
  , ("toggleStruts", sendMessage ToggleStruts)
  , ("kill"        , kill1)
  ]



-- search engine submap, starts with M-s (selected) and M-S-s (prompt)
searchList :: [(String, S.SearchEngine)]
searchList = [("g", S.duckduckgo), ("h", S.hoogle), ("w", S.wikipedia)]


------------------------------------------------------------------------

-- Mouse bindings: default actions bound to mouse events
mouseBindings' :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
mouseBindings' XConfig { XMonad.modMask = modm } = M.fromList
    -- mod-button1, flexible linear scale
  [ ( (mod4Mask, button1)
    , \w -> focus w >> F.mouseWindow F.discrete w
    )
    -- mod-button2, Raise the window to the top of the stack
  , ( (mod4Mask, button2)
    , \w -> focus w >> windows W.shiftMaster
    )
    -- mod-button3, Set the window to floating mode and resize by dragging
  , ( (mod4Mask, button3)
    , \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster
    )
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]
