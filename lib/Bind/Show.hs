module Bind.Show
  ( show
  )
where

import           Prelude                 hiding ( show )

import           System.IO                      ( hClose )

import           XMonad                         ( KeyMask
                                                , KeySym
                                                , io
                                                )
import           Bind.Keymaps.Internal          ( Keybind )
import           XMonad.Util.NamedActions       ( NamedAction
                                                , addName
                                                , showKm
                                                )
import           XMonad.Util.Run                ( spawnPipe
                                                , hPutStr
                                                )

show :: [Keybind] -> NamedAction
show x = addName "Show Keybindings" . io $ do
  h <- spawnPipe "yad --text-info"
  hPutStr h (unlines $ showKm x)
  hClose h
  return ()
