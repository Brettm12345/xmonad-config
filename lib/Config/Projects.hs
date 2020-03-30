module Config.Projects
  ( projects,
  )
where

import App.Alias
  ( browser,
    code,
    spawnApp,
    term,
  )
import XMonad.Actions.DynamicProjects (Project (..))
import XMonad.Layout.LayoutCombinators
  ( JumpToLayout (..),
  )
import XMonad.Operations (sendMessage)

projects :: [Project]
projects =
  [ Project
      { projectName = "web",
        projectDirectory = "~/tmp/dwl",
        projectStartHook = Just $ do
          sendMessage (JumpToLayout "Two Pane")
          spawnApp browser
          spawnApp browser
      },
    Project
      { projectName = "term",
        projectDirectory = "~/",
        projectStartHook = Just $ do
          sendMessage (JumpToLayout "Fullscreen")
          spawnApp term
      },
    Project
      { projectName = "code",
        projectDirectory = "~/",
        projectStartHook = Just $ do
          sendMessage (JumpToLayout "Fullscreen")
          spawnApp code
      }
  ]
