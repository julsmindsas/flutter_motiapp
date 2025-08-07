import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ===== PALETA DE COLORES LUXURY =====
  
  // Negros y Grises
  static const Color primaryBlack = Color(0xFF0A0A0A);      // Negro principal
  static const Color secondaryBlack = Color(0xFF1A1A1A);    // Negro secundario
  static const Color darkGray = Color(0xFF2A2A2A);          // Gris oscuro
  static const Color mediumGray = Color(0xFF3A3A3A);        // Gris medio
  static const Color lightGray = Color(0xFF4A4A4A);         // Gris claro
  static const Color silverGray = Color(0xFF8A8A8A);        // Gris plateado
  static const Color lightSilver = Color(0xFFAAAAAA);       // Gris claro plateado
  
  // Blancos
  static const Color white = Color(0xFFFFFFFF);             // Blanco puro
  static const Color offWhite = Color(0xFFF5F5F5);         // Blanco suave
  static const Color cream = Color(0xFFF8F8F8);            // Crema
  
  // Dorados
  static const Color gold = Color(0xFFFFD700);              // Dorado principal
  static const Color premiumGold = Color(0xFFFFB347);       // Dorado premium
  static const Color lightGold = Color(0xFFFFE066);         // Dorado claro
  static const Color darkGold = Color(0xFFFFC107);          // Dorado oscuro
  
  // Acentos
  static const Color accentBlue = Color(0xFF4A90E2);        // Azul acento
  static const Color accentGreen = Color(0xFF4CAF50);       // Verde acento
  static const Color accentPurple = Color(0xFF9C27B0);      // Púrpura acento
  
  // ===== GRADIENTES LUXURY =====
  
  // Gradiente principal
  static const LinearGradient luxuryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlack, secondaryBlack, darkGray],
    stops: [0.0, 0.5, 1.0],
  );
  
  // Gradiente de tarjetas
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryBlack, darkGray],
    stops: [0.0, 1.0],
  );
  
  // Gradiente dorado
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gold, premiumGold],
    stops: [0.0, 1.0],
  );
  
  // Gradiente premium
  static const LinearGradient premiumGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [premiumGold, darkGold],
    stops: [0.0, 1.0],
  );
  
  // ===== SOMBRAS Y EFECTOS =====
  
  // Sombras
  static List<BoxShadow> get luxuryShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 15,
      offset: const Offset(0, 5),
    ),
  ];
  
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 10,
      offset: const Offset(0, 3),
    ),
  ];
  
  static List<BoxShadow> get goldShadow => [
    BoxShadow(
      color: gold.withOpacity(0.3),
      blurRadius: 10,
      spreadRadius: 2,
    ),
  ];

  // ===== TEMA OSCURO (PRINCIPAL) =====
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
      
      // Colores principales
      colorScheme: const ColorScheme.dark(
        primary: gold,
        secondary: premiumGold,
        surface: secondaryBlack,
        background: primaryBlack,
        onPrimary: primaryBlack,
        onSecondary: primaryBlack,
        onSurface: white,
        onBackground: white,
        error: Color(0xFFFF6B6B),
        onError: white,
      ),
      
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: primaryBlack,
        foregroundColor: white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: white,
        ),
        iconTheme: const IconThemeData(color: white),
      ),
      
      // Scaffold
      scaffoldBackgroundColor: primaryBlack,
      
      // Cards
      cardTheme: CardThemeData(
        color: secondaryBlack,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: gold,
          foregroundColor: primaryBlack,
          elevation: 4,
          shadowColor: gold.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Botones de texto
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: gold,
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondaryBlack,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: mediumGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: gold, width: 2),
        ),
        labelStyle: GoogleFonts.poppins(color: silverGray),
        hintStyle: GoogleFonts.poppins(color: silverGray),
      ),
      
      // Text Styles
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: white,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: white,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: white,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: white,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: white,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: white,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: white,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: white,
        ),
        titleSmall: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: silverGray,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: white,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: white,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: silverGray,
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: secondaryBlack,
        selectedItemColor: gold,
        unselectedItemColor: silverGray,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: white,
        size: 24,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: mediumGray,
        thickness: 1,
      ),
    );
  }

  // ===== TEMA CLARO (OPCIONAL) =====
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.poppins().fontFamily,
      
      colorScheme: const ColorScheme.light(
        primary: gold,
        secondary: premiumGold,
        surface: offWhite,
        background: white,
        onPrimary: primaryBlack,
        onSecondary: primaryBlack,
        onSurface: primaryBlack,
        onBackground: primaryBlack,
      ),
      
      // Configuración similar pero para modo claro
      appBarTheme: AppBarTheme(
        backgroundColor: white,
        foregroundColor: primaryBlack,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryBlack,
        ),
      ),
      
      scaffoldBackgroundColor: white,
      
      cardTheme: CardThemeData(
        color: offWhite,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
} 