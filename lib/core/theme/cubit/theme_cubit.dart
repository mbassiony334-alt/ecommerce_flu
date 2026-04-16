import 'package:e_commarcae/core/services/cash/cash_Healper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ThemeCubit extends Cubit<ThemeMode> {

  static const String _cacheKey = 'themeMode';

  ThemeCubit() : super(_loadInitial());


  static ThemeMode _loadInitial() {
    final int? stored = CacheHelper.getData(key: _cacheKey);
    switch (stored) {
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }


  void toggleTheme() {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    CacheHelper.saveData(key: _cacheKey, value: newMode == ThemeMode.dark ? 2 : 1);
    emit(newMode);
  }


  bool get isDark => state == ThemeMode.dark;
}
