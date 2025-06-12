import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/constants/enums.dart';
import 'package:tic_tac_toe/constants/sound_Path.dart';
import 'package:tic_tac_toe/items/custom_choose_button.dart';
import 'package:tic_tac_toe/items/custom_button.dart';
import 'package:tic_tac_toe/items/language_switcher.dart';
import 'package:tic_tac_toe/items/switch_button.dart';
import 'package:tic_tac_toe/localization/local_controller.dart';
import 'package:tic_tac_toe/localization/setting_service.dart';
import '../theme/colors.dart';
import '../theme/text_strings.dart';
import 'game_screen.dart';
import 'game_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    XOController controller = Get.put(XOController());
    Get.put(LocalController());
    Get.put(SettingService()).init();

    RxBool xtap = false.obs;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const LanguageSwitcher(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('X',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: blue)),
                  Text('O',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: yellow)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  xtap.value = !xtap.value;
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColorLight,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(MTexts.pickFirstPlayer.tr),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: 220,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor,
                          ),
                          child: SwitchButton(xtap: xtap),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              MyButton(
                text: MTexts.playSolo.tr,
                color: yellow,
                onTap: () async {
                  bool difficultySelected = false;
                  await Get.defaultDialog(
                      title: MTexts.chooseTheDifficulty.tr,
                      middleText: '',
                      backgroundColor: primaryColor,
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //CustomChooseButton
                            CustomChooseButton(
                                text: MTexts.easy.tr,
                                onTap: () {
                                  controller.difficulty = Difficulty.easy;
                                  difficultySelected = true;
                                  Get.back();
                                },
                                textColor: Colors.lightGreen),
                            CustomChooseButton(
                                text: MTexts.medium.tr,
                                onTap: () {
                                  controller.difficulty = Difficulty.medium;
                                  difficultySelected = true;
                                  Get.back();
                                },
                                textColor: Colors.yellow),
                            CustomChooseButton(
                                text: MTexts.hard.tr,
                                onTap: () {
                                  controller.difficulty = Difficulty.hard;
                                  difficultySelected = true;
                                  Get.back();
                                },
                                textColor: Colors.red),
                          ],
                        )
                      ]);
                  if (difficultySelected) {
                    // controller.playSound(MSoundPath.start);
                    String playerMark = xtap.value ? 'X' : 'O';
                    controller.isAiGame = true;
                    Get.to(
                      () => GameScreen(
                        current: playerMark,
                        controller: controller,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              MyButton(
                text: MTexts.playWithFriends.tr,
                color: blue,
                onTap: () {
                  controller.playSound(MSoundPath.start);
                  String playerMark = xtap.value ? 'X' : 'O';
                  controller.isAiGame = false;
                  Get.to(() =>
                      GameScreen(current: playerMark, controller: controller));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
