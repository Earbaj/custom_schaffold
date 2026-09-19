// lib/custom_scaffold.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A modern, customizable scaffold widget that extends the functionality of the standard [Scaffold].
///
/// Features include:
/// * Automatic dark/light theme detection via `Theme.of(context).brightness`.
/// * Custom background image assets, [ImageProvider]s, gradients, and full [BoxDecoration] support.
/// * Frosted glassmorphism blur effects using [blurSigma] and [blurColor].
/// * Built-in loading overlay state via [isLoading] and [loadingWidget].
/// * Configurable [SafeArea] controls ([useSafeArea], [safeAreaTop], etc.).
/// * Responsive content width constraints ([maxWidth]) for tablet and web platforms.
/// * Standard [Scaffold] property forwarding ([drawer], [endDrawer], [bottomSheet], [persistentFooterButtons], etc.).
/// * Smooth background transition animations via [animateThemeChange].
class CustomScaffold extends StatelessWidget {
  /// The primary content widget displayed in the scaffold body.
  final Widget child;

  /// Determines if dark mode styling should be manually forced.
  ///
  /// If `null` (default), the theme mode is automatically detected from the ambient
  /// [ThemeData.brightness] via `Theme.of(context).brightness == Brightness.dark`.
  final bool? isDark;

  /// Background color of the scaffold.
  ///
  /// If a background image, gradient, or [backgroundDecoration] is active,
  /// this defaults to [Colors.transparent] to allow the decoration to shine through.
  final Color? backgroundColor;

  /// An app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// A button displayed floating above the body, typically a [FloatingActionButton].
  final Widget? floatingActionButton;

  /// Responsible for determining where the [floatingActionButton] should go within the scaffold.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Animator to move the [floatingActionButton] to a new [floatingActionButtonLocation].
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// A list of buttons displayed at the bottom of the scaffold.
  final List<Widget>? persistentFooterButtons;

  /// The alignment of the [persistentFooterButtons] inside the [OverflowBar].
  final AlignmentDirectional persistentFooterAlignment;

  /// A panel displayed to the side of the [body], typically accessed via swipe or icon.
  final Widget? drawer;

  /// Optional callback that is called when the [drawer] is opened or closed.
  final DrawerCallback? onDrawerChanged;

  /// A panel displayed to the opposite side of [drawer].
  final Widget? endDrawer;

  /// Optional callback that is called when the [endDrawer] is opened or closed.
  final DrawerCallback? onEndDrawerChanged;

  /// A bottom navigation bar to display at the bottom of the scaffold.
  final Widget? bottomNavigationBar;

  /// Deprecated alias for [bottomNavigationBar].
  @Deprecated(
      'Use bottomNavigationBar instead. Will be removed in future versions.')
  final Widget? bottomNav;

  /// The persistent bottom sheet to display.
  final Widget? bottomSheet;

  /// If true the [child] and floating widgets should size themselves to avoid the onscreen keyboard.
  final bool? resizeToAvoidBottomInset;

  /// Deprecated alias for [resizeToAvoidBottomInset].
  @Deprecated(
      'Use resizeToAvoidBottomInset instead. Will be removed in future versions.')
  final bool? bottomInstance;

  /// Whether this scaffold is being displayed at the top of the screen.
  final bool primary;

  /// Configuration of drag start behavior for drawers.
  final DragStartBehavior drawerDragStartBehavior;

  /// If true, and [bottomNavigationBar] or [persistentFooterButtons] is specified,
  /// then the [child] extends to the bottom of the Scaffold.
  final bool extendBody;

  /// If true, and an [appBar] is specified, then the height of the [child] extends
  /// behind the app bar.
  final bool extendBodyBehindAppBar;

  /// The color to use for the scrim that obscures the primary content while a drawer is open.
  final Color? drawerScrimColor;

  /// The width of the area within which a horizontal swipe will open the drawer.
  final double? drawerEdgeDragWidth;

  /// Determines if the [drawer] can be opened with a drag gesture.
  final bool drawerEnableOpenDragGesture;

  /// Determines if the [endDrawer] can be opened with a drag gesture.
  final bool endDrawerEnableOpenDragGesture;

  /// Restoration ID to save and restore the state of the [Scaffold].
  final String? restorationId;

