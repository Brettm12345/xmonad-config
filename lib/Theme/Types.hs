module Theme.Types where

data Colors
  = Colors
      { basebg :: String,
        basefg :: String,
        base00 :: String,
        base01 :: String,
        base02 :: String,
        base03 :: String,
        base04 :: String,
        base05 :: String,
        base06 :: String,
        base07 :: String,
        base08 :: String,
        base09 :: String,
        base10 :: String,
        base11 :: String,
        base12 :: String,
        base13 :: String,
        base14 :: String,
        base15 :: String
      }
  deriving (Read, Show, Eq)

data Fonts
  = Fonts
      { size :: Int,
        sansserif :: String,
        monospace :: String
      }
  deriving (Read, Show, Eq)
