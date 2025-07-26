import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant/utils/constants/app_color.dart';
import 'package:restaurant/utils/functions/format_double.dart';

class HistoryCalendarItem extends StatelessWidget {
  final DateTime createdAt;
  final double itemTotalCost;
  final double itemTotalPrice;
  const HistoryCalendarItem({
    super.key,
    required this.createdAt,
    required this.itemTotalCost,
    required this.itemTotalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${createdAt.hour}:${createdAt.minute}:${createdAt.second}"),
      subtitle: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text:
                  "${formatDouble(itemTotalPrice)} - ${formatDouble(itemTotalCost)} = ",
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
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${formatDouble(itemTotalPrice)} DA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: AppColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
