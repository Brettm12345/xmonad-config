module Bind.Keymaps.Windows
  ( windows,
  )
where

import Bind.Keymaps.Internal
  ( Keymap,
    directionKeys,
    directions,
    subKeys,
    zipKeys,
  )
import qualified XMonad
import XMonad (X)
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.FloatKeys (keysMoveWindowTo)
import XMonad.Actions.Navigation2D (Direction2D)
import qualified XMonad.Actions.Navigation2D as Nav2D
import XMonad.Actions.Promote (promote)
import XMonad.Operations (withFocused)
import XMonad.StackSet (RationalRect (..))
import qualified XMonad.StackSet as W

wrapNav :: Bool
wrapNav = True

shouldWrap :: (Direction2D -> Bool -> X ()) -> Direction2D -> X ()
shouldWrap = flip flip wrapNav

center :: RationalRect
center = RationalRect x y w h
  where
    w , h, x, y :: Rational
    w = 3 / 4
    h = 1 / 2
    x = (1 - w) / 2
    y = (1 - h) / 2

windows :: Keymap l
windows =
  subKeys
    "Windows"
    ( [ ("M-w", "Kill", kill1),
        ("M-<Tab>", "Swap window focus up", focusUp),
        ("M-S-<Tab>", "Swap window focus down", focusDown),
        ("M-m", "Focus the master window", focusMaster),
        ("M-g", "Move window to center", toCenter),
        ("M-S-m", "Promote current window to master", promote)
      ]
        <> concatMap
          (zipKeys directionKeys directions)
          [("M-", "Focus window", windowGo), ("M-S-", "Swap window", windowSwap)]
    )
  where
    toCenter = withFocused $ XMonad.windows . flip W.float center
    [focusDown, focusMaster, focusUp] =
      XMonad.windows <$> [W.focusDown, W.focusMaster, W.focusUp]
    [windowGo, windowSwap] = shouldWrap <$> [Nav2D.windowGo, Nav2D.windowSwap]
