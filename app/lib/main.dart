import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoprite/screens/home_page.dart';
import 'constants/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
    );
  }
}

/// Builds the theme with the Poppins font and custom styles
ThemeData _buildTheme() {
  final baseTextTheme = GoogleFonts.poppinsTextTheme();

  return ThemeData(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kBackgroundColor,
    textTheme: _buildTextTheme(baseTextTheme),
    fontFamily: GoogleFonts.poppins().fontFamily,
    drawerTheme: const DrawerThemeData(backgroundColor: kBackgroundColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: kBackgroundColor,
      titleTextStyle: TextStyle(
        color: kTextColor,
        fontSize: 24,
        fontWeight: FontWeight.w900, // Extra Bold
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: kBackgroundColor,
        shadowColor: Colors.transparent,
        textStyle: _customTextStyle(16, FontWeight.w700, kBackgroundColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: _customTextStyle(16, FontWeight.w500, kTextColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
        borderSide: const BorderSide(
          color: kPrimaryColor,
          width: 0.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
        borderSide: const BorderSide(
          color: kSecondaryColor,
          width: 0.2,
        ),
      ),
    ),
  );
}

/// Returns a customized Poppins-based `TextTheme`
TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    displayLarge: _customTextStyle(34, FontWeight.w700), // Semi-Bold
    displayMedium: _customTextStyle(30, FontWeight.bold), // Bold
    displaySmall: _customTextStyle(26, FontWeight.w600), // Medium-Bold

    headlineLarge: _customTextStyle(22, FontWeight.w700), // Semi-Bold
    headlineMedium: _customTextStyle(20, FontWeight.w500), // Medium
    headlineSmall: _customTextStyle(18, FontWeight.normal), // Regular

    titleLarge: _customTextStyle(16, FontWeight.bold), // Bold
    titleMedium: _customTextStyle(14, FontWeight.w600), // Medium-Bold
    titleSmall: _customTextStyle(12, FontWeight.normal), // Regular

    bodyLarge: _customTextStyle(16, FontWeight.w500), // Medium
    bodyMedium: _customTextStyle(14, FontWeight.normal), // Regular
    bodySmall: _customTextStyle(12, FontWeight.w300), // Light

    labelLarge: _customTextStyle(14, FontWeight.w500), // Medium
    labelMedium: _customTextStyle(12, FontWeight.normal), // Regular
    labelSmall: _customTextStyle(10, FontWeight.w300), // Light
  );
}

/// Returns a text style with given font size, weight, and optional color
TextStyle _customTextStyle(double size, FontWeight weight, [Color? color]) {
  return GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: color);
}
