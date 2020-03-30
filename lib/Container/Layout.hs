{-# OPTIONS -fno-warn-missing-signatures #-}

module Container.Layout
  ( layout,
  )
where

import Theme.Gaps
  ( space,
    spaceBig,
    spaceSmall,
  )
import XMonad ((|||))
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Layout (Full (..))
import XMonad.Layout.BinarySpacePartition
  ( emptyBSP,
  )
import XMonad.Layout.Decoration (shrinkText)
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.IfMax (IfMax (..))
import XMonad.Layout.LayoutHints (layoutHints)
import XMonad.Layout.Minimize (minimize)
import XMonad.Layout.Named (named)
import XMonad.Layout.NoBorders
  ( noBorders,
    smartBorders,
  )
import XMonad.Layout.ResizableTile (ResizableTall (..))
import XMonad.Layout.ThreeColumns (ThreeCol (ThreeColMid))
import XMonad.Layout.TwoPane (TwoPane (..))

-- No type definitions because I can't figure out how to simplify it
layout =
  layoutHints . avoidStruts . IfMax 1 full . smartBorders . minimize $ layouts
  where
    full = named "Fullscreen" $ noBorders (fullscreenFull Full)
    tcm = space . named "Three Columns" $ ThreeColMid 1 (3 / 100) (1 / 2)
    twp = spaceSmall . named "Two Pane" $ TwoPane (3 / 100) (1 / 2)
    tall = spaceSmall . named "Tall" $ ResizableTall 1 (2 / 100) (1 / 2) []
    layouts = twp ||| tcm ||| tall ||| full
