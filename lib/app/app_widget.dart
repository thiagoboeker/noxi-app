import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
            headline6: GoogleFonts.poppins().copyWith(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        headline5: GoogleFonts.montserrat().copyWith(
        fontSize: 24,
        color: Color(0xff36AFC6),
        fontWeight: FontWeight.w600,
        ),
        headline4: GoogleFonts.poppins().copyWith(
        fontSize: 20,
        color: Color(0xff36AFC6),
        fontWeight: FontWeight.bold,
        ),
        subtitle2: GoogleFonts.poppins().copyWith(
        fontSize: 16,
        color: Colors.white,
        ),
        subtitle1: GoogleFonts.poppins().copyWith(
        fontSize: 16,
        color: Color(0xff444443),
        ),
        button: GoogleFonts.poppins().copyWith(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w700,
        ),
      )),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
