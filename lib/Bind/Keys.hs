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
import           Bind.Keys.Internal             ( Keymap )
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



addKeymap
  :: XConfig l -> Keymap l -> Keymap l -> [((KeyMask, KeySym), NamedAction)]
addKeymap c a b = a c ^++^ b c


keys :: XConfig l -> [((KeyMask, KeySym), NamedAction)]
keys c = foldl1 (^++^) $ fmap c [layout, windows, workspaces]


descrKeys :: XConfig l -> XConfig l
descrKeys = addDescrKeys' ((modMask, xK_F1), Bind.Show.show) keys
