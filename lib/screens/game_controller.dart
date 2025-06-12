// ignore_for_file: avoid_print

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:tic_tac_toe/constants/enums.dart';
import 'package:tic_tac_toe/constants/sound_path.dart';

class XOController extends GetxController {
  RxList<String> board = RxList<String>(List.generate(9, (index) => ''));
  RxString currentPlayer = ''.obs;
  RxString winner = ''.obs;
  RxBool gameEnded = false.obs;
  RxInt countX = 0.obs;
  RxInt countO = 0.obs;
  RxInt rounds = 0.obs;
  bool isAiGame = false;
  String aiMark = '';
  String humanMark = '';
 final AudioPlayer audioPlayer = AudioPlayer();
  Difficulty difficulty = Difficulty.hard;
  late BuildContext context;
  int setMaxDepth() {
    switch (difficulty) {
      case Difficulty.easy:
        return 2;
      case Difficulty.medium:
        return 4;
      case Difficulty.hard:
        return 100;
    }
  }

  void setPlayerMark(String player) {
    humanMark = player;
    aiMark = (humanMark == 'X') ? 'O' : 'X';

    currentPlayer.value = aiMark;
    resetGame();
    makeAIMove();
  }

  Future<void> playSound(String soundPath) async {
   
    try {
        await audioPlayer.stop();
      await audioPlayer.play(AssetSource(soundPath));
    } catch (e) {
          print("Error playing sound: $e");
    }
  }

  void playMove(int index) {
    if (board[index] == '' && !gameEnded.value) {
      currentPlayer.value == 'X'
          ? playSound(MSoundPath.xSound)
          : playSound(MSoundPath.oSound);
      board[index] = currentPlayer.value;
      checkWinner();
      if (!gameEnded.value) {
        togglePlayer();

        if (currentPlayer.value == aiMark && isAiGame) {
          Future.delayed(const Duration(milliseconds: 500), () {
      
            aiMark == 'X'
                ? playSound(MSoundPath.xSound)
                : playSound(MSoundPath.oSound);
            makeAIMove();
          });
        }
      }
    }
  }

  void updateScores() {
    winner.value == 'X' ? countX++ : countO++;
    rounds++;
  }

  void resetScores() {
    countO = 0.obs;
    countX = 0.obs;
    rounds = 0.obs;
  }

  void togglePlayer() {
    currentPlayer.value = (currentPlayer.value == 'X') ? 'O' : 'X';
  }

  void checkWinner() {
    const winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombinations) {
      final a = board[combo[0]];
      final b = board[combo[1]];
      final c = board[combo[2]];

      if (a != '' && a == b && a == c) {
        winner.value = a;
        updateScores();
        playSound(MSoundPath.win);

        _showWinDialog(context);
        gameEnded.value = true;
        return;
      }
    }

    if (!board.contains('')) {
      updateScores();
      playSound(MSoundPath.draw);
      _showDrawDialog(context);
      gameEnded.value = true;
    }
  }

  void makeAIMove() {
    if (!gameEnded.value && currentPlayer.value == aiMark) {
      int bestMove = getBestMove(board);
      if (bestMove != -1) {
        playMove(bestMove);
      }
    }
  }

  int getBestMove(List<String> board) {
    int bestScore = -10000;
    int move = -1;
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = aiMark;
        int score = minimax(board.toList(), 0, false, setMaxDepth());
        board[i] = '';
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    return move;
  }

  int minimax(List<String> board, int depth, bool isMaximizing, int maxDepth) {
    String? result = checkWinnerForMinimax(board);
    if (result != null || depth >= maxDepth) {
      if (result == aiMark) return 10 - depth;
      if (result == humanMark) return -10 + depth;
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -10000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = aiMark;
          int score = minimax(board.toList(), depth + 1, false, maxDepth);
          board[i] = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 10000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = humanMark;
          int score = minimax(board.toList(), depth + 1, true, maxDepth);
          board[i] = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

  String? checkWinnerForMinimax(List<String> board) {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final line in lines) {
      final a = board[line[0]];
      final b = board[line[1]];
      final c = board[line[2]];
      if (a != '' && a == b && a == c) {
        return a;
      }
    }

    if (!board.contains('')) {
      return 'Draw';
    }

    return null;
  }

  void resetGame() {
    board.value = List.generate(9, (index) => '');
    currentPlayer.value = isAiGame ? aiMark : humanMark;
    winner.value = '';

    gameEnded.value = false;
    if (isAiGame) makeAIMove();
  }

  void _showWinDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: '$winner Wins!',
      btnOkOnPress: resetGame,
      dismissOnTouchOutside: false, // منع الإغلاق باللمس خارج الحوار
      dismissOnBackKeyPress: false,
    ).show();
  }

  void _showDrawDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: 'Draw!',
      btnOkOnPress: resetGame,
      dismissOnTouchOutside: false, // منع الإغلاق باللمس خارج الحوار
      dismissOnBackKeyPress: false,
    ).show();
  }
}
