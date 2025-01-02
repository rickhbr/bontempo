class ProjectCreateModel {
  String name;
  String architect;
  int environmentId;
  int storeId;
  int userId;
  List<String> images;
  List<int> libraryImages;

  ProjectCreateModel({
    required this.name,
    required this.architect,
    required this.environmentId,
    required this.storeId,
    required this.userId,
    this.images = const [],
    this.libraryImages = const [],
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'environment_id': this.environmentId,
        'architect': this.architect,
        'store_id': this.storeId,
        'user_id': this.userId,
        'images': this.images,
        'library_images':
            this.libraryImages.isEmpty ? null : this.libraryImages,
      };
}
