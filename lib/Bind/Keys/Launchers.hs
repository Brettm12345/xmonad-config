module Bind.Keys.Launchers
  ( launchers
  )
where

import           XMonad                         ( spawn )
import           App.Alias                      ( term
                                                , rofi
                                                , spawnApp
                                                )
import           App.Scratchpad                 ( launchScratchpad )
import           Bind.Keys.Internal             ( Keymap
                                                , subKeys
                                                )

import           App.Launcher                   ( appLauncher )

launchers :: Keymap l
launchers = subKeys
  "Launchers"
  [ ("M-d"         , "App Launcher"    , launcher)
  , ("M-p"         , "Password Manager", pass)
  , ("M-e"         , "Emacs"           , emacs)
  , ("M-o"         , "Vscode project"  , vscode)
  , ("M-<Return>"  , "Tmux scratchpad" , tmux)
  , ("M-S-<Return>", "Terminal"        , terminal)
  ]
 where
  [tmux, fm, emacs] = map launchScratchpad ["tmux", "file-manager", "emacs"]
  vscode            = spawn "rofi-vscode"
  pass              = spawn "rofi-pass"
  launcher          = spawnApp rofi
  terminal          = spawnApp term
