import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant/controller/home_controller.dart';
import 'package:restaurant/model/menu_item_model.dart';
import 'package:restaurant/model/panier_item_model.dart';
import 'package:restaurant/model/panier_model.dart';
import 'package:restaurant/utils/constants/app_routes.dart';
import 'package:restaurant/utils/constants/status_request.dart';
import 'package:restaurant/utils/local%20db/db_helper.dart';
import 'dart:developer' as developer;

abstract class PanierController extends GetxController {
  dataInit();
  onChanged(int menuId, String value);
  onAdd(int menuId);
  onRemove(int menuId);
  onSubmit();
}

class PanierControllerImp extends PanierController {
  List<MenuItem> panierMenuItems = [];
  StatusRequest statusRequest = StatusRequest.success;
  HomeControllerImp homeController = Get.find();
  double totalPrice = 0.0;
  double totalCost = 0.0;
  double totalRevenue = 0.0;
  final Map<int, TextEditingController> qtyCtrls = {};
  final Map<int, int> quantities = {}; // track current values

  @override
  void onInit() {
    dataInit();
    super.onInit();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  dataInit() {
    panierMenuItems = Get.arguments['panierMenuItems'] ?? [];
    quantities.addAll(Get.arguments['quantities'] ?? {});
    for (var item in panierMenuItems) {
      qtyCtrls[item.id!] = TextEditingController(
        text: quantities[item.id!]?.toString() ?? '0',
      );
    }
    calcTotals();
    updatePanierItems();
  }

  @override
  onChanged(int menuId, String value) {
    if (value.trim().isEmpty) {
      return;
    }
    final qty = int.tryParse(value) ?? 0;
    quantities[menuId] = qty;

    updatePanierItems();
    homeController.onChanged(menuId, value);
  }

  @override
  onAdd(int menuId) {
    final current = quantities[menuId] ?? 0;
    final updated = current + 1;
    quantities[menuId] = updated;
    qtyCtrls[menuId]?.text = '$updated';

    updatePanierItems();
    homeController.onAdd(menuId);
  }

  @override
  onRemove(int menuId) {
    final current = quantities[menuId] ?? 0;
    if (current > 0) {
      final updated = current - 1;
      quantities[menuId] = updated;
      qtyCtrls[menuId]?.text = '$updated';

      updatePanierItems();
      homeController.onRemove(menuId);
    }
  }

  void disposeControllers() {
    qtyCtrls.values.forEach((c) => c.dispose());
  }

  calcTotals() {
    totalPrice = panierMenuItems.fold(0.0, (sum, item) {
      final qty = quantities[item.id!] ?? 0;
      return sum + (item.price * qty);
    });
    totalCost = panierMenuItems.fold(0.0, (sum, item) {
      final qty = quantities[item.id!] ?? 0;
      return sum + (item.cost * qty);
    });
    totalRevenue = totalPrice - totalCost;
    update();
  }

  @override
  onSubmit() async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      if (panierMenuItems.isEmpty) {
        Get.snackbar('Error', 'Your cart is empty');
        return;
      }
      Panier panier = Panier(totalPrice: totalPrice, totalCost: totalCost);
      Panier insertedPanier = await DbHelper.instance.insertPanier(
        panier,
      ); // This returns the new ID
      if (insertedPanier.id == null) {
        Get.snackbar('Error', 'Failed to create panier');
        return;
      }
      List<PanierItem> toInsertItems = [];
      for (var item in panierMenuItems) {
        int quantity = quantities[item.id!] ?? 0;
        if (quantity > 0) {
          toInsertItems.add(
            PanierItem(
              panierId: insertedPanier.id!, // Use the returned ID here
              name: item.name,
              price: item.price,
              cost: item.cost,
              imagePath: item.imagePath,
              quantity: quantity,
            ),
          );
        }
      }
      await DbHelper.instance.insertPanierItemsBatch(toInsertItems);
      Get.snackbar('Success', 'Panier created successfully');
      statusRequest = StatusRequest.success;
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Error', 'Failed to create panier: $e');
      developer.log('Error creating panier: $e');
      statusRequest = StatusRequest.serverexception;
    }

    update();
  }

  updatePanierItems() {
    calcTotals();
    panierMenuItems =
        panierMenuItems.where((item) {
          final qty = quantities[item.id!] ?? 0;
          return qty > 0;
        }).toList();
    update();
  }
}
