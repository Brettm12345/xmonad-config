module Bind.Keymaps.Resize where

import           Bind.Keymaps.Internal          ( subKeys
                                                , Keymap
                                                )
import           XMonad                         ( Resize(Shrink, Expand)
                                                , sendMessage
                                                )





resize :: Keymap l
resize = subKeys "Resize"
                 [("M-[", "Shrink", shrink), ("M-]", "Expand", expand)]
  where [shrink, expand] = sendMessage <$> [Shrink, Expand]
