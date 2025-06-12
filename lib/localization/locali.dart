import 'package:get/get.dart';

class TranslationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'pickFirstPlayer': 'Pick first Player\'s Mark',
          "chooseTheDifficulty": 'Choose the difficulty',
          "playSolo": 'Play Solo',
          "playWithFriends": 'Play with Friends',
          "easy": 'Easy',
          "medium": 'Medium',
          "hard": 'Hard',
          "wins": 'Wins',
          "rounds": 'Rounds',
          "language": 'Language',
          "english": 'English',
          "arabic": 'Arabic',
          "changeLanguage": 'Change Language',
        },
        'ar_AR': {
          "pickFirstPlayer": 'اختر علامة اللاعب الأول',
          "chooseTheDifficulty": 'اختر الصعوبة',
          "playSolo": 'العب منفردًا',
          "playWithFriends": 'العب مع الأصدقاء',
          "easy": 'سهل',
          "medium": 'متوسط',
          "hard": 'صعب',
          "wins": 'فاز',
          "rounds": 'الدورة',
          "language": 'اللغة',
          "english": 'الإنجليزية',
          "arabic": 'العربية',
          "changeLanguage": 'تغيير اللغة',
        },
      };
}
