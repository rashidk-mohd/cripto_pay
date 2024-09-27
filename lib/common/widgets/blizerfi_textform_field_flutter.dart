import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class BlizerfiCustomTextFormField extends StatelessWidget {
  BlizerfiCustomTextFormField(
      {super.key,
      this.hitText,
      required this.controller,
      this.suffix,
      this.validator,
      this.prefix,
      this.keyBoardtype,
      this.lablelTextSize,
      this.inputFormatters,
      this.onChanged,
      this.obscureText});
  final String? hitText;
  final TextEditingController? controller;
  final Widget? suffix;
  final Widget? prefix;
  final String? Function(String?)? validator;
  bool? obscureText = false;
  final double? lablelTextSize;
  final TextInputType? keyBoardtype;
 final void Function(String)? onChanged;
 final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        
        keyboardType:keyBoardtype ,
        onChanged:onChanged ,
          obscureText: obscureText ?? false,
          controller: controller,
          onFieldSubmitted: (value) {
            // Dismiss the keyboard
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            prefixIcon: prefix,
            suffixIcon: suffix,
            labelText: hitText,
            labelStyle:  TextStyle(
              fontSize:lablelTextSize?? 12,
              fontWeight: FontWeight.w500, // Reduce the size of the hint text
              color:
                  Color(0xff626262), // You can also adjust the color if needed
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.4),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
          ),
          validator: validator,
          inputFormatters:inputFormatters),
    );
  }
}
