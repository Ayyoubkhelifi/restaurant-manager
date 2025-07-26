import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant/utils/constants/app_color.dart';
import 'package:restaurant/utils/functions/format_double.dart';

class PanierHistoryItem extends StatelessWidget {
  final DateTime createdAt;
  final double itemTotalCost;
  final double itemTotalPrice;
  const PanierHistoryItem({
    super.key,
    required this.createdAt,
    required this.itemTotalCost,
    required this.itemTotalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${createdAt.toLocal().toString().split('.').first}"),
      subtitle: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text:
                  "${formatDouble(itemTotalPrice)} - ${formatDouble(itemTotalCost)} = ",
              style: TextStyle(fontSize: 12),
            ),
            TextSpan(
              text: "${formatDouble(itemTotalPrice - itemTotalCost)} DA",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      trailing: Text(
        '${formatDouble(itemTotalPrice)} DA',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}
