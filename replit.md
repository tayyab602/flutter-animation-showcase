# Flutter Counter App

## Overview
A Flutter counter application with both mobile and web support, built with Dart.

## Project Structure
- `lib/main.dart` - Flutter app source code (for mobile builds via `flutter build`)
- `server/main.dart` - Dart web server that serves the counter app UI on port 5000
- `pubspec.yaml` - Flutter project dependencies
- `analysis_options.yaml` - Dart linting rules

## Tech Stack
- **Language**: Dart 3.10
- **Framework**: Flutter (source code for mobile), Dart HTTP server (web preview)
- **Web Server Port**: 5000

## How It Works
- The Flutter source code in `lib/main.dart` is the standard Flutter counter app with Material 3 design
- The web preview is served by a Dart HTTP server (`server/main.dart`) that renders the same counter UI using HTML/CSS/JS with Material 3 styling
- The Flutter code can be built for mobile platforms using `flutter build apk` or `flutter build ios` in a local environment with Flutter SDK

## Running
- The web preview runs automatically via the "Start application" workflow
- For mobile builds, clone the repo and use `flutter run` locally with Flutter SDK installed
