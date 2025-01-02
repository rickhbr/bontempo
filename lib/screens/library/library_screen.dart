import 'package:bontempo/blocs/library/index.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/custom_form.dart';
import 'package:bontempo/components/forms/select_folder.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/models/library_folder_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  String? folder;
  String? search;

  List<LibraryFolderModel> _library = [];
  Set<Map<String, String>> _selectedImages =
      {}; // Use a Set to track selected images
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    this.load();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold && !_loading) {
      setState(() {
        _loading = true;
      });
    }
  }

  void load() {
    BlocProvider.of<LibraryBloc>(context)
        .add(LoadLibraryEvent(folder: this.folder, search: this.search));
  }

  void _toggleImageSelection(Map<String, String> image) {
    setState(() {
      if (_selectedImages
          .any((selectedImage) => selectedImage['id'] == image['id'])) {
        _selectedImages
            .removeWhere((selectedImage) => selectedImage['id'] == image['id']);
      } else {
        _selectedImages.add(image);
      }
    });
  }

  void _confirmSelection() {
    Navigator.pop(context, _selectedImages.toList());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<LibraryBloc, LibraryState>(
      listener: (BuildContext ctx, LibraryState state) {
        if (state is ErrorLibraryState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedLibraryState) {
          setState(() {
            _library = state.items.cast<LibraryFolderModel>();
            _loading = false;
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            controller: _scrollController,
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: CommonHeader(
                  backButton: true,
                  kToolbarHeight: ScreenUtil().setWidth(72),
                  expandedHeight: ScreenUtil().setWidth(120),
                  title: 'Biblioteca',
                  description: 'Selecione fotos a partir de nossa biblioteca',
                  descriptionPadding: 66.0,
                ),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        ScreenUtil().setWidth(150) -
                        ScreenUtil().setHeight(84),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(30),
                      right: ScreenUtil().setWidth(30),
                      bottom: ScreenUtil().setHeight(36),
                      top: ScreenUtil().setWidth(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomForm(
                          theme: CustomTheme.green,
                          buttonTheme: CustomTheme.black,
                          fields: [
                            {
                              'initialValue': '',
                              'name': 'name',
                              'type': 'text',
                              'isRequired': true,
                              'labelText': 'Busque por imagens',
                              'hintText': 'Busque por imagens',
                            }
                          ],
                          submitText: Container(),
                          onSubmit: () {},
                          disabled: null,
                        ),
                        SelectFolder(
                          folders: this._library,
                          onSelected: (value) {
                            setState(() {
                              this.folder = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setWidth(16),
                        ),
                        for (var folder in _library.where((x) =>
                            this.folder == null || x.name == this.folder))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                folder.name,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: folder.images!.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  var image = {
                                    'path': folder.images![index].path,
                                    'id': folder.images![index].id
                                  };
                                  bool isSelected = _selectedImages.any(
                                      (selectedImage) =>
                                          selectedImage['id'] == image['id']);

                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _toggleImageSelection(image);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: isSelected
                                                  ? Colors.blue
                                                  : Colors.transparent,
                                              width: 2,
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Image.network(image['path']!),
                                              if (isSelected)
                                                Positioned(
                                                  top: 8,
                                                  right: 8,
                                                  child: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _selectedImages.isNotEmpty
            ? FloatingActionButton(
                onPressed: _confirmSelection,
                backgroundColor: Colors.green,
                child: Icon(Icons.check, color: Colors.white),
              )
            : null,
      ),
    );
  }
}
