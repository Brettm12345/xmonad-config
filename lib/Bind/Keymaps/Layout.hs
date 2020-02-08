module Bind.Keymaps.Layout
  ( layout
  )
where

import           XMonad                         ( withFocused
                                                , windows
                                                )
import           XMonad.StackSet                ( sink )
import           XMonad.Layout                  ( ChangeLayout(NextLayout) )
import           XMonad.Layout.LayoutCombinators
                                                ( JumpToLayout(..) )
import           XMonad.Layout.Spacing          ( incScreenWindowSpacing
                                                , decScreenWindowSpacing
                                                )
import           XMonad.Operations              ( sendMessage )
import           Bind.Keymaps.Internal          ( subKeys
                                                , Keymap
                                                )

layout :: Keymap l
layout = subKeys
  "Layout"
  [ ("M-<Space>", "Cycle between layouts"  , cycle)
  , ("M-="      , "Increase window spacing", incSpacing)
  , ("M-f"      , "Open fullscreen"        , full)
  , ("M--"      , "Decrease window spacing", decSpacing)
  , ("M-t"      , "Tile window"            , tile)
  ]
 where
  cycle = sendMessage NextLayout
  full  = sendMessage $ JumpToLayout "Fullscreen"
  [incSpacing, decSpacing] =
    ($ 1) <$> [incScreenWindowSpacing, decScreenWindowSpacing]
  tile = withFocused $ windows . sink
