import 'package:bontempo/blocs/looks/index.dart';
import 'package:bontempo/blocs/looks_schedule/index.dart';
import 'package:bontempo/components/cards/look_card.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/no_results.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/sized_box_loader.dart';
import 'package:bontempo/models/look_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class LooksSelectScreen extends StatefulWidget {
  final DateTime date;

  const LooksSelectScreen({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  _LooksSelectScreenState createState() => _LooksSelectScreenState();
}

class _LooksSelectScreenState extends State<LooksSelectScreen> {
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

  void selectLook(LookModel look) {
    showScaleDialog(
      context: context,
      child: CustomDialog(
        title: 'Selecionar look?',
        description:
            'Tem certeza que deseja adicionar o look selecionado à sua agenda do dia ${DateFormat.yMMMMd('pt').format(widget.date)}?',
        buttonText: 'Confirmar',
        cancelText: "Cancelar",
        callback: () {
          BlocProvider.of<LooksScheduleBloc>(context).add(
            AddLooksScheduleEvent(
              date: widget.date.toIso8601String().substring(0, 10),
              idLook: look.id,
            ),
          );
          Navigator.of(context).pop();
        },
      ),
    );
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
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(120),
                descriptionPadding: 44.0,
                backButton: true,
                title: 'Adicionar Look',
                description:
                    'Selecione o look desejado para adicionar ao dia ${DateFormat.yMMMMd('pt').format(widget.date)}',
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
                                Material(
                                  color: Colors.transparent,
                                  child: ButtonTheme(
                                    child: TextButton(
                                      onPressed: () {
                                        this.selectLook(this._looks[index]);
                                      },
                                      child: LookCard(
                                        look: this._looks[index],
                                      ),
                                    ),
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
