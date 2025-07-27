import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controller/add_menu_item_controller.dart';
import 'package:restaurant/controller/edit_menu_item_controller.dart';
import 'package:restaurant/utils/constants/app_color.dart';
import 'package:restaurant/utils/functions/handlingstatusrequest_withfailure.dart';

class EditMenuItem extends StatelessWidget {
  const EditMenuItem({super.key});

  @override
  Widget build(BuildContext context) {
    EditMenuItemControllerImp editMenuItemController = Get.put(
      EditMenuItemControllerImp(),
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              editMenuItemController.deleteMenuItem();
            },
            icon: Icon(Icons.delete),
          ),
        ],
        title: Text('Edit Menu Item'),
      ),
      body: GetBuilder<EditMenuItemControllerImp>(
        builder:
            (controller) => HandlingstatusrequestWithfailure(
              statusRequest: editMenuItemController.statusRequest,
              widget: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: controller.formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: controller.nameCtrl,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator:
                            (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'Required'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: controller.priceCtrl,
                        decoration: const InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (double.tryParse(v) == null) {
                            return 'Invalid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: controller.costCtrl,
                        decoration: const InputDecoration(labelText: 'Cost'),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (double.tryParse(v) == null) {
                            return 'Invalid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          controller.imageFile != null
                              ? Image.file(
                                controller.imageFile!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                              : Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.image,
                                  color: Colors.white54,
                                ),
                              ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                iconColor: Colors.black,
                              ),
                              icon: const Icon(Icons.photo_library),
                              label: const Text(
                                'Select Image',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: controller.pickImage,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          iconColor: Colors.black,
                        ),
                        onPressed: () async {
                          await controller.editMenuItem();
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
