module App.Alias where
import           XMonad                         ( X
                                                , spawn
                                                )
import           XMonad.Util.SpawnOnce          ( spawnOnce )

data Applications = Applications
    { browser :: !String
    , screenshot :: !String
    , cursor  :: !String
    , notify  :: !String
    , term    :: !String
    , emacs   :: !String
    , code    :: !String
    , projects :: !String
    , passwords :: !String
    , windows :: !String
    , compton :: !String
    , rofi    :: !String
    , wall    :: !String
    , keyrate :: !String
    , xrdb    :: !String
    } deriving (Eq, Show)

applications :: Applications
applications = Applications { browser    = "chromium-snapshot-bin"
                            , screenshot = "flameshot gui"
                            , cursor     = "xsetroot -cursor_name left_ptr"
                            , notify     = "dunst"
                            , emacs      = "emacs"
                            , term       = "konsole"
                            , code       = "code"
                            , rofi       = "rofi -show"
                            , windows    = "rofi -show windows"
                            , passwords  = "rofi-pass"
                            , projects   = "rofi -show projects"
                            , compton    = "compton -b"
                            , wall       = "~/.fehbg"
                            , keyrate    = "xset r rate 300 50"
                            , xrdb       = "xrdb -load ~/.config/xorg/xres"
                            }


spawnAppOnce, spawnApp :: (Applications -> String) -> X ()
[spawnApp, spawnAppOnce] = (. ($ applications)) <$> [spawn, spawnOnce]

startup :: [Applications -> String]
startup = [cursor, notify, wall, xrdb]
