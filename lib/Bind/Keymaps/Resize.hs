module Bind.Keymaps.Resize where

import Bind.Keymaps.Internal
  ( Keymap,
    subKeys,
  )
import XMonad
  ( Resize (Expand, Shrink),
    sendMessage,
  )
import XMonad.Actions.FloatKeys (keysResizeWindow)
import XMonad.Operations (withFocused)

resize :: Keymap l
resize =
  subKeys
    "Resize"
    [ ("M-[", "Shrink", shrink),
      ("M-]", "Expand", expand),
      ("M-S-[", "Floating shrink", floatingShrink),
      ("M-S-]", "Floating expand", floatingExpand)
    ]
  where
    [shrink, expand] = sendMessage <$> [Shrink, Expand]
    bottomRight = (1, 0)
    floatingExpand = withFocused $ keysResizeWindow (10, 10) bottomRight
    floatingShrink = withFocused $ keysResizeWindow (10, 10) bottomRight
