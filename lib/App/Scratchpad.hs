module App.Scratchpad
  ( manageScratchPads
  , launchScratchpad
  )
where

import           Bus.Queries                    ( hasClass
                                                , hasName
                                                )
import           XMonad                         ( (<&&>)
                                                , ManageHook
                                                , X(..)
                                                )
import           XMonad.Hooks.ManageHelpers     ( doFloatDep
                                                , doFullFloat
                                                )
import           XMonad.StackSet                ( RationalRect(..) )
import           XMonad.Util.NamedScratchpad    ( NamedScratchpad(..)
                                                , NamedScratchpads
                                                , customFloating
                                                , namedScratchpadAction
                                                , namedScratchpadManageHook
                                                )

forceCenterFloat :: ManageHook
forceCenterFloat = doFloatDep move
 where
  move :: RationalRect -> RationalRect
  move _ = RationalRect x y w h
  w, h, x, y :: Rational
  w = 3 / 4
  h = 3 / 4
  x = (1 - w) / 2
  y = (1 - h) / 2

scratchPads :: NamedScratchpads
scratchPads =
  [ NS { name  = "tmux"
       , cmd   = "kitty --name=tmux tmux"
       , query = hasName "tmux"
       , hook  = doFullFloat
       }
  , NS { name  = "file-manager"
       , cmd   = "dolphin"
       , query = hasClass "dolphin"
       , hook  = forceCenterFloat
       }
  , NS { name  = "mpv"
       , cmd   = "~/.nix-profile/bin/mpv /mnt/media/tv"
       , query = hasClass "mpv"
       , hook  = forceCenterFloat
       }
  , NS { name  = "emacs"
       , cmd   = "emacs"
       , query = hasClass "Emacs"
       , hook  = doFullFloat
       }
  ]

launchScratchpad :: String -> X ()
launchScratchpad = namedScratchpadAction scratchPads

manageScratchPads :: ManageHook
manageScratchPads = namedScratchpadManageHook scratchPads
