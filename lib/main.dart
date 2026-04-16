import 'package:dio/dio.dart';
import 'package:e_commarcae/core/services/api/dio_Concumer.dart';
import 'package:e_commarcae/core/services/cash/cash_Healper.dart';
import 'package:e_commarcae/core/theme/allTheme/dark_Them.dart';
import 'package:e_commarcae/core/theme/allTheme/light_Them.dart';
import 'package:e_commarcae/core/theme/cubit/theme_cubit.dart';
import 'package:e_commarcae/feature/auth/viewModel/cubit/auth_cubit.dart';
import 'package:e_commarcae/feature/brand/viewModel/cubit/brand_cubit.dart';
import 'package:e_commarcae/feature/cart/viewModel/cubit/cart_cubit.dart';
import 'package:e_commarcae/feature/categories/viewModel/cubit/categories_cubit.dart';
import 'package:e_commarcae/feature/favourite/viewModel/cubit/fav_cubit.dart';
import 'package:e_commarcae/feature/home/viewModel/home_cubit.dart';
import 'package:e_commarcae/feature/products/viewModel/cubit/products_cubit.dart';
import 'package:e_commarcae/feature/splash/spalshPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(api: DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) =>
              CategoriesCubit(api: DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) => BrandCubit(api: DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) =>
              ProductsCubit(api: DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) => CartCubit(api: DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) => FavCubit(api: DioConsumer(dio: Dio())),
        ),
        // HomeCubit drives the home screen data loading
        BlocProvider(
          create: (context) =>
              HomeCubit(api: DioConsumer(dio: Dio())),
        ),

        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
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
          // Light theme: Background #FFFFFF, primary blue #4A80F0
          theme: GetLightThem(),
          // Dark theme: Background #121212, card #1E1E1E, primary #4A80F0
          darkTheme: GetDarkThem(),

          themeMode: themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
