#!/bin/sh

XMONAD=${XDG_CONFIG_HOME:-$HOME/.config}/xmonad
BUILD=$XMONAD/build

test -d $XMONAD || mkdir -p $XMONAD

echo "Creating build script..."
echo '#!/bin/sh' >"$BUILD"
echo "cd $PWD" >>"$BUILD"
echo 'cp "$(jq -r ".[].result.exe_path" <"$(snack build)")" "$1"' >>"$BUILD"
chmod +x "$BUILD"
echo "Done!"
echo "Now run xmonad --recompile"
