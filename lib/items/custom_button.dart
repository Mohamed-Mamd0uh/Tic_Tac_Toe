import 'package:flutter/material.dart';
import 'package:tic_tac_toe/theme/colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.color,
    required this.text,
    this.onTap,
    // this.isFullWidth = true,
  });
  final Color? color;
  final void Function()? onTap;
  final String text;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width:,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: primaryColor),
          ),
        )),
      ),
    );
  }
}
