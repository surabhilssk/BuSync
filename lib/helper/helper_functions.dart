import 'package:busync/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//display error message to user
void displayMessageToUser(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: fieldColor,
            title: Text(
              message,
              style: GoogleFonts.poppins(color: buttonFontColor),
            ),
          ));
}
