@echo off
setlocal

cd /d "%~dp0"

where cargo >nul 2>nul
if errorlevel 1 (
    echo Error: cargo not found. Install Rust first: https://rustup.rs
    exit /b 1
)

cargo run --release
