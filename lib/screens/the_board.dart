import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/screens/game_controller.dart';
import 'package:tic_tac_toe/theme/colors.dart';

class TheBoard extends StatelessWidget {
  const TheBoard({
    super.key,
    required this.controller,
  });
  final XOController controller;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 9,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Obx(
          () => GestureDetector(
            onTap: () {
         
              controller.gameEnded.value ? null : controller.playMove(index);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColorLight,
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(8),
              child: Center(
                  child: Text(
                controller.board[index],
                style: TextStyle(
                    fontSize: 80,
                    color: controller.board[index] == 'X' ? blue : yellow),
              )),
            ),
          ),
        );
      },
    );
  }
}
