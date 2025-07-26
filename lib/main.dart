import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controller/theme_controller.dart';
import 'package:restaurant/routes.dart';
import 'package:restaurant/utils/services/my_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => MyServices().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // LocaleController controller = Get.put(LocaleController());
    Get.put(ThemeControllerImp());

    return GetBuilder<ThemeControllerImp>(
      builder:
          (themeController) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // translations: MyTranslation(),
            // locale: controller.language,
            title: "Progres App",
            // supportedLocales: supportedLocals,
            // localizationsDelegates: localizationsDelegates,
            getPages: routes,
            theme: themeController.currentTheme,
          ),
    );
  }
}
