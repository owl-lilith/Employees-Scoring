// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// bool isDarkTheme = true;

Color kSecondary = const Color.fromARGB(255, 27, 27, 27); // dark gray
Color kPrimary = Colors.white; // background or foreground color
Color kPrimary2 = Colors.blue.shade600.withOpacity(0.7);
Color kLessBlack = Color.fromARGB(255, 50, 50, 50);

var kDrawerLightModeBG = [
  Colors.cyanAccent.shade200,
  Colors.blueAccent.shade200,
  Colors.blueAccent.shade700,
];

var kDrawerDarkModeBG = [
  Colors.cyan.shade500,
  Colors.blue.shade500,
  Colors.blue.shade900,
];

// Testing GoogleFonts with Text Themes

TextTheme textTheme = TextTheme(
  displayLarge: GoogleFonts.jaldi(
      fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  //
  //
  displayMedium: GoogleFonts.jaldi(
      fontSize: 35, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  //
  //
  displaySmall: GoogleFonts.jaldi(fontSize: 16, fontWeight: FontWeight.w400),
  //
  //
  headlineLarge: GoogleFonts.jaldi(
      fontSize: 40, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  //
  //
  headlineMedium: GoogleFonts.jaldi(fontSize: 28, fontWeight: FontWeight.w400),
  //
  //
  headlineSmall: GoogleFonts.jaldi(
      fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  //
  //
  titleMedium: GoogleFonts.jaldi(
      fontSize: 19, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  //
  //
  titleSmall: GoogleFonts.jaldi(
      fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  //
  //
  // bodyLarge: GoogleFontsoboto(
  // fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  //
  //
  // bodyMedium: GoogleFontsoboto(
  // fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  //
  //
  // bodySmall: GoogleFontsoboto(
  // fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  //
  //
  // labelLarge: GoogleFontsoboto(
  // fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  //
  //
  // labelSmall: GoogleFontsoboto(
  // fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  //
  //
);

Map<int, Color> color = {
  50: Color.fromRGBO(0, 0, 0, .1),
  100: Color.fromRGBO(0, 0, 0, .2),
  200: Color.fromRGBO(0, 0, 0, .3),
  300: Color.fromRGBO(0, 0, 0, .4),
  400: Color.fromRGBO(0, 0, 0, .5),
  500: Color.fromRGBO(0, 0, 0, .6),
  600: Color.fromRGBO(0, 0, 0, .7),
  700: Color.fromRGBO(0, 0, 0, .8),
  800: Color.fromRGBO(0, 0, 0, .9),
  900: Color.fromRGBO(0, 0, 0, 1),
};

MaterialColor customColor1 = MaterialColor(0xff000000, color);
MaterialColor customColor2 = MaterialColor(0xffffffff, color);

ThemeData themeData(bool isDarkTheme) {
  return ThemeData(
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isDarkTheme ? kSecondary : kPrimary,
        modalBackgroundColor: isDarkTheme ? kSecondary : kPrimary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDarkTheme ? kPrimary : kSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        width: 300,
        behavior: SnackBarBehavior.floating,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
      ),
      colorScheme: isDarkTheme
          ? ColorScheme.fromSwatch(
              primarySwatch: customColor2,
              accentColor: customColor1,
              cardColor: customColor1,
              backgroundColor: customColor2,
              errorColor: MaterialColor(0xffff0000, color),
              brightness: Brightness.dark)
          : ColorScheme.fromSwatch(
              primarySwatch: customColor1,
              accentColor: customColor2,
              cardColor: customColor2,
              backgroundColor: customColor1,
              errorColor: MaterialColor(0xffff0000, color),
              brightness: Brightness.light,
            ),
      useMaterial3: true,
      fontFamily: "Jaldi",
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(fontSize: 14),
        // counterStyle: kTextFieldDataTextStyle,
        // labelStyle: kTextFieldDataTextStyle,
        suffixIconColor: isDarkTheme ? kPrimary : kSecondary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: BorderSide(
            width: 1,
            color: isDarkTheme ? kPrimary : kSecondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: isDarkTheme ? kPrimary : kSecondary, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
      ),
      primarySwatch: isDarkTheme ? customColor2 : customColor1,
      primaryColor: isDarkTheme ? kPrimary : kSecondary,
      indicatorColor: isDarkTheme ? kPrimary : kSecondary,
      hintColor: isDarkTheme ? kPrimary : kSecondary,
      highlightColor: isDarkTheme ? kPrimary : Colors.transparent,
      listTileTheme: ListTileThemeData(
        textColor: isDarkTheme ? Colors.white : Colors.black,
        iconColor: isDarkTheme ? Colors.white : Colors.black,
        // !isDarkTheme?Color.fromARGB(255, 15, 15, 15): Colors.white,
      ),

      // Long press color
      hoverColor: isDarkTheme ? kSecondary : Colors.white,
      focusColor: isDarkTheme ? kPrimary : kSecondary,
      disabledColor: Colors.grey,
      cardColor: Colors.grey,
      canvasColor: isDarkTheme ? kPrimary : Colors.grey[50],
      shadowColor: isDarkTheme ? Colors.black : kPrimary,
      scaffoldBackgroundColor: isDarkTheme ? kSecondary : kPrimary,
      appBarTheme: AppBarTheme(
        color: isDarkTheme ? kSecondary : kPrimary,
        shadowColor: isDarkTheme ? kPrimary : kPrimary,
        elevation: 0.0,
      ),

      // textButtonTheme: TextButtonThemeData(
      //     style: ButtonStyle(
      //         shadowColor: MaterialStateProperty.all(
      //           isDarkTheme ? Colors.black : kPrimary,
      //         ),
      //         textStyle: MaterialStateProperty.all(TextStyle(
      //           color: isDarkTheme ? kSecondary : kPrimary,
      //         )),
      //         backgroundColor: MaterialStateProperty.all(
      //           isDarkTheme ? kPrimary : kSecondary,
      //         ))),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: kPrimary2,
        cursorColor: isDarkTheme ? kPrimary : kSecondary,
        selectionHandleColor: kPrimary2,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isDarkTheme ? kPrimary : kSecondary,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'Jaldi',
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
      iconTheme: IconThemeData(
        color: !isDarkTheme ? kSecondary : kPrimary,
        opacity: 1,
      ),
      tabBarTheme: TabBarTheme(
        labelStyle: TextStyle(fontSize: 18, fontFamily: "Jaldi"),
        unselectedLabelStyle: TextStyle(
            fontSize: 17, fontFamily: "Jaldi", overflow: TextOverflow.ellipsis),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(kCornerRoundness)
            ),
        backgroundColor: !isDarkTheme ? kPrimary : kSecondary,
        titleTextStyle: TextStyle(
            fontSize: 30,
            fontFamily: 'Jaldi',
            color: !isDarkTheme ? kSecondary : kPrimary),
        contentTextStyle: TextStyle(
            fontSize: 18,
            fontFamily: 'Jaldi',
            color: !isDarkTheme ? kSecondary : kPrimary),
        alignment: Alignment.center,
      ),
      timePickerTheme: TimePickerThemeData(
        confirmButtonStyle: ButtonStyle(
          textStyle: MaterialStatePropertyAll(
            TextStyle(
              color: kPrimary.withOpacity(0.5),
            ),
          ),
        ),
        backgroundColor: isDarkTheme ? kSecondary : kPrimary,
        hourMinuteColor: isDarkTheme
            ? kSecondary.withOpacity(0.3)
            : kPrimary.withOpacity(0.3),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: isDarkTheme ? kSecondary : kPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
            elevation: MaterialStatePropertyAll(12),
            backgroundColor: MaterialStatePropertyAll(
                isDarkTheme ? Color(0xFF1B1B1B) : Colors.white)),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor:
              MaterialStatePropertyAll(isDarkTheme ? kSecondary : kPrimary),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue.shade100;
          }
          return Colors.black;
        }),
        thumbColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Colors.blue.shade700;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(kPrimary2),
      ),
      dividerTheme: DividerThemeData(color: Colors.grey.withOpacity(0.4)));
}
