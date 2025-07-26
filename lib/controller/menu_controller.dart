import 'package:get/get.dart';
import 'package:restaurant/model/menu_item_model.dart';
import 'package:restaurant/utils/constants/status_request.dart';
import 'package:restaurant/utils/local%20db/db_helper.dart';
import 'dart:developer' as developer;

abstract class MenuController extends GetxController {
  getMenu();
}

class MenuControllerImp extends MenuController {
  List<MenuItem> menuItems = [];
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() async {
    await getMenu();
    super.onInit();
  }

  @override
  getMenu() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      menuItems = await DbHelper.instance.getAllMenuItems();
      statusRequest =
          menuItems.isEmpty ? StatusRequest.failure : StatusRequest.success;
    } catch (e) {
      developer.log('Error fetching menu items: $e');
      statusRequest = StatusRequest.serverexception;
    }
    update();
  }
}
