import 'package:auto_size_text/auto_size_text.dart';
import 'package:bontempo/blocs/project/index.dart';
import 'package:bontempo/blocs/project/project_bloc.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/project_model.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectScreen extends StatefulWidget {
  ProjectModel model;
  ProjectScreen(this.model);
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<ProjectBloc, ProjectState>(
      listener: (BuildContext ctx, ProjectState state) {
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
        if (state is LoadedArchitectsState) {
          setState(() {
            _loading = false;
          });
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(80),
                title: widget.model.name,
                backButton: true,
                backRoute: StoresViewRoute,
                description: '',
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
                    Container(
                      width: double.maxFinite,
                      color: Colors.grey[200],
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(30),
                        right: ScreenUtil().setWidth(30),
                        bottom: ScreenUtil().setHeight(36),
                        top: ScreenUtil().setWidth(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info,
                                color: Colors.black,
                                size: ScreenUtil().setSp(16),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(8),
                              ),
                              AutoSizeText(
                                "Vendedor vai entrar em contato!",
                                maxLines: 1,
                                group: AutoSizeGroup(),
                                textAlign: TextAlign.start,
                                minFontSize: 11,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic,
                                  fontSize: ScreenUtil().setSp(13),
                                  fontWeight: FontWeight.w500,
                                  height: .9,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setWidth(24),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: ScreenUtil().setWidth(300),
                            padding: EdgeInsets.all(ScreenUtil().setWidth(24)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey[400]!),
                            ),
                            child: GridView.builder(
                              itemCount: widget.model.images.length,
                              itemBuilder: (context, index) {
                                var image = widget.model.images[index];
                                return Image.network(
                                  image.file,
                                  width: ScreenUtil().setWidth(324),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                );
                              },
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: ScreenUtil().setWidth(2) /
                                    ScreenUtil().setWidth(1),
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
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
                          /*CommonButton(
                            theme: CustomTheme.transparent,
                            onTap: () {
                              Navigator.pushNamed(context, ProjectViewRoute);
                            },
                            bordered: true,
                            child: Text(
                              'EDITAR PROJETO',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setWidth(24),
                          ),
                          CommonButton(
                            theme: CustomTheme.green,
                            onTap: () {},
                            child: Text(
                              'EXPORTAR PDF',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),*/
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
}
