import 'package:auto_size_text/auto_size_text.dart';
import 'package:bontempo/blocs/stores_details/index.dart';
import 'package:bontempo/components/cards/project_card.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/select_status.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/architects_model.dart';
import 'package:bontempo/models/project_model.dart';
import 'package:bontempo/models/store_model.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoresDetailsScreen extends StatefulWidget {
  final StoreModel store;

  StoresDetailsScreen(this.store);

  @override
  _StoresDetailsScreenState createState() => _StoresDetailsScreenState();
}

class _StoresDetailsScreenState extends State<StoresDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  List<ArchitectsModel> _architects = [];
  List<ProjectModel> _projects = [];

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<StoresDetailsBloc>(context).add(LoadArchitectsEvent());
    BlocProvider.of<StoresDetailsBloc>(context)
        .add(LoadProjectsEvent(int.parse(widget.store.id)));
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoresDetailsBloc, StoresDetailsState>(
      listener: (BuildContext ctx, StoresDetailsState state) {
        if (state is ErrorArchitectsState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is ErrorProjectsState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedArchitectsState) {
          setState(() {
            _architects.addAll(state.items);
            _loading = false;
          });
        }
        if (state is LoadedProjectsState) {
          setState(() {
            _projects.addAll(state.items);
            _loading = false;
          });
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(90),
                backButton: true,
                title: widget.store.name,
                description: 'Confira seus projetos abaixo',
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(30),
                        right: ScreenUtil().setWidth(30),
                        top: ScreenUtil().setWidth(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SelectStatus(
                            onSelected: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(20),
                        right: ScreenUtil().setWidth(20),
                        bottom: ScreenUtil().setHeight(36),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: ScreenUtil().setWidth(280) *
                                (12 /
                                    2), // Passar o tamanho da lista no lugar do 12
                            child: GridView.builder(
                              itemCount: _projects.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return newProjectCard();
                                }
                                var project = _projects[index - 1];
                                return ProjectCard(
                                  model: project,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ProjectViewRoute,
                                      arguments: project,
                                    );
                                  },
                                );
                              },
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: ScreenUtil().setWidth(200) /
                                    ScreenUtil().setWidth(300),
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newProjectCard() {
    return Container(
      margin: EdgeInsets.only(
        right: ScreenUtil().setHeight(10),
        left: ScreenUtil().setHeight(10),
        top: ScreenUtil().setWidth(15),
        bottom: ScreenUtil().setWidth(15),
      ),
      child: Material(
        color: Colors.transparent,
        child: ButtonTheme(
          minWidth: double.infinity,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                ProjectCreateViewRoute,
                arguments: int.parse(widget.store.id),
              );
            },
            child: DottedBorder(
              color: Colors.grey[500]!,
              padding: EdgeInsets.all(2),
              dashPattern: [3, 3],
              child: Container(
                width: ScreenUtil().setWidth(167),
                color: Colors.grey[100],
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.grey[500],
                      size: ScreenUtil().setSp(40),
                    ),
                    SizedBox(
                      height: ScreenUtil().setWidth(16),
                    ),
                    AutoSizeText(
                      "Novo projeto",
                      maxLines: 1,
                      group: AutoSizeGroup(),
                      textAlign: TextAlign.center,
                      minFontSize: 11,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w500,
                        height: .9,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
