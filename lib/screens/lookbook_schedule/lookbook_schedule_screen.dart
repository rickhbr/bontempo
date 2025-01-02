import 'package:bontempo/blocs/events/index.dart';
import 'package:bontempo/blocs/looks_schedule/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/sized_box_loader.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/look_calendar_model.dart';
import 'package:bontempo/screens/lookbook_schedule_details/lookbook_schedule_details_arguments.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:bontempo/components/general/calendar.dart'
    show CalendarCarousel, EventList;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LookBookScheduleScreen extends StatefulWidget {
  @override
  _LookBookScheduleScreenState createState() => _LookBookScheduleScreenState();
}

class _LookBookScheduleScreenState extends State<LookBookScheduleScreen> {
  final DateTime now = new DateTime.now();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LooksScheduleBloc>(context).add(LoadLooksScheduleEvent());
    BlocProvider.of<EventsBloc>(context).add(CheckEventsPermissionEvent());
  }

  CalendarCarousel getCarousel(List<LookCalendarModel> events) {
    EventList<Event> _markedDateMap = new EventList<Event>(events: {
      for (var item in events)
        new DateTime(int.parse(item.year), int.parse(item.month),
            int.parse(item.day)): new List.filled(
          item.total,
          Event(
            date: new DateTime(int.parse(item.year), int.parse(item.month),
                int.parse(item.day)),
          ),
        )
    });
    return CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        Navigator.pushNamed(
          context,
          LookBookScheduleDetailsViewRoute,
          arguments: LookBookScheduleDetailsArguments(
            date: date,
          ),
        ).then((_) {
          BlocProvider.of<LooksScheduleBloc>(context)
              .add(LoadLooksScheduleEvent());
        });
      },
      nextDaysTextStyle: TextStyle(
        color: black[50],
      ),
      prevDaysTextStyle: TextStyle(
        color: black[50],
      ),
      selectedDayTextStyle: TextStyle(
        color: black,
      ),
      todayTextStyle: TextStyle(
        color: white,
      ),
      weekendTextStyle: TextStyle(
        color: black,
      ),
      weekdayTextStyle: TextStyle(
        color: black,
      ),
      locale: 'pt',
      thisMonthDayBorderColor: black[50]!,
      // markedDates: _markedDate,
      weekFormat: false,
      headerTextStyle: TextStyle(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
      markedDatesMap: _markedDateMap,
      iconColor: black,
      height: 438.0,
      showIconBehindDayText: false,
      daysHaveCircularBorder: false,
      dayPadding: 1.0,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 0,
      markedDateMoreShowTotal: true,
      markedDateIconOffset: 0,
      markedDateIconBuilder: (event) {
        return Container(
          color: Colors.blueAccent,
          height: 3.0,
          width: 3.0,
        );
      },
      minSelectedDate: DateTime(now.year, now.month, 1),
      todayButtonColor: black[50]!,
      todayBorderColor: black[50]!,
    );
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
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(120),
                descriptionPadding: ScreenUtil().setWidth(70),
                titlePadding: 62.0,
                backButton: true,
                title: 'Agenda de Looks',
                description: 'Montamos uma agenda de Looks para sua semana.',
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
                    bottom: ScreenUtil().setHeight(36),
                    // top: ScreenUtil().setWidth(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocBuilder<LooksScheduleBloc, LooksScheduleState>(
                        builder: (BuildContext ctx, LooksScheduleState state) {
                          if (state is LoadedLooksScheduleState) {
                            return getCarousel(state.schedule);
                          } else {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(80),
                                    vertical: ScreenUtil().setWidth(10),
                                  ),
                                  child: SizedBoxLoader(
                                    width: double.infinity,
                                    height: ScreenUtil().setWidth(30),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 1,
                                    vertical: 1,
                                  ),
                                  child: SizedBoxLoader(
                                    width: double.infinity,
                                    height: ScreenUtil().setWidth(300),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      BlocBuilder<EventsBloc, EventsState>(
                        builder: (BuildContext ctx, EventsState state) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: ScreenUtil().setWidth(30),
                              left: ScreenUtil().setWidth(30),
                              right: ScreenUtil().setWidth(30),
                            ),
                            child: CommonButton(
                              bordered: false,
                              margin: EdgeInsets.only(
                                bottom: ScreenUtil().setWidth(6),
                              ),
                              theme: CustomTheme.black,
                              onTap: (state is CheckedPermissionState &&
                                      !state.valid)
                                  ? () {
                                      BlocProvider.of<EventsBloc>(context)
                                          .add(AuthorizeCalendarEvent());
                                    }
                                  : null,
                              child: (state is CheckingPermissionState)
                                  ? Material(
                                      color: Colors.transparent,
                                      child: SizedBox(
                                        width: ScreenUtil().setWidth(30),
                                        height: ScreenUtil().setWidth(30),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'assets/svg/calendar.svg',
                                          height: ScreenUtil().setWidth(22),
                                          width: ScreenUtil().setWidth(25),
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(12),
                                        ),
                                        Text(
                                          (state is CheckedPermissionState &&
                                                  state.valid)
                                              ? 'AGENDA GOOGLE CONECTADA'
                                              : 'CONECTAR AGENDA GOOGLE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          );
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
