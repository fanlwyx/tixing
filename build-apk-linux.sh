#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
gradle --no-daemon assembleDebug
printf 'APK: %s\n' "$PWD/app/build/outputs/apk/debug/app-debug.apk"
