module Bind.Keymaps.Layout
  ( layout,
  )
where

import Bind.Keymaps.Internal
  ( Keymap,
    subKeys,
  )
import XMonad
  ( windows,
    withFocused,
  )
import XMonad.Layout (ChangeLayout (NextLayout))
import XMonad.Layout.LayoutCombinators
  ( JumpToLayout (..),
  )
import XMonad.Layout.Spacing
  ( decScreenWindowSpacing,
    incScreenWindowSpacing,
  )
import XMonad.Operations (sendMessage)
import XMonad.StackSet (sink)

layout :: Keymap l
layout =
  subKeys
    "Layout"
    [ ("M-<Space>", "Cycle between layouts", cycle),
      ("M-=", "Increase window spacing", incSpacing),
      ("M-f", "Open fullscreen", full),
      ("M--", "Decrease window spacing", decSpacing),
      ("M-t", "Tile window", tile)
    ]
  where
    cycle = sendMessage NextLayout
    full = sendMessage $ JumpToLayout "Fullscreen"
    [incSpacing, decSpacing] =
      ($ 1) <$> [incScreenWindowSpacing, decScreenWindowSpacing]
    tile = withFocused $ windows . sink
