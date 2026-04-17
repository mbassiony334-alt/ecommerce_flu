import 'package:dio/dio.dart';
import 'package:e_commarcae/core/bloc/bloc.dart';
import 'package:e_commarcae/core/services/api/dio_consumer.dart';
import 'package:e_commarcae/core/services/cache/cache_helper.dart';
import 'package:e_commarcae/core/theme/allTheme/dark_Them.dart';
import 'package:e_commarcae/core/theme/allTheme/light_Them.dart';
import 'package:e_commarcae/core/theme/cubit/theme_cubit.dart';
import 'package:e_commarcae/feature/auth/viewModel/cubit/auth_cubit.dart';
import 'package:e_commarcae/feature/brand/viewModel/cubit/brand_cubit.dart';
import 'package:e_commarcae/feature/cart/viewModel/cubit/cart_cubit.dart';
import 'package:e_commarcae/feature/categories/viewModel/cubit/categories_cubit.dart';
import 'package:e_commarcae/feature/favourite/viewModel/cubit/fav_cubit.dart';
import 'package:e_commarcae/feature/products/viewModel/cubit/products_cubit.dart';
import 'package:e_commarcae/feature/splash/spalshPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(api: DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(api: DioConsumer(dio: Dio()))..getCategories(),
        ),
        BlocProvider(
          create: (context) => BrandCubit(api: DioConsumer(dio: Dio()))..getCategories(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(api: DioConsumer(dio: Dio()))..getProducts(),
        ),
        BlocProvider(
          create: (context) => CartCubit(api: DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) => FavCubit(api: DioConsumer(dio: Dio())),
        ),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Ecommerce App',
          debugShowCheckedModeBanner: false,
          theme: GetLightThem(),
          darkTheme: GetDarkThem(),
          themeMode: themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
