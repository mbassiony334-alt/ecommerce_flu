import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {

  /// Screen width
  double get w => MediaQuery.of(this).size.width;

  /// Screen height
  double get h => MediaQuery.of(this).size.height;

  /// Width percentage
  double wp(double percent) => w * percent;

  /// Height percentage
  double hp(double percent) => h * percent;

  /// Safe area padding
  double get topPadding => MediaQuery.of(this).padding.top;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// Device pixel ratio
  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Orientation
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Device type
  bool get isMobile => w < 600;
  bool get isTablet => w >= 600 && w < 1024;
  bool get isDesktop => w >= 1024;

  /// Responsive value
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }
}