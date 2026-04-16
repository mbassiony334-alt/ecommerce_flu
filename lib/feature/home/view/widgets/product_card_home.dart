import 'package:e_commarcae/core/theme/appColors/app_color_light.dart';
import 'package:e_commarcae/feature/cart/viewModel/cubit/cart_cubit.dart';
import 'package:e_commarcae/feature/favourite/viewModel/cubit/fav_cubit.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

/// A premium product card used in horizontal scroll sections.
///
/// Displays:
///  • Product image with gradient overlay
///  • Discount badge
///  • Heart (favourite) toggle button
///  • Rating stars
///  • Price in LE
///  • Product title
///  • Gradient "Add" button
class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final ProductsModel product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  bool _isFav = false;
  late AnimationController _heartController;
  late Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heartScale = Tween<double>(begin: 1.0, end: 1.35).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _toggleFav() {
    setState(() => _isFav = !_isFav);
    _heartController.forward(from: 0);
    if (_isFav) {
      context.read<FavCubit>().addFavourite(widget.product.id);
    } else {
      context.read<FavCubit>().delFavourite(widget.product.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Container(
      width: 175,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image + badges ────────────────────────────────────────────
          Stack(
            children: [
              // Image
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  height: 155,
                  width: double.infinity,
                  color: isDark
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFF0F4FF),
                  child: Image.network(
                    widget.product.thumbnail,
                    fit: BoxFit.contain,
                    errorBuilder: (ctx, err, st) => const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColorLight.primaryColor,
                        size: 40,
                      ),
                    ),
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColorLight.primaryColor,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Gradient overlay at bottom of image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        cardBg,
                        cardBg.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),

              // Discount badge
              if (widget.product.discountPercentage > 0)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF4D4D), Color(0xFFFF8A65)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '-${widget.product.discountPercentage.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

              // Heart button
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: _toggleFav,
                  child: ScaleTransition(
                    scale: _heartScale,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withValues(alpha: 0.12),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isFav ? Icons.favorite : Icons.favorite_outline,
                        color: _isFav ? Colors.red : Colors.grey[400],
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Details ───────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Color(0xFFFFA500), size: 15),
                    const SizedBox(width: 3),
                    Text(
                      widget.product.rating.toStringAsFixed(1),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFFA500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Title
                Text(
                  widget.product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),

                // Price
                Text(
                  '${widget.product.price.toStringAsFixed(2)} LE',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColorLight.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),

                // Add to cart button
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () =>
                        context.read<CartCubit>().addCart(widget.product.id),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColorLight.primaryColor,
                            Color(0xFF6B9FF8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '+ Add',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
