import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get lightTheme => ThemeData(
    // brightness: Brightness.light,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.lato(
        fontSize: 16,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.grey,
      foregroundColor: Colors.white,
    ),
    textTheme: Typography(
        black: TextTheme(
      titleLarge: GoogleFonts.aBeeZee(
        fontSize: 28,
      ),
      labelLarge: GoogleFonts.aBeeZee(
        fontSize: 16,
      ),
      labelMedium: GoogleFonts.aBeeZee(
        fontSize: 16,
        color: Colors.grey
      ),
    )).black,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      surface: Colors.white,

      seedColor: Colors.purple,
      primary: Colors.black54,
      secondary: Colors.teal,
      // scrim: Colors.black,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ));
