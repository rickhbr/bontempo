import 'package:bontempo/models/library_folder_model.dart';
import 'package:dio/dio.dart';
import 'package:bontempo/main.dart';
import 'package:bontempo/providers/api.dart';

class LibraryRepository {
  static final LibraryRepository _libraryRepositorySingleton =
      LibraryRepository._internal();
  factory LibraryRepository() {
    return _libraryRepositorySingleton;
  }
  LibraryRepository._internal();

  final ApiProvider api = getIt.get<ApiProvider>();

  Future<Map<String, dynamic>> getLibrary(
      {String? search, String? folder}) async {
    try {
      Response response = await api.dio.get(
        '${api.endpointMoodboard}/library',
        queryParameters: {
          if (search != null) 'search': search,
          if (folder != null) 'folder': folder,
        },
      );
      Map<String, dynamic> data = response.data;
      data['items'] = List<LibraryFolderModel>.from(
        data['data']['library']
                ?.map((item) => LibraryFolderModel.fromJson(item)) ??
            [],
      );

      return data;
    } catch (error) {
      throw api.handleError(error);
    }
  }
}
