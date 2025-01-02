class EnvironmentModel {
  final String id;
  final String name;

  EnvironmentModel({required this.id, required this.name});

  EnvironmentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '0',
        name = json['name'] ?? 'Unnamed';
}