  /// Empty space to surround the [child] content.
  final EdgeInsetsGeometry? padding;

  /// Asset path for the background image to display in dark mode.
  final String? darkBackgroundAsset;

  /// Asset path for the background image to display in light mode.
  final String? lightBackgroundAsset;

  /// Custom [ImageProvider] for dark mode background.
  final ImageProvider? darkBackgroundImage;

  /// Custom [ImageProvider] for light mode background.
  final ImageProvider? lightBackgroundImage;

  /// Custom [ImageProvider] used regardless of theme when dark/light specific providers are omitted.
  final ImageProvider? backgroundImage;

  /// How the background image should be inscribed into the background box. Defaults to [BoxFit.cover].
  final BoxFit backgroundFit;

  /// How to align the background image within its bounds. Defaults to [Alignment.center].
  final AlignmentGeometry backgroundAlignment;

  /// A background gradient applied across the body.
  final Gradient? gradient;

  /// Gradient applied when dark mode is active.
  final Gradient? darkGradient;

  /// Gradient applied when light mode is active.
  final Gradient? lightGradient;

  /// Complete custom decoration for the background container.
  /// If provided, this overrides individual background image and gradient properties.
  final BoxDecoration? backgroundDecoration;

  /// Gaussian blur sigma applied over the background to create a frosted glassmorphism effect.
  final double? blurSigma;

  /// Tint overlay color combined with [blurSigma] for glassmorphic design.
  final Color? blurColor;

  /// When `true`, displays a loading overlay on top of the scaffold body.
  final bool isLoading;

  /// Custom widget to display when [isLoading] is `true`. Defaults to [CircularProgressIndicator.adaptive].
  final Widget? loadingWidget;

  /// Background overlay color when [isLoading] is `true`. Defaults to [Colors.black26].
  final Color? loadingOverlayColor;

  /// Whether to wrap [child] in a [SafeArea]. Defaults to `false`.
  final bool useSafeArea;

  /// Whether to avoid system intrusions at the top of the screen when [useSafeArea] is `true`.
  final bool safeAreaTop;

  /// Whether to avoid system intrusions at the bottom of the screen when [useSafeArea] is `true`.
  final bool safeAreaBottom;

  /// Whether to avoid system intrusions on the left when [useSafeArea] is `true`.
  final bool safeAreaLeft;

  /// Whether to avoid system intrusions on the right when [useSafeArea] is `true`.
  final bool safeAreaRight;

  /// Minimum padding to apply when [useSafeArea] is `true`.
  final EdgeInsets safeAreaMinimum;

  /// Optional maximum width constraint for the content, centering the layout on large screens.
  final double? maxWidth;

  /// Alignment of content when [maxWidth] is applied. Defaults to [Alignment.topCenter].
  final AlignmentGeometry contentAlignment;

  /// Whether to animate transitions when background decoration changes (e.g. on theme toggle).
  final bool animateThemeChange;

  /// Duration for the background transition animation when [animateThemeChange] is `true`.
  final Duration animationDuration;

  /// Curve for the background transition animation when [animateThemeChange] is `true`.
  final Curve animationCurve;

  /// An optional [GlobalKey] to access the underlying [ScaffoldState].
  final GlobalKey<ScaffoldState>? scaffoldKey;

