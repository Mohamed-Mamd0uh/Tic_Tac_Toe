import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService extends GetxService {
  late SharedPreferences sharedref;

  Future<SettingService> init() async {
    sharedref = await SharedPreferences.getInstance();

    return this;
  }
}
