import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme();

  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      filledButtonTheme: _filledButtonTheme,
    );
  }

  static ColorScheme get _colorScheme {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0a0050),
      onPrimary: Color(0xffFFFFFF),
      secondary: Color(0xff2cc581),
      onSecondary: Color(0xffffffff),
      surface: Color(0xffFFFFFF),
      onSurface: Color(0xFF0e1016),
      background: Color(0xffffffff),
      onBackground: Color(0xff000000),
      error: Color(0xFF5e162e),
      onError: Color(0xFFf5e9ed),
    );
  }

  static TextTheme get _textTheme {
    const textTheme = TextTheme();

    final bodyFont = GoogleFonts.ibmPlexSansTextTheme(textTheme);
    final headingFont = GoogleFonts.syneMonoTextTheme(textTheme);

    return bodyFont.copyWith(
      displayLarge: headingFont.displayLarge,
      displayMedium: headingFont.displayMedium,
      displaySmall: headingFont.displaySmall,
      headlineLarge: headingFont.headlineLarge,
      headlineMedium: headingFont.headlineMedium,
      headlineSmall: headingFont.headlineSmall,
      bodyLarge: bodyFont.bodyLarge,
      bodyMedium: bodyFont.bodyMedium,
      bodySmall: bodyFont.bodySmall,
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: _colorScheme.background,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      enabledBorder: _enabledBorder,
      focusedBorder: _focusedBorder,
      disabledBorder: _disabledBorder,
    );
  }

  static FilledButtonThemeData get _filledButtonTheme {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  static InputBorder get _enabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.transparent),
      );

  static InputBorder get _focusedBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      );

  static InputBorder get _disabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
      );
}
