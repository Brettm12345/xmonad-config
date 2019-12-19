-- | XMonad-Aloysius eventLog for polybar
-- | From: https://github.com/polybar/polybar/wiki/User-contributed-module

module Bus.Events
  ( logHook'
  )
where

import           Data.List                      ( sortBy )
import           Data.Function                  ( on )
import           Control.Monad                  ( join )

import           XMonad                         ( X
                                                , gets
                                                , windowset
                                                , description
                                                , io
                                                )
import qualified XMonad.StackSet               as W

import           Theme.ChosenTheme


logHook' :: X ()
logHook' = do
  -- curLayout <- gets (description . W.layout . W.workspace . W.current $ windowset)
  -- curSpaces <- gets (description . W.workspaces . W.currentTag $ windowset)
  winset <- gets windowset

  -- workspaces
  let currWs = W.currentTag winset
  -- blocking named scratchpad appearing
  let wss = filter (/= "NSP") $ map W.tag $ W.workspaces winset
  let wsStr  = join $ map (fmt currWs) $ sort' wss

  -- layout
  let currLt = description . W.layout . W.workspace . W.current $ winset
  let ltStr  = layoutParse currLt

  -- fifo
  io $ appendFile "/tmp/xmonad-ws" (wsStr ++ "\n")
  io $ appendFile "/tmp/xmonad-layout" (ltStr ++ "\n")
 where
  fmt currWs ws
    |
    -- %{T3} changes font to bold in polybar
    -- %{T-} resets it back to font-0
    -- NOTE: Foreground colours also edited here
    -- this block then depends on +THEME+
    -- FIXME: I don't understand why it needs the latter base02, it should
    --        revert back to the base colour (base02) but it does not...
      currWs == ws
    = " [%{F" ++ base06 ++ "}%{T1}" ++ ws ++ "%{T-}%{F" ++ base02 ++ "}] "
    | otherwise
    = "  " ++ ws ++ "  "

  sort' = sortBy (compare `on` (!! 0))
  layoutParse s |  -- 'pretty' printing
                  s == "Three Columns"    = "%{T2}+|+%{T-} TCM "
                | s == "Binary Partition" = "%{T2}||+%{T-} BSP "
                | s == "Tall"             = "%{T2}|||%{T-} Tall"
                | s == "Tabbed"           = "%{T2}___%{T-} Tab "
                | s == "Float"            = "%{T2}+++%{T-} FLT "
                | s == "Fullscreen"       = "%{T2}| |%{T-} Full"
                | otherwise               = s -- fallback for changes in C.Layout
