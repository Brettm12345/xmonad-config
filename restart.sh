#!/bin/sh

eval "$(jq -r ".[].result.exe_path" <"$(snack build)") --restart"
