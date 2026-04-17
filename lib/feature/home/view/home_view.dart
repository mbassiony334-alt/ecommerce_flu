import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commarcae/feature/brand/model/brandModel.dart';
import 'package:e_commarcae/feature/brand/viewModel/cubit/brand_cubit.dart';
import 'package:e_commarcae/feature/cart/viewModel/cubit/cart_cubit.dart';
import 'package:e_commarcae/feature/categories/model/categoriesModel.dart';
import 'package:e_commarcae/feature/categories/viewModel/cubit/categories_cubit.dart';
import 'package:e_commarcae/feature/favourite/viewModel/cubit/fav_cubit.dart';
import 'package:e_commarcae/feature/home/view/widgets/brand_logo_card.dart';
import 'package:e_commarcae/feature/home/view/widgets/category_chip.dart';
import 'package:e_commarcae/feature/home/view/widgets/home_loading_shimmer.dart';
import 'package:e_commarcae/feature/home/view/widgets/home_search_bar.dart';
import 'package:e_commarcae/feature/home/view/widgets/product_card_home.dart';
import 'package:e_commarcae/feature/home/view/widgets/promo_banner_card.dart';
import 'package:e_commarcae/feature/home/view/widgets/section_header.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
import 'package:e_commarcae/feature/products/viewModel/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchCtrl = TextEditingController();
  int _currentBannerIndex = 0;
  String _searchQuery = '';
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsCubit>().getProducts();
      context.read<BrandCubit>().getCategories();
      context.read<CategoriesCubit>().getCategories();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
        ),
        BlocListener<FavCubit, FavState>(
          listener: (context, state) {
            if (state is FavFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, productState) {
          if (productState is ProductsLoading || productState is ProductsInitial) {
            return const HomeLoadingShimmer();
          }
          if (productState is ProductsFailure) {
            return _buildError(productState.errorMessage);
          }
          final products = productState is ProductSuccess ? productState.products : <ProductsModel>[];
          return _buildContent(products);
        },
      ),
    );
  }

  Widget _buildContent(List<ProductsModel> allProducts) {
    final products = _searchQuery.isEmpty
        ? allProducts
        : allProducts
            .where((p) =>
                p.title.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          context.read<ProductsCubit>().getProducts(),
          context.read<BrandCubit>().getCategories(),
          context.read<CategoriesCubit>().getCategories(),
        ]);
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: HomeSearchBar(
                controller: _searchCtrl,
                onChanged: (v) => setState(() => _searchQuery = v),
              ),
            ),
          ),
          if (_searchQuery.isEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: _buildBannerCarousel(),
              ),
            ),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Categories',
              ),
            ),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                final categories = state is CategoriesSuccess ? state.categories : <CategoriesModel>[];
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      itemCount: categories.length,
                      itemBuilder: (context, index) => CategoryChip(
                        category: categories[index],
                        isSelected: _selectedCategoryIndex == index,
                        onTap: () => setState(() => _selectedCategoryIndex = index),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
          SliverToBoxAdapter(
            child: SectionHeader(
              title: _searchQuery.isEmpty ? 'Popular Products' : 'Search Results',
              onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<ProductsCubit>(),
                      child: const _ProductsRouteScreen(title: 'Products'),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _gridCount(context),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: _gridAspectRatio(context),
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<ProductsCubit>(),
                          child: _ProductDetailsRoute(productId: products[index].id),
                        ),
                      ),
                    );
                  },
                  child: ProductCard(product: products[index]),
                ),
                childCount: products.length,
              ),
            ),
          ),
          if (_searchQuery.isEmpty) ...[
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Top Brands',
              ),
            ),
            BlocBuilder<BrandCubit, BrandState>(
              builder: (context, state) {
                final brands = state is BrandSuccess ? state.brands : <Brand>[];
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      itemCount: brands.length,
                      itemBuilder: (context, index) =>
                          BrandLogoCard(brand: brands[index]),
                    ),
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, size: 64, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<ProductsCubit>().getProducts();
                context.read<BrandCubit>().getCategories();
                context.read<CategoriesCubit>().getCategories();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    final width = MediaQuery.sizeOf(context).width;
    final height = width < 360 ? 145.0 : width < 600 ? 165.0 : 185.0;
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: homeBanners.length,
          itemBuilder: (context, index, realIndex) {
            final banner = homeBanners[index];
            return PromoBannerCard(
              title: banner['title'],
              subtitle: banner['subtitle'],
              badgeText: banner['badge'],
              gradientColors: banner['colors'],
            );
          },
          options: CarouselOptions(
            height: height,
            viewportFraction: width < 360 ? 0.95 : 0.9,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() => _currentBannerIndex = index);
            },
          ),
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: _currentBannerIndex,
          count: homeBanners.length,
          effect: const WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Color(0xFF4A80F0),
            dotColor: Color(0xFFD1D1D1),
          ),
        ),
      ],
    );
  }

  int _gridCount(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  double _gridAspectRatio(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return 0.86;
    if (width >= 600) return 0.78;
    return 0.72;
  }
}

class _ProductsRouteScreen extends StatelessWidget {
  const _ProductsRouteScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
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
          final products = state is ProductSuccess ? state.products : <ProductsModel>[];
          if (products.isEmpty) {
            return const Center(child: Text('No products'));
          }
          final width = MediaQuery.sizeOf(context).width;
          final crossAxisCount = width >= 600 ? 3 : 2;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: width >= 600 ? 0.78 : 0.72,
            ),
            itemCount: products.length,
            itemBuilder: (context, i) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<ProductsCubit>(),
                      child: _ProductDetailsRoute(productId: products[i].id),
                    ),
                  ),
                );
              },
              child: ProductCard(product: products[i]),
            ),
          );
        },
      ),
    );
  }
}

class _ProductDetailsRoute extends StatefulWidget {
  const _ProductDetailsRoute({required this.productId});

  final int productId;

  @override
  State<_ProductDetailsRoute> createState() => _ProductDetailsRouteState();
}

class _ProductDetailsRouteState extends State<_ProductDetailsRoute> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsCubit>().getOneProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading || state is ProductsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductsFailure) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is SpecificProductSuccess) {
            final p = state.product;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                AspectRatio(
                  aspectRatio: 1.1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      p.thumbnail,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(Icons.image_not_supported_outlined, size: 42),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  p.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  '${p.price.toStringAsFixed(2)} LE',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Text(p.description),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
