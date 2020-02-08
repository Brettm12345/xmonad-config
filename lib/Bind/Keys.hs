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

import qualified Bind.Keys.Internal            as Internal
import           Bind.Keys.Internal             ( Keymap
                                                , Keybind
                                                )
import           Bind.Keys.Launchers            ( launchers )
import           Bind.Keys.Layout               ( layout )
import           Bind.Keys.Windows              ( windows )
import           Bind.Keys.Session              ( session )
import           Bind.Keys.Workspaces           ( workspaces )
import           Bind.Keys.Resize               ( resize )

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
