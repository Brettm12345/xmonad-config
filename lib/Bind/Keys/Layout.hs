module Bind.Keys.Layout
  ( layout
  )
where

import           XMonad                         ( withFocused
                                                , windows
                                                )
import           XMonad.StackSet                ( sink )
import           XMonad.Layout                  ( ChangeLayout(NextLayout) )
import           XMonad.Layout.Spacing          ( incScreenWindowSpacing
                                                , decScreenWindowSpacing
                                                )
import           XMonad.Operations              ( sendMessage )
import           Bind.Keys.Internal             ( subKeys
                                                , Keymap
                                                )

layout :: Keymap l
layout = subKeys
  "Layout"
  [ ("M-<Space>", "Cycle between layouts"  , cycle)
  , ("M-="      , "Increase window spacing", incSpacing)
  , ("M--"      , "Decrease window spacing", decSpacing)
  , ("M-t"      , "Tile window"            , tile)
  ]
 where
  cycle      = sendMessage NextLayout
  incSpacing = incScreenWindowSpacing 1
  decSpacing = decScreenWindowSpacing 1
  tile       = withFocused $ windows . sink
