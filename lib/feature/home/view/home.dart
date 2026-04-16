import 'package:dio/dio.dart';
import 'package:e_commarcae/core/services/api/dio_Concumer.dart';
import 'package:e_commarcae/core/services/cash/cash_Healper.dart';
import 'package:e_commarcae/feature/brand/model/brandModel.dart';
import 'package:e_commarcae/feature/categories/model/categoriesModel.dart';
import 'package:e_commarcae/feature/home/view/widgets/brand_logo_card.dart';
import 'package:e_commarcae/feature/home/view/widgets/category_chip.dart';
import 'package:e_commarcae/feature/home/view/widgets/home_header.dart';
import 'package:e_commarcae/feature/home/view/widgets/home_loading_shimmer.dart';
import 'package:e_commarcae/feature/home/view/widgets/home_search_bar.dart';
import 'package:e_commarcae/feature/home/view/widgets/product_card_home.dart';
import 'package:e_commarcae/feature/home/view/widgets/promo_banner_card.dart';
import 'package:e_commarcae/feature/home/view/widgets/section_header.dart';
import 'package:e_commarcae/feature/home/viewModel/home_cubit.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _bannerCtrl = PageController(viewportFraction: 0.92);
  final TextEditingController _searchCtrl = TextEditingController();

  int _selectedCategoryIndex = 0;
  String _searchQuery = '';

  @override
  void dispose() {
    _bannerCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Each HomeView instance owns its HomeCubit and triggers load immediately
      create: (ctx) =>
          HomeCubit(api: DioConsumer(dio: Dio()))..loadHome(),
      child: Scaffold(
        // No AppBar — we use a custom sticky header inside the scroll view
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const HomeLoadingShimmer();
            }

            if (state is HomeFailure) {
              return _buildError(context, state.errorMessage);
            }

            if (state is HomeLoaded) {
              return _buildContent(context, state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // ── Error state ────────────────────────────────────────────────────────
  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded,
                size: 64, color: Color(0xFF4A80F0)),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  context.read<HomeCubit>().loadHome(),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  // ── Loaded state ───────────────────────────────────────────────────────
  Widget _buildContent(BuildContext context, HomeLoaded state) {
    final cachedName = CacheHelper.getData(key: 'userName') as String? ??
        state.userName;

    final filtered = _searchQuery.isEmpty
        ? state.products
        : state.products
            .where((p) =>
                p.title.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return RefreshIndicator(
      color: const Color(0xFF4A80F0),
      onRefresh: () => context.read<HomeCubit>().loadHome(),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          SliverToBoxAdapter(
            child: SafeArea(
              child: HomeHeader(
                userName: cachedName,
                notificationCount: 3,
                onNotificationTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No new notifications')),
                  );
                },
              ),
            ),
          ),


          SliverToBoxAdapter(
            child: HomeSearchBar(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _searchQuery = v),
              onFilterTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Filter coming soon')),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 22)),


          if (_searchQuery.isEmpty) ...[
            SliverToBoxAdapter(child: _buildBannerCarousel(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],


          SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Popular Products',
              onSeeAll: () {},
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 14)),
          SliverToBoxAdapter(
            child: _buildProductsRow(filtered.take(8).toList()),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),


          if (_searchQuery.isEmpty) ...[
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Categories',
                onSeeAll: () {},
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),
            SliverToBoxAdapter(
              child: _buildCategoriesRow(state.categories),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],


          SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Best for You',
              onSeeAll: () {},
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 14)),
          SliverToBoxAdapter(
            child: _buildProductsRow(
              filtered.reversed.take(8).toList(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),


          if (_searchQuery.isEmpty) ...[
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Top Brands',
                onSeeAll: () {},
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),
            SliverToBoxAdapter(
              child: _buildBrandsRow(state.brands),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],


          SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Buy Again',
              onSeeAll: () {},
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 14)),
          SliverToBoxAdapter(
            child: _buildProductsRow(
              (filtered..shuffle()).take(6).toList(),
            ),
          ),


          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  // ── Banner carousel ────────────────────────────────────────────────────
  Widget _buildBannerCarousel(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 155,
          child: PageView.builder(
            controller: _bannerCtrl,
            itemCount: homeBanners.length,
            itemBuilder: (_, i) {
              final b = homeBanners[i];
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: PromoBannerCard(
                  title: b['title'] as String,
                  subtitle: b['subtitle'] as String,
                  badgeText: b['badge'] as String,
                  gradientColors: b['colors'] as List<Color>,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        SmoothPageIndicator(
          controller: _bannerCtrl,
          count: homeBanners.length,
          effect: const WormEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Color(0xFF4A80F0),
            dotColor: Color(0xFFCDD6F4),
          ),
        ),
      ],
    );
  }

  // ── Horizontal products row ────────────────────────────────────────────
  Widget _buildProductsRow(List<ProductsModel> products) {
    if (products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(
          'No products found.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return SizedBox(
      height: 310,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (_, i) => ProductCard(product: products[i]),
      ),
    );
  }

  // ── Categories row ─────────────────────────────────────────────────────
  Widget _buildCategoriesRow(List<CategoriesModel> categories) {
    return SizedBox(
      height: 105,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (_, i) => CategoryChip(
          category: categories[i],
          isSelected: _selectedCategoryIndex == i,
          onTap: () => setState(() => _selectedCategoryIndex = i),
        ),
      ),
    );
  }

  // ── Brands row ─────────────────────────────────────────────────────────
  Widget _buildBrandsRow(List<Brand> brands) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        itemBuilder: (_, i) => BrandLogoCard(brand: brands[i]),
      ),
    );
  }
}
