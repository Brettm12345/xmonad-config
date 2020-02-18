module Bus.Hooks
  ( hooks
  )
where

import           App.Scratchpad                 ( manageScratchPads )
import           Bus.Queries                    ( hasRole
                                                , hasType
                                                , hasState
                                                , hasClass
                                                )

import           XMonad                         ( Query
                                                , ManageHook
                                                , doFloat
                                                , doIgnore
                                                , idHook
                                                , whenJust
                                                , (<+>)
                                                )

import           XMonad.Actions.CycleWS         ( moveTo
                                                , WSType(NonEmptyWS)
                                                , Direction1D(Next, Prev)
                                                )


import           XMonad.Actions.FindEmptyWorkspace
                                                ( sendToEmptyWorkspace )
import           XMonad.Hooks.InsertPosition    ( insertPosition
                                                , Position(End, Master)
                                                , Focus(Newer)
                                                )
import           XMonad.Hooks.ManageDocks       ( manageDocks )
import           XMonad.ManageHook              ( doF
                                                , liftX
                                                )
import           XMonad.Hooks.ManageHelpers     ( MaybeManageHook
                                                , (-?>)
                                                , composeOne
                                                , doCenterFloat
                                                , isInProperty
                                                , doFullFloat
                                                , isDialog
                                                , transience
                                                )



mkHook :: ManageHook -> [Query Bool] -> ManageHook
mkHook = (composeOne .) . fmap . flip (-?>)


handleFloat, handleIgnore, handleCenterFloat, hooks :: ManageHook
handleFloat = mkHook doFloat [hasClass "Places", hasClass "plasmashell"]
handleIgnore =
  mkHook (doCenterFloat >> doIgnore) [hasState "_NET_WM_STATE_SKIP_TASKBAR"]
handleCenterFloat = mkHook
  doCenterFloat
  [ hasRole "GtkFileChooserDIalog"
  , hasRole "pop-up"
  , hasType "_NET_WM_WINDOW_TYPE_SPLASH"
  , isDialog
  ]

hooks =
  composeOne [transience, pure True -?> insertPosition Master Newer]
    <+> handleFloat
    <+> handleCenterFloat
    <+> handleIgnore
    <+> manageDocks
    <+> manageScratchPads
