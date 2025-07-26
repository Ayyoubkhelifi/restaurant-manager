import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant/controller/home_controller.dart';
import 'package:restaurant/controller/menu_controller.dart';
import 'package:restaurant/model/menu_item_model.dart';
import 'package:restaurant/utils/constants/status_request.dart';
import 'package:restaurant/utils/local%20db/db_helper.dart';

abstract class AddMenuItemController extends GetxController {
  addMenuItem();
  Future<void> pickImage();
}

class AddMenuItemControllerImp extends AddMenuItemController {
  StatusRequest statusRequest = StatusRequest.none;
  MenuControllerImp menuController = Get.find();
  HomeControllerImp homeController = Get.find();
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final costCtrl = TextEditingController();
  File? imageFile;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    priceCtrl.dispose();
    costCtrl.dispose();
    super.dispose();
  }

  @override
  addMenuItem() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        statusRequest = StatusRequest.loading;
        update();
        MenuItem menuItem = MenuItem(
          id: null,
          name: nameCtrl.text.trim(),
          price: double.parse(priceCtrl.text),
          cost: double.parse(costCtrl.text),
          imagePath: imageFile?.path,
        );
        await DbHelper.instance.insertMenuItem(menuItem);
        statusRequest = StatusRequest.success;
        update();
        menuController.getMenu();
        homeController.getMenu();
        Get.back();
      } catch (e) {
        print("Error fetching menu items: $e");
        statusRequest = StatusRequest.serverexception;
      }
      update();
    }
  }

  @override
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile = File(picked.path);
      update();
    }
  }
}
