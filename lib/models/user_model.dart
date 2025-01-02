class UserModel {
  final int id;
  String name;
  String firstName;
  String email;
  String phone;
  String avatarUrl;
  // String cpf;
  bool hasFurniture;

  UserModel({
    required this.id,
    required this.name,
    required this.firstName,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    // required this.cpf,
    required this.hasFurniture,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        firstName = json['computed_firstname'] ?? '',
        email = json['email'] ?? '',
        phone = json['phone'] ?? '',
        avatarUrl = json['avatar'] != null ? json['avatar']['url'] ?? '' : '',
        // cpf = json['cpf'] ?? '',
        hasFurniture = json['computed_has_furniture'] ?? false;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'computed_firstname': firstName,
        'email': email,
        'phone': phone,
        'avatar': {
          'url': avatarUrl,
        },
        // 'cpf': cpf,
        'computed_has_furniture': hasFurniture,
      };
}
