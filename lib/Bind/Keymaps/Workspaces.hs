module Bind.Keymaps.Workspaces
  ( workspaces,
  )
where

import Bind.Keymaps.Internal
  ( Keymap,
    subKeys,
    wsKeys,
    zipKeys,
  )
import qualified XMonad
import XMonad
  ( WindowSet,
    X,
    windows,
  )
import XMonad.Actions.CycleWS (toggleWS)
import XMonad.Layout.IndependentScreens
  ( VirtualWorkspace,
    onCurrentScreen,
  )
import XMonad.StackSet
  ( greedyView,
    shift,
  )

workspaces :: Keymap l
workspaces c = subKeys "Workspaces & Projects" (keymap <> navigation) c
  where
    ws = XMonad.workspaces c
    [windowView, windowMove] = (windows .) <$> [greedyView, shift]
    keymap = [("M-a", "Toggle last workspace", toggleWS)]
    navigation =
      concatMap
        (zipKeys wsKeys ws)
        [("M-", "View ws", windowView), ("M-S-", "Move window to ws", windowMove)]
