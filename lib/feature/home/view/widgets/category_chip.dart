import 'package:e_commarcae/core/theme/appColors/app_color_light.dart';
import 'package:e_commarcae/feature/categories/model/categoriesModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  final CategoriesModel category;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [
                          AppColorLight.primaryColor,
                          Color(0xFF6B9FF8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isSelected
                    ? null
                    : (isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFF0F4FF)),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColorLight.primaryColor
                              .withValues(alpha: 0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: ClipOval(
                child: _buildImage(isSelected),
              ),
            ),

            const SizedBox(height: 8),

            
            SizedBox(
              width: 72,
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? AppColorLight.primaryColor
                      : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(bool isSelected) {
    if (category.image.isEmpty) {
      return Icon(
        Icons.category_rounded,
        color: isSelected ? Colors.white : AppColorLight.primaryColor,
        size: 30,
      );
    }
    return Image.network(
      category.image,
      fit: BoxFit.cover,
      errorBuilder: (ctx, err, st) => Icon(
        Icons.category_rounded,
        color: isSelected ? Colors.white : AppColorLight.primaryColor,
        size: 30,
      ),
    );
  }
}
