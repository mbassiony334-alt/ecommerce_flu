import 'package:e_commarcae/core/theme/appColors/app_color_light.dart';
import 'package:e_commarcae/core/utils/auth_guard.dart';
import 'package:e_commarcae/feature/cart/viewModel/cubit/cart_cubit.dart';
import 'package:e_commarcae/feature/favourite/viewModel/cubit/fav_cubit.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SideCard extends StatelessWidget {
  const SideCard({super.key, required this.prod, this.name});
  final ProductsModel prod;
  final String? name;

  @override
  Widget build(BuildContext context) {
    final bool isCart = name == 'car';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: AppColorLight.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2E2E2E), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  prod.thumbnail,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                  errorBuilder: (_, e, st) => Container(
                    width: 52,
                    height: 52,
                    color: const Color(0xFF2E2E2E),
                    child: const Icon(
                      Icons.image_not_supported,
                      color: AppColorLight.primaryColor,
                      size: 22,
                    ),
                  ),
                ),
              ),
              const Gap(14),

              Expanded(
                child: Text(
                  prod.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: AppColorLight.socendColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  if (!AuthGuard.check(
                    context,
                    actionLabel: isCart ? 'remove from cart' : 'remove from favourites',
                  )) return;
                  isCart
                      ? context.read<CartCubit>().delCart(prod.id)
                      : context.read<FavCubit>().delFavourite(prod.id);
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColorLight.cardBackground.withValues(alpha: 0.12),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    size: 20,
                    color: AppColorLight.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
