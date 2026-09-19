## 2.0.0

* **Standard Scaffold Integration**:
  * Added full support for `drawer`, `endDrawer`, `onDrawerChanged`, and `onEndDrawerChanged`.
  * Added `bottomSheet`, `persistentFooterButtons`, and `persistentFooterAlignment`.
  * Added `extendBody`, `extendBodyBehindAppBar`, `primary`, and `restorationId`.
  * Added standard `resizeToAvoidBottomInset` (with backward-compatible `@Deprecated` alias `bottomInstance`).
  * Added standard `bottomNavigationBar` (with backward-compatible `@Deprecated` alias `bottomNav`).

* **Modern Background & Visual Features**:
  * Added automatic dark mode detection via ambient `Theme.of(context).brightness`.
  * Added `gradient`, `lightGradient`, and `darkGradient` support for seamless background transitions.
  * Added `backgroundDecoration` for complete custom `BoxDecoration` styling.
  * Added `darkBackgroundImage`, `lightBackgroundImage`, and `backgroundImage` for custom `ImageProvider` objects.
  * Added frosted glassmorphism effect support via `blurSigma` and `blurColor`.
  * Added smooth background animation via `animateThemeChange`, `animationDuration`, and `animationCurve`.

* **Productivity & Layout Utilities**:
  * Added built-in loading overlay state via `isLoading`, `loadingWidget`, and `loadingOverlayColor`.
  * Added fine-grained `SafeArea` support with `useSafeArea`, `safeAreaTop`, `safeAreaBottom`, `safeAreaLeft`, `safeAreaRight`, and `safeAreaMinimum`.
  * Added responsive `maxWidth` and `contentAlignment` for tablet and web layouts.

* **Documentation & Maintenance**:
  * Added full Dartdoc coverage for all public symbols and parameters.
  * Updated SDK constraints to Dart `^3.1.0` and Flutter `>=3.10.0`.
  * Added pub `topics` for improved package discoverability.
  * Corrected repository URL.
  * Expanded widget test coverage across all features.

## 1.0.3
- Add missing Features like:
  * floatingActionButtonLocation
  * resizeToAvoidBottomInset
  * And Appbar color to transparent 

## 1.0.2
- Fix version issue.

## 1.0.1
- Fix some known issue and well documented.

## 1.0.0
- Initial release of CustomScaffold with support for dark and light themes, 
background images, and a flexible layout.
