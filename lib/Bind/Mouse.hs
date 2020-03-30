module Bind.Mouse
  ( mouse,
  )
where

import Control.Monad (liftM2)
import Data.Map (Map (..))
import qualified Data.Map as Map
import qualified XMonad
import XMonad
  ( Button,
    KeyMask,
    Window,
    X,
    XConfig (..),
    button1,
    button3,
    focus,
    mouseMoveWindow,
    mouseResizeWindow,
    windows,
  )
import XMonad.Actions.FloatSnap
  ( ifClick,
    snapMagicMove,
  )
import XMonad.StackSet (shiftMaster)

type WindowM = Window -> X ()

snapBoundary :: Maybe Int
snapBoundary = Just 50

bindMouse :: WindowM -> WindowM
bindMouse m w = focus w >> m w >> windows shiftMaster

drag :: WindowM
drag =
  liftM2
    (>>)
    mouseMoveWindow
    (ifClick . snapMagicMove snapBoundary snapBoundary)

resize :: WindowM
resize = bindMouse mouseResizeWindow

binds :: XConfig l -> [((KeyMask, Button), WindowM)]
binds XConfig {XMonad.modMask = modMask} =
  [((modMask, button1), drag), ((modMask, button3), resize)]

mouse :: XConfig l -> Map (KeyMask, Button) WindowM
mouse = fmap bindMouse . Map.fromList . binds
