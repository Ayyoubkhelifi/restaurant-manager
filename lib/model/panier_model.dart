class Panier {
  int? id;
  double totalPrice;
  double totalCost;
  DateTime createdAt;
  Panier({
    this.id,
    required this.totalPrice,
    required this.totalCost,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Panier.fromMap(Map<String, dynamic> m) => Panier(
    id: m['id'],
    createdAt: DateTime.parse(m['created_at']),
    totalPrice: m['total_price'],
    totalCost: m['total_cost'],
  );
  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'total_cost': totalCost,
    'total_price': totalPrice,
    'created_at': createdAt.toIso8601String(),
  };
}
