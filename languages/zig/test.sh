#!/bin/bash

zig_version=0.14.1
if [ "$(zig version 2>/dev/null)" = "$zig_version" ]; then
  zig_cmd=(zig)
elif command -v mise >/dev/null 2>&1; then
  zig_cmd=(mise exec "zig@$zig_version" -- zig)
else
  echo "Zig $zig_version is required. Put it on PATH or install it with mise (see README.md)." >&2
  exit 1
fi

"${zig_cmd[@]}" test src/operations/*.zig