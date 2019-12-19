{-# OPTIONS -fno-warn-missing-signatures #-}
import           Control.Monad                  ( forM_ )

import           XMonad                  hiding ( config )

import           XMonad.Hooks.EwmhDesktops      ( ewmh )
import           XMonad.Config.Desktop          ( desktopConfig )
import           XMonad.Hooks.ManageDocks       ( docks )
import           XMonad.Layout.Fullscreen       ( fullscreenSupport )

import           XMonad.Util.Replace            ( replace )
import           XMonad.Util.Run                ( safeSpawn )

import           Bind.Keys                      ( descrKeys )
import           Bind.Mouse                     ( mouse )

import           Bus.Hooks                      ( hooks )
import           App.Alias
import           Config.Options                 ( theme
                                                , ffm
                                                , mask
                                                , options
                                                , unfocused
                                                , focused
                                                , border
                                                , events
                                                , starts
                                                )
import           Container.Layout               ( layout )
import           System.Taffybar.Support.PagerHints
                                                ( pagerHints )

main :: IO ()
main = do
  replace
  xmonad . pagerHints . docks . ewmh . fullscreenSupport . descrKeys $ config
 where
  config = desktopConfig { terminal           = term applications
                         , focusFollowsMouse  = ffm options
                         , modMask            = mask options
                         , workspaces         = map show [1 .. 9 :: Int]
                         , normalBorderColor  = unfocused theme
                         , focusedBorderColor = focused theme
                         , borderWidth        = border theme
                         , mouseBindings      = mouse
                         , layoutHook         = layout
                         , manageHook         = hooks
                         , handleEventHook    = events options
                         , startupHook        = starts options
                         }
