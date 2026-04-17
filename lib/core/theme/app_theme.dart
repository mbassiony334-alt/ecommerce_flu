import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';








abstract final class AppColors {
  
  static const Color primaryBlue = Color(0xFF4A80F0);
  static const Color primaryBlueSaturated = Color(0xFF5B8FFF); 

  
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFF0F4FF);
  static const Color lightOnSurface = Color(0xFF001640);
  static const Color lightSubtitle = Color(0xFF51526C);
  static const Color lightDivider = Color(0xFFE0E6F0);

  
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkSurface = Color(0xFF252525);
  static const Color darkOnSurface = Color(0xFFECEFF4);
  static const Color darkSubtitle = Color(0xFFB0B3C7);
  static const Color darkDivider = Color(0xFF2E2E2E);

  
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color danger = Color(0xFFE74C3C);
}
















abstract final class AppTheme {
  
  static TextTheme _textTheme(Color onSurface, Color subtitle) {
    final base = GoogleFonts.poppinsTextTheme();
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        color: onSurface,
        fontSize: _clamp(28, 32, 48),
        fontWeight: FontWeight.w800,
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: onSurface,
        fontSize: _clamp(18, 20, 26),
        fontWeight: FontWeight.w700,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: onSurface,
        fontSize: _clamp(15, 16, 20),
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        color: onSurface,
        fontSize: _clamp(14, 16, 18),
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: subtitle,
        fontSize: _clamp(12, 14, 16),
      ),
      labelLarge: base.labelLarge?.copyWith(
        color: onSurface,
        fontSize: _clamp(13, 14, 16),
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    );
  }

  
  
  static double _clamp(double min, double preferred, double max) =>
      preferred.clamp(min, max);

  
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        primaryColor: AppColors.primaryBlue,

        
        scaffoldBackgroundColor: AppColors.lightBackground,

        
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryBlue,
          onPrimary: Colors.white,
          surface: AppColors.lightCard,
          onSurface: AppColors.lightOnSurface,
          surfaceContainerHighest: AppColors.lightSurface,
          error: AppColors.danger,
        ),

        
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.lightBackground,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.lightOnSurface),
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.lightOnSurface,
          ),
          surfaceTintColor: Colors.transparent,
        ),

        
        cardTheme: CardThemeData(
          color: AppColors.lightCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        
        dividerTheme: const DividerThemeData(
          color: AppColors.lightDivider,
          thickness: 1,
        ),

        
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.primaryBlue,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.danger),
          ),
          hintStyle: GoogleFonts.poppins(
            color: AppColors.lightSubtitle,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),

        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.disabled)
                  ? AppColors.lightSubtitle
                  : AppColors.primaryBlue,
            ),
            side: WidgetStateProperty.resolveWith(
              (states) => BorderSide(
                color: states.contains(WidgetState.disabled)
                    ? AppColors.lightDivider
                    : states.contains(WidgetState.pressed)
                        ? AppColors.primaryBlue.withValues(alpha: 0.6)
                        : AppColors.primaryBlue,
                width: 1.5,
              ),
            ),
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.pressed)
                  ? AppColors.primaryBlue.withValues(alpha: 0.05)
                  : Colors.transparent,
            ),
            minimumSize: const WidgetStatePropertyAll(
              Size.fromHeight(52),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            textStyle: WidgetStatePropertyAll(
              GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryBlue,
            textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
        ),

        
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.lightSurface,
          selectedColor: AppColors.primaryBlue.withValues(alpha: 0.15),
          labelStyle: GoogleFonts.poppins(fontSize: 13),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.lightOnSurface,
          contentTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 13,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ),

        
        textTheme: _textTheme(
          AppColors.lightOnSurface,
          AppColors.lightSubtitle,
        ),
      );

  
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        primaryColor: AppColors.primaryBlueSaturated,

        
        scaffoldBackgroundColor: AppColors.darkBackground,

        
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryBlueSaturated,
          onPrimary: Colors.white,
          surface: AppColors.darkCard,
          onSurface: AppColors.darkOnSurface,
          surfaceContainerHighest: AppColors.darkSurface,
          error: AppColors.danger,
        ),

        
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkBackground,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.darkOnSurface),
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.darkOnSurface,
          ),
          surfaceTintColor: Colors.transparent,
        ),

        
        cardTheme: CardThemeData(
          color: AppColors.darkCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        
        dividerTheme: const DividerThemeData(
          color: AppColors.darkDivider,
          thickness: 1,
        ),

        
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.primaryBlueSaturated,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.danger),
          ),
          hintStyle: GoogleFonts.poppins(
            color: AppColors.darkSubtitle,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),

        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlueSaturated,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.disabled)
                  ? AppColors.darkSubtitle
                  : AppColors.primaryBlueSaturated,
            ),
            side: WidgetStateProperty.resolveWith(
              (states) => BorderSide(
                color: states.contains(WidgetState.disabled)
                    ? AppColors.darkDivider
                    : states.contains(WidgetState.pressed)
                        ? AppColors.primaryBlueSaturated
                            .withValues(alpha: 0.5)
                        : AppColors.primaryBlueSaturated,
                width: 1.5,
              ),
            ),
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.pressed)
                  ? AppColors.primaryBlueSaturated.withValues(alpha: 0.08)
                  : Colors.transparent,
            ),
            minimumSize: const WidgetStatePropertyAll(
              Size.fromHeight(52),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            textStyle: WidgetStatePropertyAll(
              GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryBlueSaturated,
            textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
        ),

        
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.darkSurface,
          selectedColor:
              AppColors.primaryBlueSaturated.withValues(alpha: 0.2),
          labelStyle: GoogleFonts.poppins(
            fontSize: 13,
            color: AppColors.darkOnSurface,
          ),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.darkCard,
          contentTextStyle: GoogleFonts.poppins(
            color: AppColors.darkOnSurface,
            fontSize: 13,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ),

        
        textTheme: _textTheme(
          AppColors.darkOnSurface,
          AppColors.darkSubtitle,
        ),
      );
}
