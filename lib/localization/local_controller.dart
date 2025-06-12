import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'setting_service.dart';

class LocalController extends GetxController {
  late SettingService service;
  late Locale initLocal;

  @override
  void onInit() {
    super.onInit();
    service = Get.find();
    initLocal = service.sharedref.getString('local') == null
        ? Get.deviceLocale!
        : Locale(service.sharedref.getString('local')!);
  }

  void changeLang(String codeLang) {
    Locale locale = Locale(codeLang);
    service.sharedref.setString('local', codeLang);
    Get.updateLocale(locale);
  }
}
