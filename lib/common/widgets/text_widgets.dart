import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DmSansFontText extends StatelessWidget {
  const DmSansFontText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
       this.color});

  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: GoogleFonts.dmSans(
        color: color??const Color(0xffFFFFFF),
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
