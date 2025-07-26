import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:restaurant/controller/panier_controller.dart';
import 'package:restaurant/utils/constants/app_color.dart';
import 'package:restaurant/utils/functions/format_double.dart';
import 'package:restaurant/utils/functions/handlingstatusrequest_withfailure.dart';
import 'package:restaurant/view/widgets/panier/panier_menu_item.dart';

class Panier extends StatelessWidget {
  const Panier({super.key});

  @override
  Widget build(BuildContext context) {
    PanierControllerImp panierController = Get.put(PanierControllerImp());
    return Scaffold(
      appBar: AppBar(title: Text("Panier")),
      body: GetBuilder<PanierControllerImp>(
        builder:
            (controller) => HandlingstatusrequestWithfailure(
              statusRequest: controller.statusRequest,
              widget: ListView.builder(
                itemCount: controller.panierMenuItems.length,
                itemBuilder: (context, index) {
                  var item = controller.panierMenuItems[index];
                  return PanierMenuItem(
                    imgPath: item.imagePath,
                    itemName: item.name,
                    itemPrice: item.price,
                    itemTotalPrice:
                        item.price * (controller.quantities[item.id!] ?? 0),
                    itemCost: item.cost,
                    qtyCtrl: controller.qtyCtrls[item.id]!,
                    onAdd: () {
                      controller.onAdd(item.id!);
                    },
                    onRemove: () {
                      controller.onRemove(item.id!);
                    },
                    onChanged: (value) {
                      controller.onChanged(item.id!, value);
                    },
                  );
                },
              ),
            ),
      ),
      bottomNavigationBar: GetBuilder<PanierControllerImp>(
        builder:
            (controller) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 140,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Revenue: ${formatDouble(controller.totalRevenue)} DA",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          "Cost: ${formatDouble(controller.totalCost)} DA",
                          style: TextStyle(
                            fontSize: 19,
                            fontStyle: FontStyle.italic,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Total Price: ${formatDouble(controller.totalPrice)} DA",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: Get.width / 1.6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                        ),
                        onPressed: () async {
                          await controller.onSubmit();
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.black),
                        ),
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
