// models/menu_item.dart
class MenuItem {
  int? id;
  String name;
  double price;
  double cost;
  String? imagePath; // Path to local image file

  MenuItem({
    this.id,
    required this.name,
    required this.price,
    this.imagePath,
    required this.cost,
  });

  factory MenuItem.fromMap(Map<String, dynamic> m) => MenuItem(
    id: m['id'],
    name: m['name'],
    price: m['price'],
    cost: m['cost'],
    imagePath: m['imagePath'],
  );

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'name': name,
    'price': price,
    'cost': cost,
    'imagePath': imagePath,
  };
}
