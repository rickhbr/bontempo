class ArchitectsModel {
  final String id;
  final String name;

  ArchitectsModel(this.id, this.name);

  ArchitectsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        name = json['name'] ?? '';
}
