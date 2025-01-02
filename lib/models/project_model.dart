class ProjectModel {
  final String id;
  final String name;
  final String status;
  final List<ProjectImageModel> images;

  ProjectModel(this.id, this.name, this.status, this.images);

  ProjectModel.fromJson(Map<String, dynamic> json)
      : id = json['id']?.toString() ?? '',
        name = json['name'] ?? '',
        status = json['status'] ?? '',
        images = (json['images'] as List<dynamic>?)
                ?.map((item) => ProjectImageModel.fromJson(item))
                .toList() ??
            [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'images': images.map((image) => image.toJson()).toList(),
    };
  }
}

class ProjectImageModel {
  final String id;
  final String file;

  ProjectImageModel(this.id, this.file);

  ProjectImageModel.fromJson(Map<String, dynamic> json)
      : id = json['id']?.toString() ?? '',
        file = json['file'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file': file,
    };
  }
}
