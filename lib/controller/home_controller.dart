import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant/model/menu_item_model.dart';
import 'package:restaurant/utils/constants/app_routes.dart';
import 'package:restaurant/utils/constants/status_request.dart';
import 'package:restaurant/utils/local%20db/db_helper.dart';
import 'dart:developer' as developer;

abstract class HomeController extends GetxController {
  getMenu();
  onChanged(int menuId, String value);
  onAdd(int menuId);
  onRemove(int menuId);
  onAddToCart();
}

class HomeControllerImp extends HomeController {
  List<MenuItem> menuItems = [];
  List<MenuItem> panierMenuItems = [];
  StatusRequest statusRequest = StatusRequest.none;

  final Map<int, TextEditingController> qtyCtrls = {};
  final Map<int, int> quantities = {}; // track current values

  @override
  void onInit() async {
    await getMenu();
    super.onInit();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  getMenu() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      menuItems = await DbHelper.instance.getAllMenuItems();
      menuItems.forEach((m) {
        qtyCtrls[m.id!] = TextEditingController(text: '0');
        quantities[m.id!] = 0;
      });
      updatePanierItems();
      statusRequest =
          menuItems.isEmpty ? StatusRequest.failure : StatusRequest.success;
    } catch (e) {
      developer.log('Error fetching menu items: $e');
      statusRequest = StatusRequest.serverexception;
    }
    update();
  }

  @override
  onChanged(int menuId, String value) {
    final qty = int.tryParse(value) ?? 0;
    quantities[menuId] = qty;
    updatePanierItems();
  }

  @override
  onAdd(int menuId) {
    final current = quantities[menuId] ?? 0;
    final updated = current + 1;
    quantities[menuId] = updated;
    qtyCtrls[menuId]?.text = '$updated';
    updatePanierItems();
  }

  @override
  onRemove(int menuId) {
    final current = quantities[menuId] ?? 0;
    if (current > 0) {
      final updated = current - 1;
      quantities[menuId] = updated;
      qtyCtrls[menuId]?.text = '$updated';
      updatePanierItems();
    }
  }

  void disposeControllers() {
    qtyCtrls.values.forEach((c) => c.dispose());
  }

  updatePanierItems() {
    panierMenuItems.clear();
    panierMenuItems =
        menuItems.where((item) {
          final qty = quantities[item.id!] ?? 0;
          return qty > 0;
        }).toList();
    update();
  }

  @override
  onAddToCart() {
    updatePanierItems();

    if (panierMenuItems.isNotEmpty) {
      // Here you can handle the panierMenuItems, e.g., navigate to cart screen
      Get.toNamed(
        AppRoutes.panier,
        arguments: {
          'panierMenuItems': panierMenuItems,
          'quantities': quantities,
        },
      );
    } else {
      Get.snackbar('Cart', 'Your cart is empty');
    }
  }
}
