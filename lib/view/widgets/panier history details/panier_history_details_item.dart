import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant/utils/constants/app_color.dart';
import 'package:restaurant/utils/functions/format_double.dart';

class PanierHistoryDetailsItem extends StatelessWidget {
  final String? imgPath;
  final String itemName;
  final int itemquantity;
  final double itemPrice;
  final double itemCost;

  const PanierHistoryDetailsItem({
    required this.imgPath,
    required this.itemName,
    required this.itemquantity,
    required this.itemPrice,
    required this.itemCost,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // leading
            imgPath != null
                ? Image.file(
                  File(imgPath!),
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                )
                : const Placeholder(fallbackWidth: 90, fallbackHeight: 90),
            const SizedBox(width: 8),
            // title and subtitle
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Cost: ${formatDouble(itemCost)} DA',
                    style: TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'Price: ${formatDouble(itemPrice)} DA',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Total: ${(formatDouble(itemPrice * itemquantity))} DA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            // trailing
            SizedBox(
              width: 80,
              height: 90,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantity: ${itemquantity}',
                    style: TextStyle(fontSize: 12),
                  ),

                  Text(
                    '+${formatDouble((itemPrice - itemCost) * itemquantity)} DA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
