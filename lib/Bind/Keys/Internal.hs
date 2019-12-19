module Bind.Keys.Internal where

import           XMonad                         ( XConfig
                                                , KeyMask
                                                , X
                                                , KeySym
                                                , mod4Mask
                                                , xK_Super_L
                                                )
import           XMonad.Util.NamedActions       ( addName
                                                , subtitle
                                                , NamedAction
                                                )
import           XMonad.Util.EZConfig           ( mkNamedKeymap )

import           XMonad.Layout.WindowNavigation ( Direction2D(D, U, L, R) )

modMask :: KeyMask
modMask = mod4Mask

modSym :: KeySym
modSym = xK_Super_L


transformKey :: (String, String, X ()) -> (String, NamedAction)
transformKey (m, nm, f) = (m, addName nm f)

type Keymap l = XConfig l -> [((KeyMask, KeySym), NamedAction)]

subKeys :: String -> [(String, String, X ())] -> Keymap l
subKeys str ks conf = subtitle str : mkNamedKeymap conf (map transformKey ks)

directions :: [Direction2D]
directions = [D, U, L, R]

zipKeys
  :: [String] -> [b] -> (String, String, b -> X ()) -> [(String, String, X ())]
zipKeys keys args (mask, name, f) =
  [ (mask ++ i, name, f b) | (i, b) <- zip keys args ]

arrowKeys, directionKeys, wsKeys :: [String]
directionKeys = ["j", "k", "h", "l"]
arrowKeys = ["<D>", "<U>", "<L>", "<R>"]
wsKeys = map show [1 .. 9 :: Int]
