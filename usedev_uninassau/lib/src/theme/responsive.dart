import 'package:flutter/material.dart';

enum ScreenSize { mobile, tablet, desktop }

abstract final class Responsive {
  static const maxContentWidth = 1200.0;
  static const tabletBreakpoint = 600.0;
  static const desktopBreakpoint = 1024.0;

  static ScreenSize screenSizeOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= desktopBreakpoint) return ScreenSize.desktop;
    if (width >= tabletBreakpoint) return ScreenSize.tablet;
    return ScreenSize.mobile;
  }

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      screenSizeOf(context) == ScreenSize.desktop;

  static int gridColumns(
    BuildContext context, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 4,
  }) {
    return switch (screenSizeOf(context)) {
      ScreenSize.desktop => desktop,
      ScreenSize.tablet => tablet,
      ScreenSize.mobile => mobile,
    };
  }

  static double horizontalPadding(BuildContext context) {
    return switch (screenSizeOf(context)) {
      ScreenSize.desktop => 48,
      ScreenSize.tablet => 32,
      ScreenSize.mobile => 24,
    };
  }

  static double valueForScreen(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    return switch (screenSizeOf(context)) {
      ScreenSize.desktop => desktop,
      ScreenSize.tablet => tablet,
      ScreenSize.mobile => mobile,
    };
  }
}
