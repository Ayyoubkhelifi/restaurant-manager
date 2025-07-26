import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/utils/constants/app_themes.dart';
import 'package:restaurant/utils/services/my_services.dart';

abstract class ThemeController extends GetxController {
  changeTheme();
  initAppTheme();
  handleSystemThemeChanges();
}

class ThemeControllerImp extends ThemeController {
  late ThemeData currentTheme;
  late bool isDarkTheme;
  //  => currentTheme == darkMode;
  String? theme;

  MyServices myServices = Get.find();

  @override
  changeTheme() {
    if (isDarkTheme) {
      isDarkTheme = false;
      myServices.sharedPreferences.setString("theme", "light");
      currentTheme = lightMode;

      update();
    } else {
      isDarkTheme = true;
      myServices.sharedPreferences.setString("theme", "dark");
      currentTheme = darkMode;

      update();
    }
  }

  @override
  void onInit() {
    initAppTheme();
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        handleSystemThemeChanges;
    super.onInit();
  }

  @override
  initAppTheme() {
    theme = myServices.sharedPreferences.getString("theme");
    if (theme == "dark") {
      currentTheme = darkMode;
      isDarkTheme = true;
    } else if (theme == "light") {
      currentTheme = lightMode;
      isDarkTheme = false;
    } else {
      if (WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark) {
        currentTheme = darkMode;
        isDarkTheme = true;
      } else {
        currentTheme = lightMode;
        isDarkTheme = false;
      }
    }
    update();
  }

  @override
  handleSystemThemeChanges() {
    if (myServices.sharedPreferences.getString("theme") == null) {
      // If the app is following the system theme, update dynamically
      final systemTheme =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      currentTheme = systemTheme == Brightness.dark ? darkMode : lightMode;
      isDarkTheme = currentTheme == darkMode;
      update();
    }
  }
}
