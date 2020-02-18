module App.Scratchpad
  ( manageScratchPads
  , launchScratchpad
  )
where

import           Bus.Queries                    ( hasName
                                                , hasClass
                                                )

import           XMonad                         ( ManageHook
                                                , (<&&>)
                                                , X(..)
                                                )
import           XMonad.Hooks.ManageHelpers     ( doFloatDep )
import           XMonad.Util.NamedScratchpad    ( NamedScratchpad(..)
                                                , NamedScratchpads
                                                , namedScratchpadManageHook
                                                , namedScratchpadAction
                                                , customFloating
                                                )


import           XMonad.StackSet                ( RationalRect(..) )

forceCenterFloat :: ManageHook
forceCenterFloat = doFloatDep move
 where
  move :: RationalRect -> RationalRect
  move _ = RationalRect x y w h

  w, h, x, y :: Rational
  w = 15 / 16
  h = 15 / 16
  x = (1 - w) / 2
  y = (1 - h) / 2

makeTermScratch :: (String, String) -> NamedScratchpad
makeTermScratch (name, cmd) = NS
  { name  = name
  , cmd   = "kitty --name='" <> name <> "' -e " <> cmd
  , query = hasClass "kitty" <&&> hasName name
  , hook  = forceCenterFloat
  }

scratchPads :: NamedScratchpads
scratchPads =
  fmap makeTermScratch [("tmux", "tmux")]
    <> [ NS { name  = "file-manager"
            , cmd   = "dolphin"
            , query = hasClass "dolphin"
            , hook  = forceCenterFloat
            }
       , NS { name  = "emacs"
            , cmd   = "emacs"
            , query = hasClass "Emacs"
            , hook  = forceCenterFloat
            }
       ]


launchScratchpad :: String -> X ()
launchScratchpad = namedScratchpadAction scratchPads

manageScratchPads :: ManageHook
manageScratchPads = namedScratchpadManageHook scratchPads
