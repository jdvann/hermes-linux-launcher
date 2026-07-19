#!/usr/bin/env bash
# Hermes Desktop launcher — starts the bundled Electron app with --no-sandbox.
#
# Why --no-sandbox? The packaged chrome-sandbox SUID helper (mode 4755, owned
# by root) cannot survive being zipped and extracted by a non-root user, so we
# run Electron with --no-sandbox. This is the standard, safe way to run Electron
# on a single-user Linux desktop. Do NOT run this as root for day-to-day use.
set -u

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
EXE="$SCRIPT_DIR/linux-unpacked/Hermes"

if [ ! -x "$EXE" ]; then
  echo "✗ Hermes binary not found: $EXE" >&2
  echo "  Make sure linux-unpacked/Hermes was extracted next to this script." >&2
  exit 1
fi

# Directory desktop chat sessions start in (defaults to where you invoke it).
export HERMES_DESKTOP_CWD="${HERMES_DESKTOP_CWD:-$PWD}"

# The app auto-discovers the `hermes` CLI on your PATH. If you want to point it
# at a specific Hermes source tree instead, set it here:
# export HERMES_DESKTOP_HERMES_ROOT=/path/to/hermes-agent

# Disable GPU only if you hit rendering issues on a headless/remote display:
# export HERMES_DESKTOP_DISABLE_GPU=1

exec "$EXE" --no-sandbox "$@"
