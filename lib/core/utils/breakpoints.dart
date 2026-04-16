import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────
// Breakpoints
// ─────────────────────────────────────────────────────────────────

/// Screen-width breakpoints used throughout the app.
///
/// Usage:
/// ```dart
/// final bp = Breakpoints.of(context);
/// if (bp.isTablet) { ... }
/// ```
class Breakpoints {
  /// Width < 600 → mobile phone
  static const double mobileMax = 599;

  /// 600 ≤ width < 1024 → tablet
  static const double tabletMax = 1023;

  final double width;

  const Breakpoints._({required this.width});

  factory Breakpoints.of(BuildContext context) =>
      Breakpoints._(width: MediaQuery.sizeOf(context).width);

  bool get isMobile => width <= mobileMax;
  bool get isTablet => width > mobileMax && width <= tabletMax;
  bool get isDesktop => width > tabletMax;

  /// Product-grid column count: 2 on phone, 3 on tablet, 4 on desktop.
  int get gridColumns => isMobile ? 2 : isTablet ? 3 : 4;

  /// Whether to show categories as a side rail instead of a horizontal row.
  bool get useSideRail => !isMobile;

  /// Horizontal content padding — larger on wide screens.
  double get hPad => isMobile ? 20 : isTablet ? 40 : 80;

  /// Font scale factor clamped to [0.9, 1.4].
  double get fontScale => (width / 375).clamp(0.9, 1.4);

  /// Responsive value helper.
  T value<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop) return desktop ?? tablet ?? mobile;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }
}

// ─────────────────────────────────────────────────────────────────
// ResponsiveLayout
// ─────────────────────────────────────────────────────────────────

/// Convenience widget that rebuilds children using [LayoutBuilder]
/// and exposes [Breakpoints].
///
/// ```dart
/// ResponsiveLayout(
///   builder: (context, bp) => bp.isMobile
///       ? MobileHome()
///       : TabletHome(),
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key, required this.builder});

  final Widget Function(BuildContext context, Breakpoints bp) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final bp = Breakpoints._(width: constraints.maxWidth);
        return builder(ctx, bp);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// ResponsiveGrid
// ─────────────────────────────────────────────────────────────────

/// A [GridView] whose column count adapts to the available width
/// using [Breakpoints.gridColumns].
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.childAspectRatio = 0.72,
    this.padding,
    this.mainAxisSpacing = 14,
    this.crossAxisSpacing = 14,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final double childAspectRatio;
  final EdgeInsetsGeometry? padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      builder: (ctx, bp) => GridView.builder(
        padding: padding ??
            EdgeInsets.symmetric(horizontal: bp.hPad, vertical: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: bp.gridColumns,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
