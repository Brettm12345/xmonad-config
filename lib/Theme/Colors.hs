module Theme.Colors where
import           Data.Text                      ( Text )
import qualified Data.Yaml                     as Y
import           Data.Yaml                      ( FromJSON(..)
                                                , (.:)
                                                )

-- | See https://github.com/chriskempson/base16
data Theme =
  Theme
  { base00 :: !Text,
    base01 :: !Text,
    base02 :: !Text,
    base03 :: !Text,
    base04 :: !Text,
    base05 :: !Text,
    base06 :: !Text,
    base07 :: !Text,
    base08 :: !Text,
    base09 :: !Text,
    base10 :: !Text,
    base0A :: !Text,
    base0B :: !Text,
    base0C :: !Text,
    base0D :: !Text,
    base0E :: !Text,
    base0F :: !Text
  } deriving (Eq, Show)

instance FromJSON Theme where
  parseJSON (Y.Object v) =
    Theme
      <$> v
      .:  "base00"
      <*> v
      .:  "base01"
      <*> v
      .:  "base02"
      <*> v
      .:  "base03"
      <*> v
      .:  "base04"
      <*> v
      .:  "base05"
      <*> v
      .:  "base06"
      <*> v
      .:  "base07"
      <*> v
      .:  "base08"
      <*> v
      .:  "base09"
      <*> v
      .:  "base10"
      <*> v
      .:  "base0A"
      <*> v
      .:  "base0B"
      <*> v
      .:  "base0C"
      <*> v
      .:  "base0D"
      <*> v
      .:  "base0E"
      <*> v
      .:  "base0F"
  parseJSON _ = fail "Missing config"
