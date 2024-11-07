// lib/custom_scaffold.dart
import 'package:flutter/material.dart';

/// A custom scaffold widget that extends the functionality of the standard [Scaffold] widget.
/// This widget allows for additional customization such as background image support,
/// light and dark mode assets, and flexible padding.

class CustomScaffold extends StatelessWidget {
  /// The primary content of the scaffold.
  final Widget child;

  /// Determines if the dark mode background should be displayed.
  /// If `true`, the `darkBackgroundAsset` image will be used.
  final bool isDark;

  /// The background color of the scaffold. Defaults to `Colors.white` if not specified.
  final Color? backgroundColor;

  /// The app bar widget displayed at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// A floating action button displayed above the body of the scaffold.
  final Widget? floatingActionButton;

  /// Padding around the main body of the scaffold.
  final EdgeInsetsGeometry? padding;

  /// The widget displayed at the bottom of the scaffold, typically a [BottomNavigationBar].
  final Widget? bottomNav;

  /// Asset path for the background image to display in dark mode.
  /// If [isDark] is `true`, this image will be displayed as the background.
  final String? darkBackgroundAsset;

  /// Asset path for the background image to display in light mode.
  /// If [isDark] is `false`, this image will be displayed as the background.
  final String? lightBackgroundAsset;

  ///Determine if the bottom instance resizable or not [bottomInstanceResize]
  final bool bottomInstance;

  ///Determine if the floating button positions [floatingbuttonPositions]
  final FloatingActionButtonLocation floatingActionButtonLocation;

  /// Creates a [CustomScaffold] widget.
  ///
  /// [child] is required and represents the main content of the scaffold.
  ///
  /// Other parameters are optional, providing flexibility in scaffold customization.
  const CustomScaffold({
    super.key,
    required this.child,
    this.isDark = true,
    this.backgroundColor,
    this.appBar,
    this.floatingActionButton,
    this.padding,
    this.bottomNav,
    this.darkBackgroundAsset,
    this.lightBackgroundAsset,
    this.bottomInstance = true,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? Colors.transparent,
      body: Container(
        padding: padding,
        decoration: BoxDecoration(
          image: darkBackgroundAsset != null || lightBackgroundAsset != null
              ? DecorationImage(
                  image: AssetImage(
                    isDark ? darkBackgroundAsset! : lightBackgroundAsset!,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: child,
      ),
      bottomNavigationBar: bottomNav,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: bottomInstance,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
