# Markdown Notes (VS Code style)

A SwiftUI-based iOS + iPadOS app that recreates a Notes-like experience using Markdown syntax (no WYSIWYG). It opens to a blank page, auto-saves notes stamped with the current date/time, and renders them live using VS Code-inspired styling with the Atom One Dark palette.

## Highlights
- **Markdown-first workflow:** Type plain Markdown in a monospaced editor and instantly preview the formatted result.
- **Auto-saving notes:** Each note is timestamped (e.g. `Apr 5, 2024 10:20 AM`) and persisted locally whenever you type.
- **Universal layout:** Adaptive split layout keeps the editor and preview side-by-side on iPad while stacking them vertically on iPhone.
- **VS Code aesthetic:** Custom colors, typography, and rounded surfaces mimic the VS Code feel with the Atom One Dark color scheme.

## Running the project
This repository uses SwiftPM's new `iOSApplication` product type, so you can open it directly in the latest Xcode:

1. `File > Open...` and select the `Package.swift` file.
2. Choose an iOS Simulator (iPhone or iPad) and run.

The app launches straight into a blank note that automatically saves as you type.
