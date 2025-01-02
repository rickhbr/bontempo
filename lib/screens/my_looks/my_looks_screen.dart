import 'package:bontempo/blocs/looks/index.dart';
import 'package:bontempo/components/buttons/look_action_button.dart';
import 'package:bontempo/components/cards/look_card.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/no_results.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/sized_box_loader.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/look_model.dart';
import 'package:bontempo/screens/lookbook_manage/lookbook_manage_arguments.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLooksScreen extends StatefulWidget {
  @override
  _MyLooksScreenState createState() => _MyLooksScreenState();
}

class _MyLooksScreenState extends State<MyLooksScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  List<LookModel> _looks = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<LooksBloc>(context).add(LoadLooksEvent());
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
      BlocProvider.of<LooksBloc>(context).add(LoadLooksEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<LooksBloc, LooksState>(
      listener: (BuildContext ctx, LooksState state) {
        if (state is ErrorLooksState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedLooksState) {
          setState(() {
            _looks.addAll(state.items);
            _loading = false;
          });
        }
        if (state is DeletedLookState) {
          setState(() {
            _looks.removeWhere((LookModel item) => item.id == state.idLook);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Look excluído com sucesso!"),
              action: SnackBarAction(
                label: 'FECHAR',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
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
                expandedHeight: ScreenUtil().setWidth(120),
                descriptionPadding: 95.0,
                backButton: true,
                title: 'Meus Looks',
                description: 'Veja os looks que você tem cadastrado.',
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
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _looks.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            key: Key('lookCard-${this._looks[index].id}'),
                            padding: EdgeInsets.only(
                              bottom: ScreenUtil().setWidth(50),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  this._looks[index].title ??
                                      'LookBook ${index + 1}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: black,
                                    fontSize: ScreenUtil().setSp(16),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setWidth(17),
                                ),
                                LookCard(
                                  look: this._looks[index],
                                  buttons: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      LookActionButton(
                                        icon: Icons.edit,
                                        callback: () {
                                          Navigator.pushNamed(
                                            context,
                                            LookBookEditViewRoute,
                                            arguments: LookBookManageArguments(
                                                look: this._looks[index]),
                                          );
                                        },
                                      ),
                                      LookActionButton(
                                        icon: Icons.close,
                                        hasDialog: true,
                                        dialogTitle: 'Excluir Look?',
                                        dialogText:
                                            'Você tem certeza que deseja excluir este look? Esta ação não poderá ser desfeita.',
                                        dialogButton: "Excluir",
                                        callback: () {
                                          BlocProvider.of<LooksBloc>(context)
                                              .add(DeleteLookEvent(
                                                  this._looks[index].id));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      BlocBuilder<LooksBloc, LooksState>(
                        builder: (BuildContext ctx, LooksState state) {
                          if (state is LoadingLooksState) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: new List.filled(
                                _looks.length > 0 ? 1 : 5,
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: ScreenUtil().setWidth(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBoxLoader(
                                        width: ScreenUtil().setWidth(96),
                                        height: ScreenUtil().setWidth(19),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setWidth(17),
                                      ),
                                      SizedBoxLoader(
                                        width: double.infinity,
                                        height: ScreenUtil().setWidth(260),
                                      ),
                                    ],
                                  ),
                                ),
                              ).toList(),
                            );
                          }
                          if ((state is LoadedLooksState ||
                                  state is DeletedLookState) &&
                              _looks.length == 0) {
                            return NoResults(
                              text: "Você não possui nenhum look salvo.",
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
