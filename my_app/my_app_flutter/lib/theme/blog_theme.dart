import 'package:flutter/material.dart';

class BlogTheme {
  // Vibrant harmonious color tokens
  static const Color primaryViolet = Color(0xFF6C5CE7);
  static const Color secondaryCyan = Color(0xFF00CEC9);
  static const Color accentPink = Color(0xFFFF7675);
  static const Color goldYellow = Color(0xFFFDCB6E);
  static const Color darkBg = Color(0xFF0F172A);
  static const Color darkCardBg = Color(0xFF1E293B);
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightCardBg = Colors.white;

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      primaryColor: primaryViolet,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryViolet,
        brightness: Brightness.light,
        surface: lightCardBg,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF1E293B)),
        titleTextStyle: TextStyle(color: Color(0xFF1E293B), fontSize: 20, fontWeight: FontWeight.bold),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: primaryViolet,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryViolet,
        brightness: Brightness.dark,
        surface: darkCardBg,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: darkCardBg,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      cardTheme: CardThemeData(
        color: darkCardBg,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // Glassmorphism card decoration
  static BoxDecoration glassBoxDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? const Color(0xFF1E293B).withOpacity(0.85) : Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark ? Colors.black.withOpacity(0.3) : primaryViolet.withOpacity(0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
