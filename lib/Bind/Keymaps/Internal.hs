module Bind.Keymaps.Internal where

import XMonad
  ( KeyMask,
    KeySym,
    X,
    XConfig,
    mod4Mask,
    xK_Super_L,
  )
import XMonad.Layout.WindowNavigation (Direction2D (D, L, R, U))
import XMonad.Util.EZConfig (mkNamedKeymap)
import XMonad.Util.NamedActions
  ( NamedAction,
    addName,
    subtitle,
  )

modMask :: KeyMask
modMask = mod4Mask

modSym :: KeySym
modSym = xK_Super_L

transformKey :: (String, String, X ()) -> (String, NamedAction)
transformKey (m, nm, f) = (m, addName nm f)

type Keybind = ((KeyMask, KeySym), NamedAction)

type Keymap l = XConfig l -> [Keybind]

subKeys :: String -> [(String, String, X ())] -> Keymap l
subKeys str ks conf = subtitle str : mkNamedKeymap conf (fmap transformKey ks)

directions :: [Direction2D]
directions = [D, U, L, R]

zipKeys ::
  [String] -> [b] -> (String, String, b -> X ()) -> [(String, String, X ())]
zipKeys keys args (mask, name, f) =
  [(mask <> i, name, f b) | (i, b) <- zip keys args]

arrowKeys, directionKeys, wsKeys :: [String]
directionKeys = ["j", "k", "h", "l"]
arrowKeys = ["<D>", "<U>", "<L>", "<R>"]
wsKeys = show <$> [1 .. 9 :: Int]
