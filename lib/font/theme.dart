import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';


const Color bluishClr = Color(0xFF4e5ae8);
const primaryClr = bluishClr;



class Theme {

}
TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: Colors.grey[700]
    )
  );
}   

TextStyle get HeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold
    )
  );
}   