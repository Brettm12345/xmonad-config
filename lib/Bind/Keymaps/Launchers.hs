module Bind.Keymaps.Launchers
  ( launchers
  )
where

import           XMonad                         ( spawn )
import           App.Alias                      ( term
                                                , projects
                                                , passwords
                                                , rofi
                                                , spawnApp
                                                , screenshot
                                                )
import           App.Scratchpad                 ( launchScratchpad )
import           Bind.Keymaps.Internal          ( Keymap
                                                , subKeys
                                                )

launchers :: Keymap l
launchers = subKeys
  "Launchers"
  [ ("M-d"         , "App Launcher"    , launcher)
  , ("M-p"         , "Password Manager", pass)
  , ("M-e"         , "Emacs"           , emacs)
  , ("M-o"         , "Vscode project"  , vscode)
  , ("M-<Return>"  , "Tmux scratchpad" , tmux)
  , ("M-S-<Return>", "Terminal"        , terminal)
  , ("<Print>"     , "Screenshot"      , shot)
  ]
 where
  [tmux, emacs] = launchScratchpad <$> ["tmux", "emacs"]
  [launcher, terminal, shot, vscode, pass] =
    spawnApp <$> [rofi, term, screenshot, projects, passwords]
