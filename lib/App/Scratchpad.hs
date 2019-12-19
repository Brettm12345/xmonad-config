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
  w = 2 / 3
  h = 3 / 4
  x = (1 - w) / 2
  y = (1 - h) / 2

makeTermScratch :: (String, String) -> NamedScratchpad
makeTermScratch (name, cmd) = NS
  { name  = name
  , cmd   = "termite -e " ++ cmd ++ " --name=" ++ name
  , query = hasClass "Termite" <&&> hasName name
  , hook  = forceCenterFloat
  }

scratchPads :: NamedScratchpads
scratchPads =
  map
      makeTermScratch
      [ ("tmux"    , "tmux")
      , ("launcher", "~/bin/sk-apps")
      , ("pass"    , "~/bin/sk-pass")
      ]
    ++ [ NS { name  = "file-manager"
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
