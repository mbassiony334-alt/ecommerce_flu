import 'package:e_commarcae/core/services/cash/cash_Healper.dart';
import 'package:e_commarcae/core/theme/appColors/app_color_light.dart';
import 'package:e_commarcae/core/theme/cubit/theme_cubit.dart';
import 'package:e_commarcae/core/widget/productsCard.dart';
import 'package:e_commarcae/feature/cart/view/cart.dart';
import 'package:e_commarcae/feature/favourite/view/favourite.dart';
import 'package:e_commarcae/feature/home/view/home.dart';
import 'package:e_commarcae/feature/products/viewModel/cubit/products_cubit.dart';
import 'package:e_commarcae/feature/user/model/userModel.dart';
import 'package:e_commarcae/feature/user/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class ProductHome extends StatefulWidget {
  const ProductHome({super.key});

  @override
  State<ProductHome> createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    context.read<ProductsCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // 0 – Home
          HomeView(onSeeAllProducts: () => setState(() => _currentIndex = 1)),

          // 1 – Shop (products grid)
          _buildShopTab(context),

          // 2 – Favourites
          const FavPage(),

          // 3 – Profile
          ProfileView(
            user: User(
              name: CacheHelper.getData(key: 'userName') as String? ?? '',
              phone: '',
              email: '',
              role: 'Customer',
              image: '',
            ),
          ),
        ],
      ),


      floatingActionButton: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final isDark = themeMode == ThemeMode.dark;
          return FloatingActionButton(
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            backgroundColor: isDark
                ? const Color(0xFF2A2A3E)
                : const Color(0xFFF0F4FF),
            elevation: 6,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: animation,
                child: ScaleTransition(scale: animation, child: child),
              ),
              child: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                key: ValueKey(isDark),
                color: isDark
                    ? const Color(0xFFFFC107)
                    : const Color(0xFF4A80F0),
                size: 26,
              ),
            ),
          );
        },
      ),


      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isActive: _currentIndex == 0,
                  onTap: () => setState(() => _currentIndex = 0),
                ),
                _NavItem(
                  icon: Icons.grid_view_rounded,
                  label: 'Shop',
                  isActive: _currentIndex == 1,
                  onTap: () => setState(() => _currentIndex = 1),
                ),
                _NavItem(
                  icon: Icons.favorite_border_rounded,
                  label: 'Saved',
                  isActive: _currentIndex == 2,
                  onTap: () => setState(() => _currentIndex = 2),
                ),
                _NavItem(
                  icon: Icons.person_outline_rounded,
                  label: 'Profile',
                  isActive: _currentIndex == 3,
                  onTap: () => setState(() => _currentIndex = 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildShopTab(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Products',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartPage()),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColorLight.primaryColor,
              ),
            );
          } else if (state is ProductSuccess) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, i) =>
                  Productscard(productsModel: state.products[i]),
            );
          } else if (state is ProductsFaliure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: Colors.grey),
                  const SizedBox(height: 12),
                  Text(state.errorMessage),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ProductsCubit>().getProducts(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}


class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColorLight.primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? AppColorLight.primaryColor
                  : Colors.grey[400],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight:
                    isActive ? FontWeight.w700 : FontWeight.w400,
                color: isActive
                    ? AppColorLight.primaryColor
                    : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}