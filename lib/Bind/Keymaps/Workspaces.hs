module Bind.Keymaps.Workspaces
  ( workspaces
  )
where

import qualified XMonad
import           XMonad                         ( X
                                                , WindowSet
                                                , windows
                                                )
import           XMonad.StackSet                ( greedyView
                                                , shift
                                                )

import           XMonad.Actions.CycleWS         ( toggleWS )

import           XMonad.Layout.IndependentScreens
                                                ( VirtualWorkspace
                                                , onCurrentScreen
                                                )


import           Bind.Keymaps.Internal          ( Keymap
                                                , subKeys
                                                , wsKeys
                                                , zipKeys
                                                )



workspaces :: Keymap l
workspaces c = subKeys
  "Workspaces & Projects"
  (("M-a", "Toggle last workspace", toggleWS) : concatMap
    (zipKeys wsKeys ws)
    [("M-", "View ws", windowView), ("M-S-", "Move window to ws", windowMove)]
  )
  c
 where
  ws = XMonad.workspaces c
  getWindows f w = do
    windows $ f w
    return ()
  [windowView, windowMove] = getWindows <$> [greedyView, shift]
