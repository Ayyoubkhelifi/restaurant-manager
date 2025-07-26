import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant/controller/menu_controller.dart';
import 'package:restaurant/model/menu_item_model.dart';
import 'package:restaurant/utils/constants/app_routes.dart';
import 'package:restaurant/utils/constants/status_request.dart';
import 'package:restaurant/utils/local%20db/db_helper.dart';
import 'dart:developer' as developer;

abstract class EditMenuItemController extends GetxController {
  editMenuItem();
  initInputs();
  deleteMenuItem();
  Future<void> pickImage();
}

class EditMenuItemControllerImp extends EditMenuItemController {
  StatusRequest statusRequest = StatusRequest.none;
  MenuControllerImp menuController = Get.find();
  late MenuItem menuItem;
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final costCtrl = TextEditingController();
  File? imageFile;

  @override
  void onInit() async {
    menuItem = Get.arguments['item'];
    initInputs();
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
  editMenuItem() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        statusRequest = StatusRequest.loading;
        update();

        menuItem.name = nameCtrl.text.trim();
        menuItem.price = double.parse(priceCtrl.text);
        menuItem.cost = double.parse(costCtrl.text);
        menuItem.imagePath = imageFile?.path;

        await DbHelper.instance.updateMenuItem(menuItem);
        statusRequest = StatusRequest.success;
        update();
        menuController.getMenu();
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

  @override
  initInputs() {
    nameCtrl.text = menuItem.name;
    priceCtrl.text = menuItem.price.toString();
    costCtrl.text = menuItem.cost.toString();
    if (menuItem.imagePath != null) {
      imageFile = File(menuItem.imagePath!);
    }
    update();
  }

  @override
  deleteMenuItem() {
    Get.defaultDialog(
      title: 'Delete Menu Item',
      middleText: 'Are you sure you want to delete this item?',
      confirmTextColor: Colors.white,
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      buttonColor: Colors.red,
      onConfirm: () {
        try {
          DbHelper.instance.deleteMenuItem(menuItem.id!);
          Get.back();
          menuController.getMenu();
          Get.snackbar("SUCCESS", "Item Deleted Successfully");
        } catch (e) {
          Get.snackbar("ERROR", "Failed to delete item: $e");
          developer.log('Error deleting menu item: $e');
        }
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
