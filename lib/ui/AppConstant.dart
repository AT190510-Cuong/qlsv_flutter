import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static Color appbarcolor = Colors.deepPurple;
  static Color backgroundcolor = const Color.fromARGB(255, 186, 167, 220);

  static TextStyle textfancyheader =
      GoogleFonts.flavors(fontSize: 40, color: Colors.deepPurple[300]);
  static TextStyle textfancyheader2 =
      GoogleFonts.flavors(fontSize: 30, color: Colors.deepPurple[300]);

  static TextStyle texterror = TextStyle(
      color: Colors.red[300], fontSize: 16, fontStyle: FontStyle.italic);
  static TextStyle textlink =
      TextStyle(color: Colors.purple[300], fontSize: 16);

  // static TextStyle appbarcolor = TextStyle(color: Colors.purple[300]);

  static TextStyle textbody =
      TextStyle(color: Colors.deepPurple[300], fontSize: 16);
  static TextStyle textbodywhite = TextStyle(color: Colors.white, fontSize: 16);
  static TextStyle textbodywhitebold =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle textbodyfocus =
      const TextStyle(color: Colors.deepPurple, fontSize: 20);
  static TextStyle textbodyfocuswhite =
      const TextStyle(color: Colors.white, fontSize: 20);

  static bool isDate(String str) {
    try {
      var inputFormat = DateFormat('dd/MM/yyyy');
      var date1 = inputFormat.parseStrict(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
