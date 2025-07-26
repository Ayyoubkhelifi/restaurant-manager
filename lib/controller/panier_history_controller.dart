import 'package:get/get.dart';
import 'package:restaurant/model/menu_item_model.dart';
import 'package:restaurant/model/panier_model.dart';
import 'package:restaurant/utils/constants/status_request.dart';
import 'package:restaurant/utils/local%20db/db_helper.dart';

abstract class PanierHistoryController extends GetxController {
  getAllPaniers();
  calcTotals();
}

class PanierHistoryControllerImp extends PanierHistoryController {
  List<Panier> panierItems = [];
  StatusRequest statusRequest = StatusRequest.none;
  double totalDayCost = 0.0;
  double totalDayRevenue = 0.0;
  double totalDayBenefit = 0.0;
  @override
  void onInit() async {
    await getAllPaniers();
    super.onInit();
  }

  @override
  getAllPaniers() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      panierItems = await DbHelper.instance.getAllPaniers();
      if (panierItems.isEmpty) {
        statusRequest = StatusRequest.failure;
      } else {
        statusRequest = StatusRequest.success;
        calcTotals();
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      print("Error fetching menu items: $e");
    }
    update();
  }

  @override
  calcTotals() {
    totalDayRevenue = panierItems.fold(
      0.0,
      (sum, panier) => sum + panier.totalPrice,
    );
    totalDayCost = panierItems.fold(
      0.0,
      (sum, panier) => sum + panier.totalCost,
    );
    totalDayBenefit = totalDayRevenue - totalDayCost;
    update();
  }
}
