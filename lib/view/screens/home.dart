import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controller/home_controller.dart';
import 'package:restaurant/utils/constants/app_color.dart';
import 'package:restaurant/utils/constants/app_routes.dart';
import 'package:restaurant/utils/functions/handlingstatusrequest_withfailure.dart';
import 'package:restaurant/view/widgets/home/drawer_items.dart';
import 'package:restaurant/view/widgets/home/home_menu_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControllerImp homeController = Get.put(HomeControllerImp());
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: const DrawerItems(),
      ),

      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await homeController.getMenu();
            },
          ),
        ],
        title: const Text('Home'),
      ),
      body: GetBuilder<HomeControllerImp>(
        builder:
            (controller) => HandlingstatusrequestWithfailure(
              statusRequest: controller.statusRequest,
              widget: ListView.builder(
                itemCount: controller.menuItems.length,
                itemBuilder: (context, index) {
                  var item = controller.menuItems[index];
                  return HomeMenuItem(
                    imgPath: item.imagePath,
                    itemName: item.name,
                    itemPrice: item.price,
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
      bottomNavigationBar: GetBuilder<HomeControllerImp>(
        builder:
            (controller) =>
                controller.panierMenuItems.isNotEmpty
                    ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                          ),
                          onPressed: () {
                            controller.onAddToCart();
                          },
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    )
                    : SizedBox(),
      ),
    );
  }
}
