import 'package:flutter/material.dart';












class Breakpoints {
  
  static const double mobileMax = 599;

  
  static const double tabletMax = 1023;

  final double width;

  const Breakpoints._({required this.width});

  factory Breakpoints.of(BuildContext context) =>
      Breakpoints._(width: MediaQuery.sizeOf(context).width);

  bool get isMobile => width <= mobileMax;
  bool get isTablet => width > mobileMax && width <= tabletMax;
  bool get isDesktop => width > tabletMax;

  
  int get gridColumns => isMobile ? 2 : isTablet ? 3 : 4;

  
  bool get useSideRail => !isMobile;

  
  double get hPad => isMobile ? 20 : isTablet ? 40 : 80;

  
  double get fontScale => (width / 375).clamp(0.9, 1.4);

  
  T value<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop) return desktop ?? tablet ?? mobile;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }
}















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
