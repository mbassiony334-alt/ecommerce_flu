import 'package:e_commarcae/core/services/cache/cache_helper.dart';
import 'package:e_commarcae/core/theme/appColors/app_color_light.dart';
import 'package:e_commarcae/core/widget/productsCard.dart';
import 'package:e_commarcae/feature/favourite/view/favourite.dart';
import 'package:e_commarcae/feature/home/view/home_view.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
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

  final List<String> _titles = ['Home', 'Shop', 'Saved', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _titles[_currentIndex],
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeView(),
          const ProductsScreen(title: 'Shop'),
          const FavPage(isEmbedded: true),
          ProfileView(
            isEmbedded: true,
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
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }
  Widget _buildBottomNav(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
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
    );
  }
}

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsInitial) {
          context.read<ProductsCubit>().getProducts();
        }
        if (state is ProductsLoading || state is ProductsInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductsFailure) {
          return Center(child: Text(state.errorMessage));
        }
        final List<ProductsModel> products = state is ProductSuccess ? state.products : <ProductsModel>[];
        if (products.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 62,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No products to show',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        final width = MediaQuery.sizeOf(context).width;
        final crossAxisCount = width >= 1100
            ? 5
            : width >= 900
                ? 4
                : width >= 650
                    ? 3
                    : 2;
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: width >= 900
                ? 0.82
                : width >= 650
                    ? 0.78
                    : 0.72,
          ),
          itemCount: products.length,
          itemBuilder: (context, i) =>
              Productscard(productsModel: products[i]),
        );
      },
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
              ? AppColorLight.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColorLight.primaryColor : Colors.grey[400],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                color: isActive ? AppColorLight.primaryColor : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}