module Bind.Keys.Windows
  ( windows
  )
where
import           XMonad.Actions.Promote         ( promote )
import           Bind.Keys.Internal             ( Keymap
                                                , subKeys
                                                , zipKeys
                                                , directionKeys
                                                , directions
                                                )
import           XMonad.Actions.CopyWindow      ( kill1 )
import qualified XMonad
import           XMonad                         ( X )
import           XMonad.Actions.Navigation2D    ( Direction2D )
import qualified XMonad.StackSet               as W
import qualified XMonad.Actions.Navigation2D   as Nav2D

wrapNav :: Bool
wrapNav = True

shouldWrap :: (Direction2D -> Bool -> X ()) -> Direction2D -> X ()
shouldWrap = flip flip wrapNav


windowGo, windowSwap :: Direction2D -> X ()
windowGo = shouldWrap Nav2D.windowGo
windowSwap = shouldWrap Nav2D.windowSwap

windows :: Keymap l
windows = subKeys
  "Windows"
  (  [ ("M-w"      , "Kill"                            , kill1)
     , ("M-<Tab>"  , "Swap window focus up"            , focusUp)
     , ("M-S-<Tab>", "Swap window focus down"          , focusDown)
     , ("M-m"      , "Focus the master window"         , focusMaster)
     , ("M-S-m"    , "Promote current window to master", promote)
     ]
  ++ concatMap
       (zipKeys directionKeys directions)
       [("M-", "Focus window", windowGo), ("M-S-", "Swap window", windowSwap)]
  )
 where
  [focusDown, focusMaster, focusUp] =
    map XMonad.windows [W.focusDown, W.focusMaster, W.focusUp]