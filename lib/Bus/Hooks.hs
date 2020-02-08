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
                                                , (<+>)
                                                )

import           XMonad.Hooks.InsertPosition    ( insertPosition
                                                , Position(End)
                                                , Focus(Newer)
                                                )
import           XMonad.Hooks.ManageDocks
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
  composeOne [transience, pure True -?> insertPosition End Newer]
    <+> handleFloat
    <+> handleCenterFloat
    <+> handleIgnore
    <+> manageDocks
    <+> manageScratchPads
