import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant/utils/functions/format_double.dart';

class HomeMenuItem extends StatelessWidget {
  final String? imgPath;
  final String itemName;
  final double itemPrice;
  final double itemCost;
  final TextEditingController qtyCtrl;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final void Function(dynamic) onChanged;

  const HomeMenuItem({
    required this.imgPath,
    required this.itemName,
    required this.itemPrice,
    required this.itemCost,
    required this.qtyCtrl,
    required this.onAdd,
    required this.onRemove,
    required this.onChanged,
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
                  SizedBox(height: 20),
                  Text(
                    '${formatDouble(itemPrice)} DA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    '${formatDouble(itemCost)} DA',
                    style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            // trailing
            SizedBox(
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: IconButton(
                      color: Colors.green,
                      icon: const Icon(Icons.add, size: 20),
                      onPressed: onAdd,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: TextFormField(
                      controller: qtyCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        onChanged(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: IconButton(
                      color: Colors.red,
                      icon: const Icon(Icons.remove, size: 20),
                      onPressed: onRemove,
                      padding: EdgeInsets.zero,
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
