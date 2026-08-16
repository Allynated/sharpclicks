#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if ! command -v cargo &> /dev/null; then
    echo "Error: cargo not found. Install Rust first: https://rustup.rs"
    exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    cargo build --release
    codesign --force --deep --sign - target/release/sharpclicks
fi

cargo run --release