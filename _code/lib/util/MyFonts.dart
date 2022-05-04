import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFonts {
  static Future<void> init() async {
    coiny();
    // GoogleFonts.config.allowRuntimeFetching = false; //false이면 asset에서 갖고옴.
  }

  static TextStyle coiny({
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? height,
  }) {
    return GoogleFonts.coiny(
      textStyle: textStyle,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }
}
