module App.Launcher
  ( appLauncher
  )
where

import           Theme.ChosenTheme



(@@) :: String -> String -> String
r @@ s = r ++ " " ++ "'" ++ s ++ "'"

appLauncher :: String
appLauncher = unwords
  [ "dmenu_run"
  , "-p 'Launch application: '"
  , "-fn" @@ sansserif'
  , "-nb" @@ basebg
  , "-nf" @@ base04
  , "-sb" @@ base14
  , "-sf" @@ base00
  , "-h 52"
  , "-F"
  ]

