
module Bind.Keymaps.Windows
  ( windows
  )
where


import           XMonad.Actions.FloatKeys       ( keysMoveWindowTo )
import           XMonad.Actions.Promote         ( promote )
import           Bind.Keymaps.Internal          ( Keymap
                                                , subKeys
                                                , zipKeys
                                                , directionKeys
                                                , directions
                                                )
import           XMonad.Actions.CopyWindow      ( kill1 )
import qualified XMonad
import           XMonad                         ( X )
import           XMonad.Operations              ( withFocused )
import           XMonad.Actions.Navigation2D    ( Direction2D )
import qualified XMonad.StackSet               as W
import qualified XMonad.Actions.Navigation2D   as Nav2D

wrapNav :: Bool
wrapNav = True

shouldWrap :: (Direction2D -> Bool -> X ()) -> Direction2D -> X ()
shouldWrap = flip flip wrapNav


windows :: Keymap l
windows = subKeys
  "Windows"
  (  [ ("M-w"      , "Kill"                            , kill1)
     , ("M-<Tab>"  , "Swap window focus up"            , focusUp)
     , ("M-S-<Tab>", "Swap window focus down"          , focusDown)
     , ("M-m"      , "Focus the master window"         , focusMaster)
     , ("M-g"      , "Move window to center"           , toCenter)
     , ("M-S-m"    , "Promote current window to master", promote)
     ]
  <> concatMap
       (zipKeys directionKeys directions)
       [("M-", "Focus window", windowGo), ("M-S-", "Swap window", windowSwap)]
  )
 where
  toCenter = withFocused $ XMonad.windows . flip W.float center
    where center = W.RationalRect (1 / 8) (1 / 8) (15 / 16) (15 / 16)
  [focusDown, focusMaster, focusUp] =
    XMonad.windows <$> [W.focusDown, W.focusMaster, W.focusUp]
  [windowGo, windowSwap] = shouldWrap <$> [Nav2D.windowGo, Nav2D.windowSwap]

