import 'package:flutter/material.dart';
import 'package:tic_tac_toe/theme/colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.otap = false,
    required this.text,
    this.height = 50,
    this.width = 100,
  });

  final bool otap;
  final double width;
  final double height;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: otap ? gray : null,
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: otap ? primaryColor : null),
      )),
    );
  }
}
