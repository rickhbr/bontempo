import 'package:bontempo/blocs/events/events_bloc.dart';
import 'package:bontempo/blocs/events/index.dart';
import 'package:bontempo/blocs/looks_schedule/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/buttons/look_action_button.dart';
import 'package:bontempo/components/cards/look_card.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/no_results.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/sized_box_loader.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/event_model.dart';
import 'package:bontempo/models/look_schedule_model.dart';
import 'package:bontempo/screens/lookbook_manage/lookbook_manage_arguments.dart';
import 'package:bontempo/screens/looks_select/looks_select_arguments.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class LookBookScheduleDetailsScreen extends StatefulWidget {
  final DateTime date;

  const LookBookScheduleDetailsScreen({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  _LookBookScheduleDetailsScreenState createState() =>
      _LookBookScheduleDetailsScreenState();
}

class _LookBookScheduleDetailsScreenState
    extends State<LookBookScheduleDetailsScreen> {
  List<LookScheduleModel> _looks = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LooksScheduleBloc>(context).add(LoadLooksScheduleDateEvent(
      widget.date.toIso8601String().substring(0, 10),
    ));
    BlocProvider.of<EventsBloc>(context).add(LoadEventsEvent(
      date: widget.date.toIso8601String().substring(0, 10),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<LooksScheduleBloc, LooksScheduleState>(
      listener: (BuildContext ctx, LooksScheduleState state) {
        if (state is ErrorLooksScheduleState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedLooksDateState) {
          setState(() {
            _looks.addAll(state.looks);
          });
        }
        if (state is AddedLooksScheduleState) {
          setState(() {
            _looks.add(state.lookSchedule);
          });
        }
        if (state is RemovedLooksScheduleState) {
          setState(() {
            _looks.removeWhere(
                (LookScheduleModel item) => item.id == state.idSchedule);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Look removido com sucesso!"),
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
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(120),
                descriptionPadding: 95.0,
                titlePadding: ScreenUtil().setWidth(120),
                backButton: true,
                multiLineTitle: true,
                title:
                    '${widget.date.day.toString().padLeft(2, '0')} de ${toBeginningOfSentenceCase(DateFormat.MMM('pt').format(widget.date))} ${widget.date.year.toString()}',
                description: '',
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
                      BlocBuilder<EventsBloc, EventsState>(
                        builder: (BuildContext context, EventsState state) {
                          if (state is LoadedEventsState &&
                              state.events!.isNotEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: ScreenUtil().setWidth(30),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: state.events!
                                    .map(
                                      (EventModel event) => Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setWidth(7),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '• ${event.hour != null ? "${event.hour} - " : ''}${event.title}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
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
                                LookCard(
                                  look: this._looks[index].look,
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
                                              look: this._looks[index].look,
                                            ),
                                          );
                                        },
                                      ),
                                      LookActionButton(
                                        icon: Icons.close,
                                        hasDialog: true,
                                        dialogTitle: 'Remover look?',
                                        dialogText:
                                            'Você tem certeza que deseja remover este look desta data?',
                                        dialogButton: "Remover",
                                        callback: () {
                                          BlocProvider.of<LooksScheduleBloc>(
                                                  context)
                                              .add(
                                            RemoveLooksScheduleEvent(
                                              this._looks[index].id,
                                            ),
                                          );
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
                      BlocBuilder<LooksScheduleBloc, LooksScheduleState>(
                        builder: (BuildContext ctx, LooksScheduleState state) {
                          if (state is LoadingLooksScheduleState) {
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
                          if ((state is LoadedLooksDateState ||
                                  state is RemovedLooksScheduleState) &&
                              _looks.length == 0) {
                            return NoResults(
                              text:
                                  "Você não possui nenhum look salvo para este dia.",
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                      CommonButton(
                        theme: CustomTheme.green,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            LooksSelectViewRoute,
                            arguments: LooksSelectArguments(
                              date: widget.date,
                              looksScheduleBloc:
                                  BlocProvider.of<LooksScheduleBloc>(context),
                            ),
                          );
                        },
                        child: Text(
                          'ADICIONAR LOOK',
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
            ),
          ],
        ),
      ),
    );
  }
}
