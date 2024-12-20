import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constant/theme.dart';


ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  // secondaryHeaderColor: Colors.black26,
  primarySwatch: Colors.grey,

  // canvasColor: Colors.white12,  // هذا فيه حاجات
  secondaryHeaderColor: Colors.white10,

  appBarTheme:  AppBarTheme(
    toolbarHeight: 80,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
    ),
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.alexandria().fontFamily,
    ),
  ),
  fontFamily: GoogleFonts.tajawal().fontFamily,


);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  secondaryHeaderColor: MyTheme.primaryColor,
  // primarySwatch: primary,

  // secondaryHeaderColor: Colors.black,

  appBarTheme:  AppBarTheme(
    toolbarHeight: 80,
    backgroundColor: MyTheme.primaryColor,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      // color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.alexandria().fontFamily,
    ),
  ),



  // fontFamily: 'Jannah'
  // fontFamily: GoogleFonts.notoKufiArabic().fontFamily
  fontFamily: GoogleFonts.tajawal().fontFamily,

);
