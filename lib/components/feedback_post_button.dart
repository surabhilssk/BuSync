import 'package:busync/themes/colors.dart';
import 'package:flutter/material.dart';

class FeedbackPostButton extends StatelessWidget {
  const FeedbackPostButton({required this.onTap, super.key});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 10),
        child: const Center(
          child: Icon(
            Icons.done,
            color: buttonFontColor,
          ),
        ),
      ),
    );
  }
}
