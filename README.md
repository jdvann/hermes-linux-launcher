# Hermes Desktop for Linux

A **prebuilt, portable** build of the [Hermes Agent](https://github.com/NousResearch/hermes-agent)
native desktop app (Electron) for **Linux x64** — packaged as a single self-contained ZIP.

No `npm install`, no build step. Unzip and run.

## Preview

![Hermes Desktop running on Linux](Screenshot%20from%202026-07-19%2014-10-54.png)

## Download

Get the latest release from the **Releases** page:

👉 https://github.com/jdvann/hermes-linux-launcher/releases/latest

The asset `hermes-desktop-linux.zip` (~133 MB) bundles the full Electron runtime,
Chromium, Node.js, and all native libraries.

## Quick start

```bash
# download from the releases page, then:
unzip hermes-desktop-linux.zip
cd hermes-desktop-linux
chmod +x launch.sh
./launch.sh
```

Requirements:

- A graphical display (X11 or Wayland).
- The `hermes` CLI on your `PATH` — the desktop app drives the same agent core
  as the CLI. Install Hermes Agent first (`pip install hermes-agent` or the
  official installer) and confirm with `hermes --version`.
- Standard Linux desktop libraries (present on any normal desktop). If the app
  fails to start with a "missing shared library" error, install Electron's
  runtime deps via your package manager (see below).

## Why `--no-sandbox`?

The packaged `chrome-sandbox` SUID helper (mode `4755`, owned by root) cannot
survive being zipped and extracted by a non-root user, so `launch.sh` runs
Electron with `--no-sandbox`. This is the standard, safe way to run Electron on
a single-user Linux desktop.

To restore the real Chromium sandbox after extraction, run as root:

```bash
sudo chown root:root linux-unpacked/chrome-sandbox
sudo chmod 4755 linux-unpacked/chrome-sandbox
```

…then edit `launch.sh` to drop the `--no-sandbox` flag.

## Runtime dependencies (only if needed)

On Debian/Ubuntu:

```bash
sudo apt-get update && sudo apt-get install -y \
  libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 libcups2 \
  libdrm2 libdbus-1-3 libexpat1 libgbm1 libgtk-3-0 libasound2 \
  libx11-6 libxcomposite1 libxcursor1 libxdamage1 libxext6 \
  libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
  libpango-1.0-0 libcairo2 libatspi2.0-0
```

On Fedora/RHEL:

```bash
sudo dnf install -y nss nspr atk at-spi2-atk cups-libs libdrm \
  dbus-libs expat mesa-libgbm gtk3 alsa-lib libX11 libXcomposite \
  libXcursor libXdamage libXext libXfixes libXi libXrandr libXrender \
  libXScrnSaver libXtst pango cairo at-spi2-core
```

## Repository layout

| File | Purpose |
|------|---------|
| `README.md` | This file |
| `launch.sh` | Wrapper that starts the bundled app with `--no-sandbox` |
| `hermes-desktop-linux.zip` | **Downloadable release asset** (not committed — see Releases) |

The actual application lives in the ZIP asset on the
[Releases](https://github.com/jdvann/hermes-linux-launcher/releases) page, since
it is ~133 MB (over GitHub's 100 MB file limit for the repo tree).

## Build info

- App version: **v0.18.2**
- Electron: **40.10.2**
- Platform: **linux-x64**

Built from the Hermes Agent `apps/desktop` → `linux-unpacked` target.
