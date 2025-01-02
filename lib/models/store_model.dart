class StoreModel {
  final String id;
  final String name;
  final String address;
  final String? image;

  StoreModel({
    required this.id,
    required this.name,
    required this.address,
    this.image,
  });

  StoreModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        name = json['name'] ?? '',
        address = json['address'] ?? '',
        image = json['image'] != null ? json['image'] : null;
}
