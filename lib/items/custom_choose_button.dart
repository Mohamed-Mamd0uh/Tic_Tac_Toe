import 'package:flutter/material.dart';
import 'package:tic_tac_toe/theme/colors.dart';

class CustomChooseButton extends StatelessWidget {
  const CustomChooseButton({
    super.key,
    this.onTap,
    required this.text,
    this.textColor,
  });
  final void Function()? onTap;
  final String text;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: primaryColorLight, borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: textColor),
        ),
      ),
    );
  }
}