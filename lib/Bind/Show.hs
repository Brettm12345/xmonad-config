module Bind.Show
  ( show,
  )
where

import Bind.Keymaps.Internal (Keybind)
import System.IO (hClose)
import XMonad
  ( KeyMask,
    KeySym,
    io,
  )
import XMonad.Util.NamedActions
  ( NamedAction,
    addName,
    showKm,
  )
import XMonad.Util.Run
  ( hPutStr,
    spawnPipe,
  )
import Prelude hiding (show)

show :: [Keybind] -> NamedAction
show x = addName "Show Keybindings" . io $ do
  h <- spawnPipe "yad --text-info"
  hPutStr h (unlines $ showKm x)
  hClose h
  return ()
