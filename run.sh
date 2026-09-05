#!/bin/bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
APP="$ROOT/.build/SplitViewWidthRepro.app"

mkdir -p "$APP/Contents/MacOS"
cp "$ROOT/SplitViewWidthRepro/Info.plist" "$APP/Contents/Info.plist"

xcrun swiftc \
    -parse-as-library \
    -framework SwiftUI \
    -framework AppKit \
    "$ROOT/SplitViewWidthRepro/App.swift" \
    -o "$APP/Contents/MacOS/SplitViewWidthRepro"

codesign --force --sign - "$APP"
open "$APP"
