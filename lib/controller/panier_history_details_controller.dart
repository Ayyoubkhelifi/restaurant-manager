import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controller/history_calendar_controller.dart';
import 'package:restaurant/controller/panier_history_controller.dart';
import 'package:restaurant/model/panier_item_model.dart';
import 'package:restaurant/model/panier_model.dart';
import 'package:restaurant/utils/constants/app_routes.dart';
import 'package:restaurant/utils/constants/status_request.dart';
import 'package:restaurant/utils/local%20db/db_helper.dart';
import 'dart:developer' as developer;

abstract class PanierHistoryDetailsController extends GetxController {
  getPanierDetails();
  deletePanierHistoryItem();
}

class PanierHistoryDetailsControllerImp extends PanierHistoryDetailsController {
  StatusRequest statusRequest = StatusRequest.none;
  late Panier panier;
  late String source;

  List<PanierItem> panierItems = [];

  File? imageFile;

  @override
  void onInit() async {
    panier = Get.arguments['panier'];
    source = Get.arguments['source'];
    await getPanierDetails();
    super.onInit();
  }

  @override
  getPanierDetails() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      panierItems = await DbHelper.instance.getPanierItems(panier.id!);
      statusRequest =
          panierItems.isEmpty ? StatusRequest.failure : StatusRequest.success;
    } catch (e) {
      developer.log('Error fetching menu items: $e');
      statusRequest = StatusRequest.serverexception;
    }
    update();
  }

  @override
  deletePanierHistoryItem() {
    Get.defaultDialog(
      title: 'Delete Menu Item',
      middleText: 'Are you sure you want to delete this item?',
      confirmTextColor: Colors.white,
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      buttonColor: Colors.red,
      onConfirm: () async {
        try {
          await DbHelper.instance.deletePanier(panier.id!);

          if (source == "panier_history") {
            PanierHistoryControllerImp panierHistoryController = Get.find();
            panierHistoryController.getAllPaniers();
          } else if (source == "calendar") {
            HistoryCalendarControllerImp historyCalendarController = Get.find();
            historyCalendarController.getAllPaniers();
            historyCalendarController.filterPaniersByDay(panier.createdAt);
          }
          Get.back();

          Get.snackbar("SUCCESS", "Panier Deleted Successfully");
        } catch (e) {
          Get.snackbar("ERROR", "Failed to delete Panier: $e");
          developer.log('Error deleting menu Panier: $e');
        }
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
