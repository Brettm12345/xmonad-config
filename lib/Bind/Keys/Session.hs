module Bind.Keys.Session
  ( session
  )
where

import           Bind.Keys.Internal             ( subKeys
                                                , Keymap
                                                )

import           System.Exit                    ( exitSuccess )
import           XMonad.Core                    ( io
                                                , LayoutMessages
                                                  ( ReleaseResources
                                                  )
                                                )
import           XMonad.Operations              ( broadcastMessage
                                                , restart
                                                )

session :: Keymap l
session = subKeys
  "Session"
  [("M-q", "Quit XMonad", quit), ("M-r", "Restart XMonad", res)]
 where
  quit = io exitSuccess
  res  = broadcastMessage ReleaseResources >> restart "xmonad" True
