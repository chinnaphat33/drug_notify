import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

const Color bordertext = Color.fromARGB(255, 26, 61, 99);
const Color bluishClr = Color(0xFF4e5ae8);
const primaryClr = bluishClr;
const blueBorder = bordertext;



class Theme {

}
TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.grey[700]
    )
  );
}   

TextStyle get HeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
    )
  );
}   

TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold
    )
  );
} 

TextStyle get subtitleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold
    )
  );
} 