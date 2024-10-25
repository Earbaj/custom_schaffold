// lib/custom_scaffold.dart
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final bool isDark;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry? padding;
  final Widget? bottomNav;
  final String? darkBackgroundAsset;
  final String? lightBackgroundAsset;

  const CustomScaffold({
    required this.child,
    this.isDark = true,
    this.backgroundColor,
    this.appBar,
    this.floatingActionButton,
    this.padding,
    this.bottomNav,
    this.darkBackgroundAsset,
    this.lightBackgroundAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? Colors.white,
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
    );
  }
}
