module Bus.Queries
  ( hasProperty
  , hasRole
  , hasType
  , hasState
  , hasClass
  , hasName
  )
where

import           XMonad                         ( Query
                                                , className
                                                , stringProperty
                                                , appName
                                                , (=?)
                                                )


hasProperty :: String -> String -> Query Bool
hasProperty = (=?) . stringProperty

hasRole, hasType, hasState, hasClass, hasName :: String -> Query Bool
[hasRole, hasType, hasState] =
  hasProperty <$> ["WM_WINDOW_ROLE", "_NET_WM_WINDOW_TYPE", "_NET_WM_STATE"]
[hasClass, hasName] = (=?) <$> [className, appName]
