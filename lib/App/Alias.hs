-- | Personal 'programs as functions' list

module App.Alias where
import           XMonad                         ( X
                                                , spawn
                                                )
import           XMonad.Util.SpawnOnce          ( spawnOnce )

data Applications = Applications
    { browser :: !String
    , cursor  :: !String
    , notify  :: !String
    , term    :: !String
    , emacs   :: !String
    , code    :: !String
    , pass    :: !String
    , bar     :: !String
    , compton :: !String
    , rofi    :: !String
    , wall    :: !String
    , keyrate :: !String
    , xrdb    :: !String
    } deriving (Eq, Show)

applications :: Applications
applications = Applications { browser = "chromium-snapshot-bin"
                            , cursor  = "xsetroot -cursor_name left_ptr"
                            , notify  = "dunst"
                            , emacs   = "emacs"
                            , term    = "termite"
                            , code    = "code"
                            , rofi    = "rofi -show"
                            , pass    = "rofi-pass"
                            , bar     = "taffybar"
                            , compton = "compton -b"
                            , wall    = "~/.fehbg"
                            , keyrate = "xset r rate 300 50"
                            , xrdb    = "xrdb -load ~/.config/xorg/xres"
                            }


spawnAppOnce :: (Applications -> String) -> X ()
spawnAppOnce app = spawnOnce $ app applications

spawnApp :: (Applications -> String) -> X ()
spawnApp app = spawn $ app applications

startup :: [Applications -> String]
startup = [cursor, notify, wall, xrdb, bar, browser, code]
