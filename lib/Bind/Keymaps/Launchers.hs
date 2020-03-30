module Bind.Keymaps.Launchers
  ( launchers,
  )
where

import App.Alias
  ( openProject,
    passwords,
    rofi,
    screenshot,
    spawnApp,
    term,
  )
import App.Scratchpad (launchScratchpad)
import Bind.Keymaps.Internal
  ( Keymap,
    subKeys,
  )

launchers :: Keymap l
launchers =
  subKeys
    "Launchers"
    [ ("M-d", "App Launcher", launcher),
      ("M-p", "Password Manager", pass),
      ("M-v", "Mpv", mpv),
      ("M-i", "File Manager", fileManager),
      ("M-e", "Emacs", emacs),
      ("M-o", "Vscode project", vscode),
      ("M-<Return>", "Tmux scratchpad", tmux),
      ("M-S-<Return>", "Terminal", terminal),
      ("<Print>", "Screenshot", shot)
    ]
  where
    [tmux, emacs, mpv, fileManager] =
      launchScratchpad <$> ["tmux", "emacs", "mpv", "file-manager"]
    [launcher, terminal, shot, vscode, pass] =
      spawnApp <$> [rofi, term, screenshot, openProject, passwords]
