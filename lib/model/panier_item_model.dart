// models/panier_item.dart
import 'package:flutter/material.dart';

class PanierItem {
  int? id;
  int panierId;
  String name;
  double price;
  double cost;
  String? imagePath;
  int quantity;
  PanierItem({
    this.id,
    required this.panierId,
    required this.name,
    required this.price,
    required this.cost,
    required this.imagePath,
    required this.quantity,
  });
  factory PanierItem.fromMap(Map<String, dynamic> m) => PanierItem(
    id: m['id'],
    panierId: m['panier_id'],
    name: m['name'],
    price: m['price'],
    cost: m['cost'],
    imagePath: m['imagePath'],
    quantity: m['quantity'],
  );
  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'panier_id': panierId,
    'name': name,
    'price': price,
    'cost': cost,
    'imagePath': imagePath,
    'quantity': quantity,
  };
}
