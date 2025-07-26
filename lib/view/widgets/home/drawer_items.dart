import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controller/theme_controller.dart';
import 'package:restaurant/utils/constants/app_routes.dart';

class DrawerItems extends StatelessWidget {
  final String? imagePath;

  const DrawerItems({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    ThemeControllerImp themeController = Get.find();
    return GetBuilder<ThemeControllerImp>(
      builder:
          (themeController) => ListView(
            children: [
              SizedBox(height: 20),

              Card(
                child: ListTile(
                  onTap: () {
                    Get.toNamed(AppRoutes.menu);
                  },
                  leading: const Icon(Icons.menu_book),
                  title: Text("Menu".tr),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Get.toNamed(AppRoutes.panierHistory);
                  },
                  leading: const Icon(Icons.shopping_cart_outlined),
                  title: Text("History".tr),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Get.toNamed(AppRoutes.historyCalendar);
                  },
                  leading: const Icon(Icons.calendar_month),
                  title: Text("History Calendar".tr),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: Text("Dark Mode".tr),
                  trailing: CupertinoSwitch(
                    value: themeController.isDarkTheme,
                    onChanged: (Value) {
                      themeController.changeTheme();
                    },
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
