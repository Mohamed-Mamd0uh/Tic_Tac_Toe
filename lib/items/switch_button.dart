import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/items/custom_container.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    super.key,
    required this.xtap,
  });

  final RxBool xtap;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomContainer(otap: xtap.value, text: 'X'),
          CustomContainer(otap: !xtap.value, text: 'O'),
        ],
      ),
    );
  }
}
