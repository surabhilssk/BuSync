import 'package:busync/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataListTileAdmin extends StatelessWidget {
  const DataListTileAdmin(
      {required this.title, required this.subtitle, super.key});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 5),
      margin: const EdgeInsets.only(bottom: 5, top: 18),
      decoration: BoxDecoration(
        color: buttonFontColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: fieldColor),
          child: const Icon(
            Icons.person,
            color: buttonFontColor,
          ),
        ),
        title: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        subtitle: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: buttonColor,
          ),
        ),
      ),
    );
  }
}
