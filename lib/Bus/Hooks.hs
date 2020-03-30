module Bus.Hooks
  ( hooks,
  )
where

import App.Scratchpad (manageScratchPads)
import Bus.Queries
  ( hasClass,
    hasRole,
    hasState,
    hasType,
  )
import XMonad
  ( (<+>),
    ManageHook,
    Query,
    doFloat,
    doIgnore,
    idHook,
    whenJust,
  )
import XMonad.Actions.CycleWS
  ( Direction1D (Next, Prev),
    WSType (NonEmptyWS),
    moveTo,
  )
import XMonad.Actions.FindEmptyWorkspace
  ( sendToEmptyWorkspace,
  )
import XMonad.Hooks.InsertPosition
  ( Focus (Newer),
    Position (End, Master),
    insertPosition,
  )
import XMonad.Hooks.ManageDocks (manageDocks)
import XMonad.Hooks.ManageHelpers
  ( (-?>),
    MaybeManageHook,
    composeOne,
    doCenterFloat,
    doFullFloat,
    isDialog,
    isInProperty,
    isKDETrayWindow,
    transience,
  )
import XMonad.ManageHook
  ( doF,
    liftX,
  )

mkHook :: ManageHook -> [Query Bool] -> ManageHook
mkHook = (composeOne .) . fmap . flip (-?>)

handleFloat, handleIgnore, handleCenterFloat, hooks :: ManageHook
handleFloat = mkHook doFloat [hasClass "Places", hasClass "plasmashell"]
handleIgnore =
  mkHook (doCenterFloat >> doIgnore) [hasState "_NET_WM_STATE_SKIP_TASKBAR", isKDETrayWindow]
handleCenterFloat =
  mkHook
    doCenterFloat
    [ hasRole "GtkFileChooserDIalog",
      hasRole "pop-up",
      hasType "_NET_WM_WINDOW_TYPE_SPLASH",
      isDialog
    ]
hooks =
  composeOne [transience, pure True -?> insertPosition Master Newer]
    <+> handleFloat
    <+> handleCenterFloat
    <+> handleIgnore
    <+> manageDocks
    <+> manageScratchPads
