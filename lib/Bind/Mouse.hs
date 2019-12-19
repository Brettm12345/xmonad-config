module Bind.Mouse
  ( mouse
  )
where

import           Data.Map                       ( Map(..) )
import qualified Data.Map                      as Map

import           Control.Monad                  ( liftM2 )
import qualified XMonad
import qualified XMonad.StackSet               as StackSet

import           XMonad.Actions.FloatSnap       ( ifClick
                                                , snapMagicMove
                                                )

import           XMonad                         ( XConfig(..)
                                                , KeyMask
                                                , Button
                                                , Window
                                                , X
                                                , button1
                                                , button3
                                                , windows
                                                , focus
                                                , mouseMoveWindow
                                                , mouseResizeWindow
                                                )


type WindowM = Window -> X ()

snapBoundary :: Maybe Int
snapBoundary = Just 50

bindMouse :: WindowM -> WindowM
bindMouse m w = focus w >> m w >> windows StackSet.shiftMaster

drag :: WindowM
drag = liftM2 (>>)
              mouseMoveWindow
              (ifClick . snapMagicMove snapBoundary snapBoundary)


resize :: WindowM
resize = bindMouse mouseResizeWindow

type MouseBind = ((KeyMask, Button), WindowM)
binds :: XConfig l -> [MouseBind]
binds XConfig { XMonad.modMask = modMask } =
  [((modMask, button1), drag), ((modMask, button3), resize)]


mouse :: XConfig l -> Map (KeyMask, Button) WindowM
mouse = fmap bindMouse . Map.fromList . binds
