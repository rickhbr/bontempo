import 'package:bontempo/models/library_model.dart';

class LibraryFolderModel {
  final String id;
  final String name;
  final List<LibraryModel> images;

  LibraryFolderModel({
    required this.id,
    required this.name,
    this.images = const [],
  });

  factory LibraryFolderModel.fromJson(Map<String, dynamic> json) {
    return LibraryFolderModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      images: json.containsKey('images') && json['images'] != null
          ? List<LibraryModel>.from(json['images'].map((image) {
              return LibraryModel.fromJson(image);
            }))
          : [],
    );
  }
}
