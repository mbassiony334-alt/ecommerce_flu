import 'package:flutter/material.dart';

/// A shimmer/skeleton placeholder while data is loading.
/// Renders grey boxes the same shape as the actual content.
class HomeLoadingShimmer extends StatefulWidget {
  const HomeLoadingShimmer({super.key});

  @override
  State<HomeLoadingShimmer> createState() => _HomeLoadingShimmerState();
}

class _HomeLoadingShimmerState extends State<HomeLoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 0.9).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _shimmerBox({
    double width = double.infinity,
    double height = 20,
    double radius = 10,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) => Opacity(
        opacity: _anim.value,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF2A2A2A)
                : const Color(0xFFE8EDF5),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _shimmerBox(width: 48, height: 48, radius: 24),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmerBox(width: 100, height: 12),
                      const SizedBox(height: 8),
                      _shimmerBox(width: 160, height: 18),
                    ],
                  ),
                ),
                _shimmerBox(width: 46, height: 46, radius: 14),
              ],
            ),
          ),

          // Search bar shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _shimmerBox(height: 52, radius: 16),
          ),
          const SizedBox(height: 24),

          // Banner shimmer
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _shimmerBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 155,
              radius: 22,
            ),
          ),
          const SizedBox(height: 24),

          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shimmerBox(width: 140, height: 18),
                _shimmerBox(width: 55, height: 14),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Product cards shimmer row
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: List.generate(
                3,
                (_) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmerBox(width: 175, height: 155, radius: 20),
                      const SizedBox(height: 10),
                      _shimmerBox(width: 120, height: 12),
                      const SizedBox(height: 8),
                      _shimmerBox(width: 80, height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Categories shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _shimmerBox(width: 140, height: 18),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: List.generate(
                4,
                (_) => Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Column(
                    children: [
                      _shimmerBox(width: 68, height: 68, radius: 34),
                      const SizedBox(height: 8),
                      _shimmerBox(width: 58, height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
