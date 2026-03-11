# Animation Showcase App

## Overview
A Flutter/Dart animation showcase application featuring multiple Lottie animations and custom CSS/JS animations. Built as a professor assignment to demonstrate various animation techniques.

## Project Structure
- `lib/main.dart` - Flutter app source code (for mobile builds via `flutter build`)
- `server/main.dart` - Dart web server that serves the animation showcase on port 5000
- `assets/` - Lottie JSON animation files
  - `background.json` - Hero background looping animation
  - `cat.json` - Cat playing character animation
  - `loading.json` - Loading spinner animation
  - `sample.json` - Sample multi-layer animation
  - `rocket.json` - Rocket launch animation
  - `confetti.json` - Confetti celebration animation
  - `galaxy.json` - Fireworks display animation
- `pubspec.yaml` - Flutter project dependencies
- `analysis_options.yaml` - Dart linting rules

## Features
- **Loading Screen** - Lottie-powered loading animation on startup
- **Hero Section** - Animated background with gradient text and scroll indicator
- **10 Lottie Animations** in two sections:
  - *Lottie Animations* (professor-provided): Background loop, cat character, loading spinner, sample motion
  - *Custom Lottie Animations*: Confetti celebration, fireworks display, fluid wave, globe visualization, data flow, starfield
- **12 Custom CSS Animations** - Bounce, Pulse, Spin, Shake, Morph, 3D Flip, Wave, Neon Glow, Slide & Scale, Stagger, Typewriter, Ripple
- **Interactive Playground** - Real-time animation switcher with 6 effects (Bounce, Spin, Pulse, Wobble, Jello, 3D Flip)
- **Floating Particles** - Background particle effect
- **Scroll Reveal** - Elements animate in on scroll via IntersectionObserver
- **Stats Counter** - Animated number counters

## Tech Stack
- **Language**: Dart 3.10
- **Framework**: Flutter (source code for mobile), Dart HTTP server (web preview)
- **Animation Library**: Lottie (lottie-web via CDN)
- **Web Server Port**: 5000

## Running
- The web preview runs automatically via the "Start application" workflow
- For mobile builds, clone the repo and use `flutter run` locally with Flutter SDK installed
