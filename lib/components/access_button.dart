import 'package:busync/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccessButton extends StatelessWidget {
  const AccessButton({required this.text, required this.onTap, super.key});

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //text
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: buttonFontColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            //icon
            const Icon(
              Icons.arrow_forward_ios,
              color: buttonFontColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
