class LibraryModel {
  final String id;
  final String name;
  final String description;
  final String path;

  LibraryModel(this.id, this.name, this.description, this.path);

  LibraryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        path = json['path'];
}
