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

keys :: XConfig l -> [((KeyMask, KeySym), NamedAction)]
keys c =
  launchers c
    ^++^ windows c
    ^++^ workspaces c
    ^++^ layout c
    ^++^ resize c
    ^++^ session c

descrKeys :: XConfig l -> XConfig l
descrKeys = addDescrKeys' ((modMask, xK_F1), Bind.Show.show) keys
