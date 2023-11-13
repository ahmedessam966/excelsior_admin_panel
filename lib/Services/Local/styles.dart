import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles with ChangeNotifier {
  Styles();

  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xaaf5f5f5).withOpacity(1),
        colorScheme: const ColorScheme.light(primary: LightColorPalette.darkest),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.assistant(fontSize: 10.sp, fontWeight: FontWeight.w600),
          titleMedium: GoogleFonts.assistant(fontSize: 8.sp, fontWeight: FontWeight.w500),
          titleSmall: GoogleFonts.assistant(fontSize: 6.sp, fontWeight: FontWeight.w500),
          labelLarge: GoogleFonts.exo(fontSize: 8.sp, fontWeight: FontWeight.w600),
          labelMedium: GoogleFonts.exo(fontSize: 6.sp, fontWeight: FontWeight.w600),
          labelSmall: GoogleFonts.exo(fontSize: 4.sp, fontWeight: FontWeight.w600),
          displaySmall: GoogleFonts.assistant(fontSize: 4.sp, fontWeight: FontWeight.w500),
          displayMedium: GoogleFonts.assistant(fontSize: 6.sp, fontWeight: FontWeight.w500),
          displayLarge: GoogleFonts.assistant(fontSize: 8.sp, fontWeight: FontWeight.w500),
        ),

        ///
        searchBarTheme: SearchBarThemeData(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            )),
            backgroundColor: const MaterialStatePropertyAll(Colors.white)),

        ///
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(LightColorPalette.darkest),
          ),
        ),

        ///
        inputDecorationTheme: InputDecorationTheme(
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Colors.red)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Colors.black)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Colors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Colors.black)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),

        ///
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.black, selectionColor: Colors.grey, selectionHandleColor: Colors.green),

        ///
      );
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black87,
      );
}

class LightColorPalette {
  static const Color lightest = Color(0xaae7ffda);
  static const Color secondShade = Color(0xaabfe2ac);
  static const Color thirdShade = Color(0xaa99c482);
  static const Color fourthShade = Color(0xaa68a248);
  static const Color darkest = Color(0xaa046262);
}

class DarkColorPalette {
  static const Color lightest = Color(0xaa96c0c0);
  static const Color secondShade = Color(0xaa729e9e);
  static const Color thirdShade = Color(0xaa548282);
  static const Color fourthShade = Color(0xaa2c5c5c);
  static const Color darkest = Color(0xaa004242);
}
