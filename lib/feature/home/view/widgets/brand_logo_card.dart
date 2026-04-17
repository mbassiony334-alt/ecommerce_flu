import 'package:e_commarcae/core/theme/appColors/app_color_light.dart';
import 'package:e_commarcae/feature/brand/model/brandModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class BrandLogoCard extends StatelessWidget {
  const BrandLogoCard({super.key, required this.brand, this.onTap});

  final Brand brand;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        margin: const EdgeInsets.only(right: 14),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.07),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: AppColorLight.primaryColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColorLight.primaryColor.withValues(alpha: 0.15),
                    const Color(0xFF7B61FF).withValues(alpha: 0.12),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  brand.emoji.isNotEmpty ? brand.emoji : '🏷️',
                  style: const TextStyle(fontSize: 26),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              brand.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
