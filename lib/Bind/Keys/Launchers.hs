module Bind.Keys.Launchers
  ( launchers
  )
where

import           XMonad                         ( spawn )
import           App.Alias                      ( term
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
  , ("M-o"         , "File Manager"    , fm)
  , ("M-<Return>"  , "Tmux scratchpad" , tmux)
  , ("M-S-<Return>", "Terminal"        , terminal)
  ]
 where
  [launcher, tmux, pass, fm, emacs] =
    map launchScratchpad ["launcher", "tmux", "pass", "file-manager", "emacs"]
  terminal = spawnApp term
