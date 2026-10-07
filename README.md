# Smooth Shimmer ✨

A high-performance, customizable skeleton loading shimmer effect for Flutter widgets with **zero third-party dependencies**.

Give your placeholder cards, list tiles, profile avatars, and text blocks a modern, silky skeleton sheen.

[![pub package](https://img.shields.io/badge/pub.dev-1.0.0-blue.svg)](https://github.com/Codes-of-NazmuL/smooth_shimmer)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=flutter&logoColor=white)](https://flutter.dev)

---

## ✨ Features

- 🌿 **Zero Dependencies:** Pure Flutter framework (`flutter/material.dart`).
- ⚡️ **GPU Accelerated:** Uses Flutter's native `ShaderMask` with `BlendMode.srcATop` for fluid performance without child layout churn.
- 🌓 **Theme-Aware:** Automatically adapts to dark and light modes with Apple-style subtle grey tones.
- 🧭 **Multi-Directional:** Supports `leftToRight`, `rightToLeft`, `topToBottom`, and `bottomToTop`.
- 🎚️ **Simple Toggle:** Switch between skeleton and live UI using the `enabled` property.
- ♿️ **Accessibility Ready:** Honors `MediaQuery.disableAnimationsOf` for instant static rendering when reduced motion is preferred.
- 🪄 **1-Line Extension:** Just append `.shimmer()` to any Flutter widget.

---

## 📦 Installation

Add `smooth_shimmer` via Git in your `pubspec.yaml`:

```yaml
dependencies:
  smooth_shimmer:
    git:
      url: https://github.com/Codes-of-NazmuL/smooth_shimmer.git
      ref: main
```

Or install from terminal:

```bash
flutter pub add 'smooth_shimmer:{"git":{"url":"https://github.com/Codes-of-NazmuL/smooth_shimmer.git"}}'
```

---

## 🚀 Quick Usage

### 1. Extension Method (Simplest)

```dart
import 'package:flutter/material.dart';
import 'package:smooth_shimmer/smooth_shimmer.dart';

// Single skeleton line:
Container(
  height: 18,
  width: 160,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4),
  ),
).shimmer();

// Skeleton card placeholder:
MyCardPlaceholder().shimmer(
  duration: const Duration(milliseconds: 1200),
);
```

### 2. Widget Wrapper with `enabled` toggle

```dart
SmoothShimmer(
  enabled: isLoading,
  child: isLoading
      ? const SkeletonView()
      : const RealContentView(),
)
```

---

## ⚙️ Customization Options

| Property | Type | Default | Description |
|---|---|---|---|
| `baseColor` | `Color?` | *Theme-aware* | Dark/Light mode adaptive background tone. |
| `highlightColor` | `Color?` | *Theme-aware* | Sheen highlight band color. |
| `duration` | `Duration` | `1500ms` | Duration of one full gradient sweep. |
| `direction` | `ShimmerDirection` | `leftToRight` | Gradient sweep direction. |
| `enabled` | `bool` | `true` | When false, passes through child untouched. |

---

## 👨‍💻 Author & Maintainer

Created with ❤️ by **Nazmul Islam**

- **GitHub:** [@Codes-of-NazmuL](https://github.com/Codes-of-NazmuL)
- **Organization:** Softvence

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
