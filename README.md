# CustomScaffold

[![pub package](https://img.shields.io/pub/v/custom_scaffold.svg)](https://pub.dev/packages/custom_scaffold)
[![pub points](https://img.shields.io/pub/points/custom_scaffold?color=blue)](https://pub.dev/packages/custom_scaffold/score)
[![pub likes](https://img.shields.io/pub/likes/custom_scaffold)](https://pub.dev/packages/custom_scaffold)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

A modern, highly customizable `Scaffold` widget for Flutter. It seamlessly extends Flutter's standard `Scaffold` with automatic dark/light theme switching, gradient and asset backgrounds, frosted glassmorphism blur effects, built-in loading overlays, responsive screen constraints, and fine-grained `SafeArea` management.

---

## 🌟 Features

- 🌓 **Automatic Dark / Light Mode Detection**: Automatically switches background styles based on ambient `Theme.of(context).brightness`, with optional manual overrides.
- 🎨 **Multi-style Backgrounds**: Full support for background image assets, any custom `ImageProvider`, linear/radial gradients, and custom `BoxDecoration`.
- 🧊 **Frosted Glassmorphism**: Built-in backdrop blur with customizable `blurSigma` and `blurColor`.
- ⏳ **Loading Overlay**: Toggle full-screen loading states effortlessly using `isLoading: true` and optional custom `loadingWidget`.
- 📐 **Responsive & Safe**: Bounded `maxWidth` for tablet and web layouts, plus individual control over `SafeArea` edges (top, bottom, left, right).
- 🔄 **Smooth Animated Transitions**: Animate background changes between themes with `animateThemeChange: true`.
- 🧰 **Full Scaffold Interoperability**: Direct support for `drawer`, `endDrawer`, `bottomSheet`, `persistentFooterButtons`, `extendBody`, `extendBodyBehindAppBar`, and all standard `Scaffold` properties.

---

## 📦 Installation

Add `custom_scaffold` to your Flutter project:

```bash
flutter pub add custom_scaffold
```

Or add it manually to your `pubspec.yaml`:

```yaml
dependencies:
  custom_scaffold: ^2.0.0
```

---

## 🚀 Usage Recipes

### 1. Automatic Theme Background (Images or Assets)

`CustomScaffold` automatically detects system dark/light themes without needing boilerplate theme-checking logic:

```dart
import 'package:flutter/material.dart';
import 'package:custom_scaffold/custom_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('My App'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      lightBackgroundAsset: 'assets/light_bg.png',
      darkBackgroundAsset: 'assets/dark_bg.png',
      child: const Center(
        child: Text('Hello Flutter!'),
      ),
    );
  }
}
```

### 2. Gradient Background

Easily create vibrant backgrounds using Flutter `Gradient`s:

```dart
CustomScaffold(
  gradient: const LinearGradient(
    colors: [Colors.deepPurple, Colors.indigo, Colors.blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  child: const Center(
    child: Text('Gradient Scaffold', style: TextStyle(color: Colors.white)),
  ),
);
```

### 3. Frosted Glassmorphism Effect

Apply backdrop Gaussian blur over your background decoration:

```dart
CustomScaffold(
  lightBackgroundAsset: 'assets/wallpaper.jpg',
  blurSigma: 15.0,
  blurColor: Colors.black.withOpacity(0.2),
  child: Center(
    child: Card(
      color: Colors.white.withOpacity(0.15),
      child: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Text('Frosted Glass Content', style: TextStyle(color: Colors.white)),
      ),
    ),
  ),
);
```

### 4. Built-in Loading Overlay

Show a modal loading overlay when asynchronous operations are in flight:

```dart
CustomScaffold(
  isLoading: isSubmitting,
  loadingOverlayColor: Colors.black45,
  loadingWidget: const CircularProgressIndicator(color: Colors.white),
  child: YourFormWidget(),
);
```

### 5. Responsive Web / Tablet Centering

Constrain your content width on larger displays with `maxWidth`:

```dart
CustomScaffold(
  maxWidth: 680,
  useSafeArea: true,
  child: ListView(
    children: [
      Text('Content centered on tablet/web screens!'),
    ],
  ),
);
```

### 6. Standard Scaffold Features (Drawers, Bottom Sheet, etc.)

```dart
CustomScaffold(
  appBar: AppBar(title: const Text('Scaffold Features')),
  drawer: const Drawer(
    child: Center(child: Text('Side Navigation')),
  ),
  endDrawer: const Drawer(
    child: Center(child: Text('End Drawer')),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  ),
  bottomNavigationBar: BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
  ),
  child: const Center(child: Text('Scaffold with full navigation')),
);
```

---

## 🎨 Property Reference

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | **required** | The primary content widget. |
| `isDark` | `bool?` | `null` | Force dark/light mode. If `null`, auto-detects from theme. |
| `backgroundColor` | `Color?` | `null` | Background color fallback. |
| `gradient` | `Gradient?` | `null` | General background gradient. |
| `lightGradient` / `darkGradient` | `Gradient?` | `null` | Theme-specific gradients. |
| `backgroundDecoration` | `BoxDecoration?` | `null` | Complete custom container decoration. |
| `lightBackgroundAsset` / `darkBackgroundAsset` | `String?` | `null` | Asset image paths for light/dark modes. |
| `lightBackgroundImage` / `darkBackgroundImage` | `ImageProvider?` | `null` | Custom image providers (e.g. NetworkImage). |
| `blurSigma` | `double?` | `null` | Gaussian blur strength for glassmorphism. |
| `blurColor` | `Color?` | `null` | Tint color applied over the blur. |
| `isLoading` | `bool` | `false` | Displays full-screen loading overlay when true. |
| `loadingWidget` | `Widget?` | `CircularProgressIndicator` | Custom loading indicator widget. |
| `loadingOverlayColor` | `Color?` | `Colors.black26` | Barrier color behind the loader. |
| `useSafeArea` | `bool` | `false` | Wraps content in a `SafeArea`. |
| `maxWidth` | `double?` | `null` | Bounds maximum width on tablet/web. |
| `animateThemeChange` | `bool` | `false` | Enables smooth background transitions. |
| `drawer` / `endDrawer` | `Widget?` | `null` | Navigation drawer widgets. |
| `bottomNavigationBar` | `Widget?` | `null` | Standard bottom navigation bar. |
| `resizeToAvoidBottomInset` | `bool?` | `true` | Sizes body to avoid virtual keyboard. |
| `extendBodyBehindAppBar` | `bool` | `false` | Extends body background behind top AppBar. |

---

## 🔄 Migration from v1.x to v2.0.0

- **`bottomInstance` -> `resizeToAvoidBottomInset`**: `bottomInstance` is now deprecated. Use standard `resizeToAvoidBottomInset`.
- **`bottomNav` -> `bottomNavigationBar`**: `bottomNav` is deprecated in favor of standard `bottomNavigationBar`.
- **`isDark` defaults to auto-detect**: In v1.x, `isDark` defaulted to `true`. In v2.0.0, if omitted it automatically checks `Theme.of(context).brightness`. Pass `isDark: true` or `isDark: false` only if you wish to override the ambient theme.

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).

---

## 💬 Issues & Contributions

Contributions, bug reports, and feature suggestions are always welcome! Feel free to open an issue or pull request on [GitHub](https://github.com/Earbaj/custom_scaffold).
