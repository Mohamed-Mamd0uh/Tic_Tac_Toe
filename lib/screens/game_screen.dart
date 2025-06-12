import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tic_tac_toe/items/score_card.dart';

import 'package:tic_tac_toe/theme/colors.dart';
import 'package:tic_tac_toe/theme/text_strings.dart';

import 'game_controller.dart';
import 'the_board.dart';

class GameScreen extends StatelessWidget {
  const GameScreen(
      {super.key, required this.current, required this.controller});
  final String current;
  final XOController controller;
  @override
  Widget build(BuildContext context) {
    // XOController controller = Get.put(XOController());
    controller.setPlayerMark(current);
    controller.context = context;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                //rest icon & home icon
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: primaryColorLight,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              controller.currentPlayer.value,
                              style: TextStyle(
                                fontSize: 16,
                                color: controller.currentPlayer.value == 'X'
                                    ? blue
                                    : yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(' Turn'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                      onPressed: () => controller.resetGame(),
                      icon: const Icon(Icons.refresh)),
                  const SizedBox(width: 30),
                  IconButton(
                      onPressed: () {
                        controller.resetScores();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.home)),
                ],
              ),
              const SizedBox(height: 20),
              TheBoard(controller: controller),
              const SizedBox(height: 30),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ScoreCard(
                        title: 'X ${MTexts.wins.tr}',
                        value: controller.countX.value,
                        color: blue),
                    ScoreCard(
                        title: MTexts.rounds.tr,
                        value: controller.rounds.value,
                        color: gray),
                    ScoreCard(
                        title: 'O ${MTexts.wins.tr}',
                        value: controller.countO.value,
                        color: yellow),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
