{-# OPTIONS -fno-warn-missing-signatures #-}

module Container.Layout
  ( layout
  )
where

import           XMonad                         ( (|||) )
import           XMonad.Layout                  ( Full(..) )
import           XMonad.Hooks.ManageDocks       ( avoidStruts )

import           XMonad.Layout.Decoration       ( shrinkText )
import           XMonad.Layout.BinarySpacePartition
                                                ( emptyBSP )
import           XMonad.Layout.Fullscreen       ( fullscreenFull )
import           XMonad.Layout.IfMax            ( IfMax(..) )
import qualified XMonad.Layout.Named           as N
import           XMonad.Layout.NoBorders        ( noBorders
                                                , smartBorders
                                                )
import           XMonad.Layout.ResizableTile    ( ResizableTall(..) )
import           XMonad.Layout.TwoPane          ( TwoPane(..) )
import           XMonad.Layout.ThreeColumns     ( ThreeCol(ThreeColMid) )
import           Theme.Gaps                     ( space
                                                , spaceBig
                                                , spaceSmall
                                                )


-- No type definitions because I can't figure out how to simplify it

full = N.named "Fullscreen" $ noBorders (fullscreenFull Full)
handleFull = (. IfMax 1 full) . N.named
named s = handleFull s . space
namedSmall s = handleFull s . spaceSmall
layout = avoidStruts . smartBorders $ layouts
 where
  bsp     = named "Binary Partition" $ emptyBSP
  tcm     = named "Three Columns" $ ThreeColMid 1 (3 / 100) (1 / 2)
  twp     = namedSmall "Two Pane" $ TwoPane (3 / 100) (1 / 2)
  tall    = namedSmall "Tall" $ ResizableTall 1 (2 / 100) (1 / 2) []
  layouts = twp ||| tcm ||| bsp ||| tall ||| full
