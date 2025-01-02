import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bontempo/blocs/project_create/index.dart';
import 'package:bontempo/components/buttons/button_group.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/buttons/lookbook_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/custom_form.dart';
import 'package:bontempo/components/forms/select_ambience.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/environment_model.dart';
import 'package:bontempo/models/project_create_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProjectCreateScreen extends StatefulWidget {
  final int storeId;
  const ProjectCreateScreen(this.storeId, {Key? key}) : super(key: key);

  @override
  _ProjectCreateScreenState createState() => _ProjectCreateScreenState();
}

class _ProjectCreateScreenState extends State<ProjectCreateScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  bool _loading = false;
  final ImagePicker _picker = ImagePicker();

  ProjectCreateModel model = ProjectCreateModel(
    name: '',
    environmentId: 0,
    architect: '',
    storeId: 0,
    userId: 0,
  );

  TextEditingController controller = TextEditingController();
  TextEditingController architectController = TextEditingController();

  List<EnvironmentModel> _environments = [];
  Map<String, String> _library = {};
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<ProjectCreateBloc>(context).add(LoadEnvironmentsEvent());
    controller.addListener(() {
      model.name = controller.value.text;
    });
    architectController.addListener(() {
      model.architect = architectController.value.text;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    architectController.dispose();
    super.dispose();
  }

  void createProject() {
    if (model.name.isEmpty) {
      showScaleDialog(
        context: context,
        child: CustomDialog(
          title: 'Informe o nome do projeto',
          description: 'O nome deve ser informado',
          buttonText: "Fechar",
        ),
      );
      return;
    }

    if (model.environmentId == 0) {
      showScaleDialog(
        context: context,
        child: CustomDialog(
          title: 'Informe o ambiente',
          description: 'O ambiente deve ser informado',
          buttonText: "Fechar",
        ),
      );
      return;
    }

    model.storeId = widget.storeId;
    model.images = [];

    // Convert image IDs from String to int and assign to model.libraryImages
    model.libraryImages = _library.values.map((id) => int.parse(id)).toList();

    for (var image in _images) {
      model.images.add(
          "data:image/jpg;base64," + base64Encode(image.readAsBytesSync()));
    }

    if (model.images.isEmpty && model.libraryImages.isEmpty) {
      showScaleDialog(
        context: context,
        child: CustomDialog(
          title: 'Informe pelo menos uma imagem',
          description:
              'Você deve anexar pelo menos uma inspiração e/ou referência',
          buttonText: "Fechar",
        ),
      );
      return;
    }

    print('Dados do modelo: ${model.toJson()}');

    BlocProvider.of<ProjectCreateBloc>(context).add(CreateProjectEvent(model));
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

  Future<void> openGallery() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images == null || images.isEmpty) return;

      setState(() {
        _images = images.map((image) => File(image.path)).toList();
      });
    } catch (e) {
      print('Erro ao abrir galeria: $e');
    }
  }

  void remove(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<ProjectCreateBloc, ProjectCreateState>(
      listener: (BuildContext ctx, ProjectCreateState state) {
        if (state is ErrorEnvironmentsState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is ErrorCreateProjectState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedEnvironmentsState) {
          setState(() {
            _environments = state.items;
            _loading = false;
          });
        }
        if (state is CreatedProjectState) {
          Navigator.pushNamed(
            context,
            ProjectViewRoute,
            arguments: state.model,
          );
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(100),
                expandedHeight: ScreenUtil().setWidth(130),
                backButton: true,
                title: 'Inspirações e \nReferências',
                description:
                    'Digite o nome do seu projeto, selecione o ambiente e carregue suas imagens',
                descriptionPadding: 20.0,
                multiLineTitle: true,
                titlePadding: 20.0,
                descriptionSpace: 15.0,
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
                        buttonTheme: CustomTheme.transparent,
                        fields: [
                          {
                            'capitalize': true,
                            'initialValue': '',
                            'name': 'name',
                            'type': 'text',
                            'inputController': controller,
                            'isRequired': true,
                            'labelText': 'Nome do projeto',
                            'hintText': 'Digite o nome do projeto',
                          }
                        ],
                        onSubmit: () {},
                        disabled: false,
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(16),
                      ),
                      if (_environments.isNotEmpty)
                        SelectAmbience(
                          environments: _environments,
                          onSelected: (value) {
                            final selectedEnvironment =
                                _environments.firstWhere(
                              (element) => element.name == value,
                              orElse: () => EnvironmentModel(id: '0', name: ''),
                            );
                            model.environmentId =
                                int.tryParse(selectedEnvironment.id) ?? 0;
                          },
                        ),
                      SizedBox(
                        height: ScreenUtil().setWidth(16),
                      ),
                      CustomForm(
                        theme: CustomTheme.green,
                        buttonTheme: CustomTheme.black,
                        fields: [
                          {
                            'capitalize': true,
                            'initialValue': '',
                            'name': 'architect',
                            'type': 'text',
                            'inputController': architectController,
                            'isRequired': false,
                            'labelText': 'Nome do arquiteto/especificador',
                            'hintText': 'Nome do arquiteto/especificador',
                          }
                        ],
                        onSubmit: () {},
                        disabled: false,
                      ),
                      if (_images.isNotEmpty)
                        SizedBox(
                          height: 200,
                          child: CarouselSlider.builder(
                            itemCount: _images.length,
                            itemBuilder: (context, key, _) {
                              var image = _images[key];
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Stack(
                                  children: [
                                    Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: GestureDetector(
                                        onTap: () {
                                          remove(key);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                'REMOVER',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            options: CarouselOptions(
                              autoPlay: true,
                              height: 200,
                              enableInfiniteScroll: false,
                            ),
                          ),
                        ),
                      if (_images.isNotEmpty)
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${_images.length.toString()} imagens adicionadas',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ButtonGroup(
                        buttons: <Widget>[
                          LookBookButton(
                            coloredIcon: false,
                            title: 'CARREGAR IMAGEM',
                            icon: 'assets/svg/camera.svg',
                            onTap: openGallery,
                          ),
                          LookBookButton(
                            coloredIcon: false,
                            title: 'BIBLIOTECA BONTEMPO',
                            icon: 'assets/svg/gallery.svg',
                            route: LibraryViewRoute,
                            onResult: (result) {
                              if (result != null) {
                                setState(() {
                                  for (var item in result) {
                                    _images.add(File(item['path']));
                                    _library[item['path']] = item['id'];
                                  }
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(16),
                      ),
                      CommonButton(
                        theme: CustomTheme.green,
                        onTap: createProject,
                        child: Text(
                          'CRIAR PROJETO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
