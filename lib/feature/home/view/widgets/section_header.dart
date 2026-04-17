import 'package:e_commarcae/core/theme/appColors/app_color_light.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                'See All',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColorLight.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
