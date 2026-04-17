import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {

  
  double get w => MediaQuery.of(this).size.width;

  
  double get h => MediaQuery.of(this).size.height;

  
  double wp(double percent) => w * percent;

  
  double hp(double percent) => h * percent;

  
  double get topPadding => MediaQuery.of(this).padding.top;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  
  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;

  
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  
  bool get isMobile => w < 600;
  bool get isTablet => w >= 600 && w < 1024;
  bool get isDesktop => w >= 1024;

  
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