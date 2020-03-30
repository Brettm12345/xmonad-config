#!/bin/sh

# XMONAD=${XDG_CONFIG_HOME:-$HOME/.config}/xmonad
XMONAD=$HOME/.xmonad
BUILD=$XMONAD/build

test -d "$XMONAD" || mkdir -p "$XMONAD"

echo "Creating build script..."
echo '#!/bin/sh' >"$BUILD"
echo "rm ~/.xmonad/xmonad*"
echo "cd $PWD" >>"$BUILD"
echo 'cp -fu "$(jq -r ".[].result.exe_path" <"$(snack build)")" "$1"' >>"$BUILD"
chmod +x "$BUILD"
echo "Done!"
echo "Now run xmonad --recompile"
