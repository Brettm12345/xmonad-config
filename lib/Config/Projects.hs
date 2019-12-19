module Config.Projects
  ( projects
  )
where

import           XMonad.Operations              ( sendMessage )
import           XMonad.Actions.DynamicProjects ( Project(..) )
import           XMonad.Layout.LayoutCombinators
                                                ( JumpToLayout(..) )

import           App.Alias                      ( spawnApp
                                                , browser
                                                , term
                                                , code
                                                )

projects :: [Project]
projects =
  [ Project
    { projectName      = "web"
    , projectDirectory = "~/tmp/dwl"
    , projectStartHook = Just $ do
                           sendMessage (JumpToLayout "Two Pane")
                           spawnApp browser
                           spawnApp browser
    }
  , Project
    { projectName      = "term"
    , projectDirectory = "~/"
    , projectStartHook = Just $ do
                           sendMessage (JumpToLayout "Three Columns")
                           spawnApp term
                           spawnApp term
                           spawnApp term
    }
  , Project
    { projectName      = "code"
    , projectDirectory = "~/"
    , projectStartHook = Just $ do
                           sendMessage (JumpToLayout "Fullscreen")
                           spawnApp code
    }
  ]
