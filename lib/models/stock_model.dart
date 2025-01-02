class StockModel {
  final int id;
  final String title;
  final int quantity;

  StockModel({
    required this.id,
    required this.quantity,
    required this.title,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id'] ?? 0,
      quantity: json['quantity'] is int
          ? json['quantity']
          : int.parse(json['quantity'] ?? '0'),
      title: json['title'] ?? '',
    );
  }

  StockModel copyWith({
    int? id,
    String? title,
    int? quantity,
  }) {
    return StockModel(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
    );
  }
}
