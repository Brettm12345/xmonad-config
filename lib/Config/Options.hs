-- | XMonad-Aloysius setup

module Config.Options where

import           Data.Monoid

import           XMonad
import           XMonad.Actions.UpdatePointer

import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.SetWMName

import           XMonad.Layout.Tabbed

import           XMonad.Util.Font

import qualified XMonad.Prompt                 as P

import           App.Alias
import           Theme.ChosenTheme


-- data declarations ------------------------------------------------------------
-- general XMonad theme settings
data XMTheme = XMTheme
  { foreground :: String
  , background :: String
  , highlight  :: String
  , focused    :: String
  , unfocused  :: String
  , border     :: Dimension
  }



-- preferences ------------------------------------------------------------------
data Options = Options
  { ffm        :: Bool
  , mask       :: KeyMask
  , events     :: Event  -> X All
  , starts     :: X ()
  }

options :: Options
options = Options
  { ffm    = True
  , mask   = mod4Mask
  , events = ewmhDesktopsEventHook
  , starts = ewmhDesktopsStartup >> do
               setWMName "XMonad"
               mapM_ spawnAppOnce startup
  }


-- Theming related options ------------------------------------------------------
theme :: XMTheme
theme = XMTheme { highlight  = base00
                , background = base00
                , foreground = base04
                , focused    = "#000000"
                , unfocused  = "#111111"
                , border     = 1
                }


promptConfig :: P.XPConfig
promptConfig = P.def { P.fgColor           = base04
                     , P.bgColor           = basebg
                     , P.font              = sansserif
                     , P.promptBorderWidth = 0
                     , P.height            = 52
                     , P.defaultText       = " "
                     , P.historySize       = 0
                     , P.maxComplRows      = Just 0
                     , P.position          = P.Top
                     }


dmenuTheme :: String -> String -> [String]
dmenuTheme colour s =
  [ "-fn"
  , sansserif'
  , "-nb"
  , basebg
  , "-nf"
  , base04
  , "-sf"
  , base00
  , "-sb"
  , colour
  , "-h"
  , "52"
  , "-p"
  , s
  ]


tabTheme :: Theme
tabTheme = def { activeColor         = base00
               , activeBorderColor   = base00
               , activeTextColor     = base06
               , inactiveColor       = basebg
               , inactiveBorderColor = basebg
               , inactiveTextColor   = base03
               , urgentColor         = basebg
               , urgentBorderColor   = basebg
               , urgentTextColor     = base12
               , fontName            = sansserif
               , decoHeight          = 52
               }


decoTheme :: Theme
decoTheme = def { activeColor         = "#000000"
                , activeBorderColor   = basebg
                , activeTextColor     = base06
                , inactiveColor       = basebg
                , inactiveBorderColor = basebg
                , inactiveTextColor   = base03
                , urgentColor         = basebg
                , urgentBorderColor   = basebg
                , urgentTextColor     = base12
                , fontName            = "xft:Iosevka Nerd Font:size=12"
                , windowTitleAddons   = [("\xf005", AlignRightOffset 12)]
                , decoHeight          = 40
                , decoWidth           = 3440
                }