  /// Creates a [CustomScaffold] widget.
  const CustomScaffold({
    super.key,
    this.scaffoldKey,
    required this.child,
    this.isDark,
    this.backgroundColor,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    @Deprecated(
        'Use bottomNavigationBar instead. Will be removed in future versions.')
    this.bottomNav,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    @Deprecated(
        'Use resizeToAvoidBottomInset instead. Will be removed in future versions.')
    this.bottomInstance,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.padding,
    this.darkBackgroundAsset,
    this.lightBackgroundAsset,
    this.darkBackgroundImage,
    this.lightBackgroundImage,
    this.backgroundImage,
    this.backgroundFit = BoxFit.cover,
    this.backgroundAlignment = Alignment.center,
    this.gradient,
    this.darkGradient,
    this.lightGradient,
    this.backgroundDecoration,
    this.blurSigma,
    this.blurColor,
    this.isLoading = false,
    this.loadingWidget,
    this.loadingOverlayColor,
    this.useSafeArea = false,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.safeAreaLeft = true,
    this.safeAreaRight = true,
    this.safeAreaMinimum = EdgeInsets.zero,
    this.maxWidth,
    this.contentAlignment = Alignment.topCenter,
    this.animateThemeChange = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIsDark =
        isDark ?? (Theme.of(context).brightness == Brightness.dark);

    // Resolve ImageProvider based on theme
    ImageProvider? imageProvider;
    if (effectiveIsDark) {
      if (darkBackgroundImage != null) {
        imageProvider = darkBackgroundImage;
      } else if (darkBackgroundAsset != null) {
        imageProvider = AssetImage(darkBackgroundAsset!);
      } else if (backgroundImage != null) {
        imageProvider = backgroundImage;
      }
    } else {
      if (lightBackgroundImage != null) {
        imageProvider = lightBackgroundImage;
      } else if (lightBackgroundAsset != null) {
        imageProvider = AssetImage(lightBackgroundAsset!);
      } else if (backgroundImage != null) {
        imageProvider = backgroundImage;
      }
    }

    // Resolve Gradient based on theme
    final Gradient? effectiveGradient = effectiveIsDark
        ? (darkGradient ?? gradient)
        : (lightGradient ?? gradient);

    // Build effective background decoration
    final BoxDecoration effectiveDecoration = backgroundDecoration ??
        BoxDecoration(
          color: backgroundColor,
          gradient: effectiveGradient,
          image: imageProvider != null
              ? DecorationImage(
                  image: imageProvider,
                  fit: backgroundFit,
                  alignment: backgroundAlignment,
                )
              : null,
        );

    final bool hasCustomDecoration = backgroundDecoration != null ||
        effectiveGradient != null ||
        imageProvider != null;

    // Build the content tree
    Widget content = child;

    if (useSafeArea) {
      content = SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        left: safeAreaLeft,
        right: safeAreaRight,
        minimum: safeAreaMinimum,
        child: content,
      );
    }

    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: content,
      );
    }

    if (maxWidth != null) {
      content = Align(
        alignment: contentAlignment,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth!),
          child: content,
        ),
      );
    }

    // Apply frosted glassmorphism blur if requested
    if (blurSigma != null && blurSigma! > 0) {
      content = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurSigma!,
            sigmaY: blurSigma!,
          ),
          child: Container(
            color: blurColor ?? Colors.transparent,
            width: double.infinity,
            height: double.infinity,
            child: content,
          ),
        ),
      );
    }

    // Wrap in animated or static container for background styling
    final Widget backgroundContainer = animateThemeChange
        ? AnimatedContainer(
            duration: animationDuration,
            curve: animationCurve,
            decoration: effectiveDecoration,
            width: double.infinity,
            height: double.infinity,
            child: content,
          )
        : Container(
            decoration: effectiveDecoration,
            width: double.infinity,
            height: double.infinity,
            child: content,
          );

    // Wrap in loading overlay if isLoading is true
    final Widget effectiveBody = isLoading
        ? Stack(
            children: [
              backgroundContainer,
              Positioned.fill(
                child: Container(
                  color: loadingOverlayColor ?? Colors.black26,
                  child: Center(
                    child: loadingWidget ??
                        const CircularProgressIndicator.adaptive(),
                  ),
                ),
              ),
            ],
          )
        : backgroundContainer;

    @pragma('vm:prefer-inline')
    final bool? effectiveResizeToAvoidBottomInset =
        resizeToAvoidBottomInset ?? bottomInstance;

    @pragma('vm:prefer-inline')
    final Widget? effectiveBottomNav = bottomNavigationBar ?? bottomNav;

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      body: effectiveBody,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      persistentFooterAlignment: persistentFooterAlignment,
      drawer: drawer,
      onDrawerChanged: onDrawerChanged,
      endDrawer: endDrawer,
      onEndDrawerChanged: onEndDrawerChanged,
      bottomNavigationBar: effectiveBottomNav,
      bottomSheet: bottomSheet,
      backgroundColor:
          hasCustomDecoration ? Colors.transparent : backgroundColor,
      resizeToAvoidBottomInset: effectiveResizeToAvoidBottomInset,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      restorationId: restorationId,
    );
  }
}
