import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class BlizerfiCustomButton extends StatelessWidget {
  const BlizerfiCustomButton({
    super.key,
    this.text,
    required this.onPressed,
    this.borderRadius,
    this.gradientColor,
    this.borderShapeRadius,
    this.textColor,
    this.backGroundColor,
    this.fontWeight,
    this.size
  });

  final String? text;
  final void Function()? onPressed;
  final List<Color>? gradientColor;
  final Color? backGroundColor;
  final double? borderRadius;
  final double? borderShapeRadius;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            
            colors: gradientColor ??
                [
                  const Color(0xff15508D),
                  const Color(0xff1D6FC3)
                ], 
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        child: DmSansFontText(
          text: text,
          fontSize: size??20,
          fontWeight:fontWeight??FontWeight.w500 ,
          color: textColor ?? const Color(0xffFFFFFF),
        ),
      ),
    );
  }
}
