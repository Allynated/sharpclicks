# SharpClicks

A CPS-based autoclicker written in Rust, built for accurate click timing.
Started it as a hobby project to learn rust. Currently most of the application IS vibe-coded, but I am still learning regardless!

> **Status:** in testing. Please [report any bugs](https://github.com/Allynated/sharpclicks/issues)!

## Features

- Set clicks per second (CPS) and click duty cycle (CDC, the percentage of each click period the button is held down)
- **Hold** mode (clicks while the trigger is held) and **Toggle** mode (press once to start, again to stop)
- Bind any supported keyboard key or mouse button as the trigger, and choose which mouse button gets clicked
- Save, load and delete named profiles
- Timing calibration at startup to compensate for input overhead

## Platform support

| OS | Status | Notes |
|---|---|---|
| Linux | Supported | **X11 session required.** Global input capture generally does not work under Wayland. |
| Windows | Supported | |
| macOS | Not Supported Yet| ~~Grant the app **Accessibility** (and, if prompted, **Input Monitoring**) permission in System Settings → Privacy & Security.~~ |

### Linux and Wayland

SharpClicks listens for global key and mouse events. Most Wayland sessions block this, so the app may open but won't respond to the trigger. If that happens, log out and choose an **X11** session from the login screen. To check which one you're on:

```bash
echo $XDG_SESSION_TYPE
```

It prints `x11` or `wayland`.

## Install

### Download a release (recommended)

Prebuilt binaries are attached to each [release](https://github.com/Allynated/sharpclicks/releases) when available.

**Linux AppImage:**

```bash
chmod +x SharpClicks-x86_64.AppImage
./SharpClicks-x86_64.AppImage
```

If the AppImage won't start, install `libfuse2` (`sudo apt install libfuse2` on Debian/Ubuntu/Mint), or run it with `--appimage-extract-and-run`.

### Build from source

You need [Rust](https://rustup.rs) installed.

```bash
git clone https://github.com/Allynated/sharpclicks
cd sharpclicks
cargo build --release
```

The binary is written to `target/release/sharpclicks` (`sharpclicks.exe` on Windows). The first build takes a minute or so; later ones are much faster.

You can also use the included scripts, which build and launch the app for you:

```bash
chmod +x run.sh   # Linux/macOS, first time only
./run.sh
```

On Windows, double-click `run.bat`.

#### Linux build dependencies

On Debian, Ubuntu and Mint:

```bash
sudo apt install build-essential pkg-config libx11-dev libxtst-dev libxdo-dev libxkbcommon-dev libxcb1-dev libgl1-mesa-dev
```

Package names differ on other distros. If the build fails on a missing library, install the development package the error names.

## Usage

1. Set the **CPS** and **CDC** values.
2. Pick **Hold** or **Toggle** mode.
3. Click the **Input** button, then press the key or mouse button you want to use as the trigger.
4. Click the **Output** button, then press the mouse button you want SharpClicks to click.
5. Press **Run**. The trigger now controls clicking. Press **Stop** when you're done.

Changing the trigger or output while running stops the clicker, so press **Run** again afterwards.

## Profiles

Profiles are saved as small JSON files in your user data folder, so they survive updates and don't depend on where you run the app from:

| OS | Location |
|---|---|
| Linux | `~/.local/share/sharpclicks/profiles` |
| Windows | `%APPDATA%\sharpclicks\data\profiles` |
| macOS | `~/Library/Application Support/sharpclicks/profiles` |

Each profile stores the CPS, CDC, trigger, output button and click mode. You can back them up or share them by copying the `.json` files.

## Troubleshooting

- **Nothing happens when I press the trigger (Linux):** check that you're on an X11 session, not Wayland (see above).
- **Nothing happens (macOS):** make sure the app has Accessibility permission, then restart it.
- **macOS says the app can't be opened:** the binary is unsigned. Right-click it and choose **Open**, or run `xattr -d com.apple.quarantine ./sharpclicks`.
- **Clicks feel slower than the set CPS:** very high CPS values are limited by how fast your OS accepts input events. Try a lower value.
- **Build error about a missing library (Linux):** see [Linux build dependencies](#linux-build-dependencies).

## Reporting bugs

Please open an [issue](https://github.com/Allynated/sharpclicks/issues) and include your OS and version, whether you're on X11 or Wayland (Linux), and what you expected to happen.

## Acknowledgements

The UI layout was generated with the [egui RAD GUI Builder](https://github.com/timschmidt/egui-rad-builder).
Built with [eframe/egui](https://github.com/emilk/egui), [enigo](https://github.com/enigo-rs/enigo) and [rdev](https://github.com/Narsil/rdev).

## License

MIT License

Copyright (c) 2026 Allyn
