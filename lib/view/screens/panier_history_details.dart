import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controller/panier_history_details_controller.dart';
import 'package:restaurant/utils/constants/app_color.dart';
import 'package:restaurant/utils/functions/format_double.dart';
import 'package:restaurant/utils/functions/handlingstatusrequest_withfailure.dart';
import 'package:restaurant/view/widgets/panier%20history%20details/panier_history_details_item.dart';
import 'package:restaurant/view/widgets/panier%20history/panier_history_item.dart';

class PanierHistoryDetails extends StatelessWidget {
  const PanierHistoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    PanierHistoryDetailsControllerImp panierHistoryDetailsController = Get.put(
      PanierHistoryDetailsControllerImp(),
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              panierHistoryDetailsController.deletePanierHistoryItem();
            },
            icon: Icon(Icons.delete),
          ),
        ],
        title: const Text('Panier History Details'),
      ),
      body: GetBuilder<PanierHistoryDetailsControllerImp>(
        builder:
            (controller) => HandlingstatusrequestWithfailure(
              statusRequest: controller.statusRequest,
              widget: ListView.builder(
                itemCount: controller.panierItems.length,
                itemBuilder: (context, index) {
                  var item = controller.panierItems[index];
                  return PanierHistoryDetailsItem(
                    imgPath: item.imagePath,
                    itemName: item.name,
                    itemPrice: item.price,
                    itemCost: item.cost,
                    itemquantity: item.quantity,
                  );
                },
              ),
            ),
      ),
      bottomNavigationBar: GetBuilder<PanierHistoryDetailsControllerImp>(
        builder:
            (controller) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 120,
                child: Column(
                  children: [
                    Text(
                      "Cost: ${formatDouble(controller.panier.totalCost)} DA",
                      style: TextStyle(
                        fontSize: 19,
                        fontStyle: FontStyle.italic,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "Revenue: ${formatDouble(controller.panier.totalPrice - controller.panier.totalCost)} DA",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Total Price: ${formatDouble(controller.panier.totalPrice)} DA",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
