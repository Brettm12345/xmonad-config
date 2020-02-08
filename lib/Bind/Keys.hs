module Bind.Keys
  ( modMask
  , keys
  , descrKeys
  )
where

import           XMonad                         ( XConfig
                                                , KeyMask
                                                , KeySym
                                                , xK_F1
                                                )
import qualified Bind.Show

import qualified Bind.Keymaps.Internal         as Internal
import           Bind.Keymaps.Internal          ( Keymap
                                                , Keybind
                                                )
import           Bind.Keymaps.Launchers         ( launchers )
import           Bind.Keymaps.Layout            ( layout )
import           Bind.Keymaps.Windows           ( windows )
import           Bind.Keymaps.Session           ( session )
import           Bind.Keymaps.Workspaces        ( workspaces )
import           Bind.Keymaps.Resize            ( resize )

import           XMonad.Util.NamedActions       ( NamedAction
                                                , (^++^)
                                                , addDescrKeys'
                                                )

modMask :: KeyMask
modMask = Internal.modMask

maps :: [Keymap l]
maps = [launchers, windows, workspaces, layout, resize, session]

keys :: Keymap l
keys c = foldl1 (^++^) (($ c) <$> maps)

descrKeys :: XConfig l -> XConfig l
descrKeys = addDescrKeys' ((modMask, xK_F1), Bind.Show.show) keys
