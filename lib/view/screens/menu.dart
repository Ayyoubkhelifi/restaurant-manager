import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controller/menu_controller.dart';
import 'package:restaurant/utils/constants/app_routes.dart';
import 'package:restaurant/utils/functions/format_double.dart';
import 'package:restaurant/utils/functions/handlingstatusrequest_withfailure.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    MenuControllerImp menuController = Get.put(MenuControllerImp());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addMenuItem);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("Menu")),
      body: GetBuilder<MenuControllerImp>(
        builder:
            (controller) => HandlingstatusrequestWithfailure(
              statusRequest: controller.statusRequest,
              widget: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: controller.menuItems.length,
                itemBuilder: (context, index) {
                  var item = controller.menuItems[index];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.editMenuItem,
                        arguments: {'item': item},
                      );
                    },
                    child: Card(
                      child: LayoutBuilder(
                        builder:
                            (context, constraints) => Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    item.imagePath != null
                                        ? Image.file(
                                          File(item.imagePath!),
                                          width: constraints.maxWidth,
                                          height: constraints.maxHeight * 0.6,
                                          fit: BoxFit.cover,
                                        )
                                        : Placeholder(
                                          fallbackWidth: constraints.maxWidth,
                                          fallbackHeight:
                                              constraints.maxHeight * 0.6,
                                        ),
                                    Positioned(
                                      left: 8,
                                      top: 4,
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 5,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            'Price: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                            ),
                                          ),
                                          Text(
                                            '${formatDouble(item.price)} DA',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Wrap(
                                        children: [
                                          Text(
                                            'Cost: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                            ),
                                          ),
                                          Text(
                                            '${formatDouble(item.cost)} DA',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
      ),
    );
  }
}
