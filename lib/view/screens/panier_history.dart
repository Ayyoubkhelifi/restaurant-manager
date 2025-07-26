import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controller/panier_history_controller.dart';
import 'package:restaurant/utils/constants/app_color.dart';
import 'package:restaurant/utils/constants/app_routes.dart';
import 'package:restaurant/utils/functions/format_double.dart';
import 'package:restaurant/utils/functions/handlingstatusrequest_withfailure.dart';
import 'package:restaurant/view/widgets/panier%20history/panier_history_item.dart';

class PanierHistory extends StatelessWidget {
  const PanierHistory({super.key});

  @override
  Widget build(BuildContext context) {
    PanierHistoryControllerImp panierHistoryController = Get.put(
      PanierHistoryControllerImp(),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Panier History')),
      body: GetBuilder<PanierHistoryControllerImp>(
        builder:
            (controller) => HandlingstatusrequestWithfailure(
              statusRequest: panierHistoryController.statusRequest,
              widget: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Sales",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${controller.panierItems.length}"),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Costs",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                formatDouble(controller.totalDayCost),
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Revenue",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                formatDouble(controller.totalDayRevenue),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Benefit",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                formatDouble(controller.totalDayBenefit),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: panierHistoryController.panierItems.length,
                      itemBuilder: (context, index) {
                        var item = panierHistoryController.panierItems[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.panierHistoryDetails,
                              arguments: {
                                'panier': item,
                                "source": "panier_history",
                              },
                            );
                          },
                          child: PanierHistoryItem(
                            createdAt: item.createdAt,
                            itemTotalCost: item.totalCost,
                            itemTotalPrice: item.totalPrice,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
