import 'package:busync/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent(
      {required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.icon,
      this.keyboard,
      super.key});

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Icon icon;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 4, 4, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: fieldColor,
      ),
      child: TextField(
        keyboardType: keyboard,
        style: GoogleFonts.poppins(
          color: buttonFontColor,
        ),
        cursorColor: buttonColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(),
          icon: icon,
          iconColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.focused)
                  ? secondaryColor
                  : secondaryColor),
        ),
        controller: controller,
        obscureText: obscureText,
      ),
    );
  }
}
