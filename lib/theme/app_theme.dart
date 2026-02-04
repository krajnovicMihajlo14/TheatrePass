import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    const seedColor = Color(0xFFDA020E);
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF5C0000),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF5C0000),
        indicatorColor: const Color(0xFF8B0000),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
          }
          return const TextStyle(color: Colors.white54);
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: Colors.white);
          }
          return const IconThemeData(color: Colors.white54);
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDA020E),
          foregroundColor: Colors.white,
        ),
      ),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.openSansTextTheme(baseTheme.textTheme).copyWith(
        displayLarge: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        headlineLarge: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        headlineSmall: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        titleMedium: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        titleSmall: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.openSans(fontWeight: FontWeight.w600),
        bodyMedium: GoogleFonts.openSans(fontWeight: FontWeight.w600),
        bodySmall: GoogleFonts.openSans(fontWeight: FontWeight.w600),
        labelLarge: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        labelMedium: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        labelSmall: GoogleFonts.openSans(fontWeight: FontWeight.bold),
      ),
    );
  }
}
