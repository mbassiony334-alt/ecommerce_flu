import 'package:flutter/material.dart';


class PromoBannerCard extends StatelessWidget {
  const PromoBannerCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.gradientColors,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String badgeText;
  final List<Color> gradientColors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 165,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              right: 40,
              bottom: -30,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badgeText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            
            Positioned(
              right: 20,
              bottom: 20,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



final List<Map<String, dynamic>> homeBanners = [
  {
    'title': 'Summer Sale\nUp to 50% Off',
    'subtitle': 'On selected products',
    'badge': '🔥 HOT DEAL',
    'colors': [const Color(0xFF4A80F0), const Color(0xFF7B61FF)],
  },
  {
    'title': 'New Arrivals\nFresh Collection',
    'subtitle': 'Explore the latest trends',
    'badge': '✨ NEW IN',
    'colors': [const Color(0xFF11998E), const Color(0xFF38EF7D)],
  },
  {
    'title': 'Free Shipping\nOn Orders 200 LE+',
    'subtitle': 'Limited time offer',
    'badge': '🚚 FREE SHIP',
    'colors': [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)],
  },
];
