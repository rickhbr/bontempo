library flutter_calendar_dooboo;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
// ignore: implementation_imports
import 'package:flutter_calendar_carousel/src/default_styles.dart';
// ignore: implementation_imports
import 'package:flutter_calendar_carousel/src/calendar_header.dart';
// ignore: implementation_imports
import 'package:flutter_calendar_carousel/src/weekday_row.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;
export 'package:flutter_calendar_carousel/classes/event_list.dart';

typedef MarkedDateIconBuilder<T> = Widget Function(T event);
typedef void OnDayLongPressed(DateTime day);

typedef Widget DayBuilder(
    bool isSelectable,
    int index,
    bool isSelectedDay,
    bool isToday,
    bool isPrevMonthDay,
    TextStyle textStyle,
    bool isNextMonthDay,
    bool isThisMonthDay,
    DateTime day);

typedef Widget WeekdayBuilder(int weekday, String weekdayName);

class CalendarCarousel<T extends EventInterface> extends StatefulWidget {
  final double viewportFraction;
  final TextStyle? prevDaysTextStyle;
  final TextStyle? daysTextStyle;
  final TextStyle? nextDaysTextStyle;
  final Color prevMonthDayBorderColor;
  final Color thisMonthDayBorderColor;
  final Color nextMonthDayBorderColor;
  final double dayPadding;
  final double height;
  final double width;
  final TextStyle? todayTextStyle;
  final Color dayButtonColor;
  final Color todayBorderColor;
  final Color todayButtonColor;
  final DateTime? selectedDateTime;
  final DateTime? targetDateTime;
  final TextStyle? selectedDayTextStyle;
  final Color selectedDayButtonColor;
  final Color selectedDayBorderColor;
  final bool? daysHaveCircularBorder;
  final Function(DateTime, List<T>)? onDayPressed;
  final TextStyle? weekdayTextStyle;
  final Color iconColor;
  final TextStyle? headerTextStyle;
  final String? headerText;
  final TextStyle? weekendTextStyle;
  final EventList<T>? markedDatesMap;
  final Widget? markedDateWidget;
  final ShapeBorder? markedDateCustomShapeBorder;
  final TextStyle? markedDateCustomTextStyle;
  final bool markedDateShowIcon;
  final Color? markedDateIconBorderColor;
  final int markedDateIconMaxShown;
  final double markedDateIconMargin;
  final double markedDateIconOffset;
  final MarkedDateIconBuilder<T>? markedDateIconBuilder;
  final bool? markedDateMoreShowTotal;
  final Decoration? markedDateMoreCustomDecoration;
  final TextStyle? markedDateMoreCustomTextStyle;
  final EdgeInsets headerMargin;
  final double childAspectRatio;
  final EdgeInsets weekDayMargin;
  final EdgeInsets weekDayPadding;
  final WeekdayBuilder? customWeekDayBuilder;
  final DayBuilder? customDayBuilder;
  final Color weekDayBackgroundColor;
  final bool weekFormat;
  final bool showWeekDays;
  final bool showHeader;
  final bool showHeaderButton;
  final Widget? leftButtonIcon;
  final Widget? rightButtonIcon;
  final ScrollPhysics? customGridViewPhysics;
  final Function(DateTime)? onCalendarChanged;
  final String locale;
  final int? firstDayOfWeek;
  final DateTime? minSelectedDate;
  final DateTime? maxSelectedDate;
  final TextStyle? inactiveDaysTextStyle;
  final TextStyle? inactiveWeekendTextStyle;
  final bool headerTitleTouchable;
  final Function()? onHeaderTitlePressed;
  final WeekdayFormat weekDayFormat;
  final bool staticSixWeekFormat;
  final bool isScrollable;
  final Axis scrollDirection;
  final bool showOnlyCurrentMonthDate;
  final bool pageSnapping;
  final OnDayLongPressed? onDayLongPressed;
  final CrossAxisAlignment dayCrossAxisAlignment;
  final MainAxisAlignment dayMainAxisAlignment;
  final bool showIconBehindDayText;
  final ScrollPhysics pageScrollPhysics;

  const CalendarCarousel({
    Key? key,
    this.viewportFraction = 1.0,
    this.prevDaysTextStyle,
    this.daysTextStyle,
    this.nextDaysTextStyle,
    this.prevMonthDayBorderColor = Colors.transparent,
    this.thisMonthDayBorderColor = Colors.transparent,
    this.nextMonthDayBorderColor = Colors.transparent,
    this.dayPadding = 2.0,
    this.height = double.infinity,
    this.width = double.infinity,
    this.todayTextStyle,
    this.dayButtonColor = Colors.transparent,
    this.todayBorderColor = Colors.red,
    this.todayButtonColor = Colors.red,
    this.selectedDateTime,
    this.targetDateTime,
    this.selectedDayTextStyle,
    this.selectedDayBorderColor = Colors.green,
    this.selectedDayButtonColor = Colors.green,
    this.daysHaveCircularBorder,
    this.onDayPressed,
    this.weekdayTextStyle,
    this.iconColor = Colors.blueAccent,
    this.headerTextStyle,
    this.headerText,
    this.weekendTextStyle,
    this.markedDatesMap,
    this.markedDateShowIcon = false,
    this.markedDateIconBorderColor,
    this.markedDateIconMaxShown = 2,
    this.markedDateIconMargin = 5.0,
    this.markedDateIconOffset = 5.0,
    this.markedDateIconBuilder,
    this.markedDateMoreShowTotal,
    this.markedDateMoreCustomDecoration,
    this.markedDateCustomShapeBorder,
    this.markedDateCustomTextStyle,
    this.markedDateMoreCustomTextStyle,
    this.markedDateWidget,
    this.headerMargin = const EdgeInsets.symmetric(vertical: 16.0),
    this.childAspectRatio = 1.0,
    this.weekDayMargin = const EdgeInsets.only(bottom: 4.0),
    this.weekDayPadding = const EdgeInsets.all(0.0),
    this.weekDayBackgroundColor = Colors.transparent,
    this.customWeekDayBuilder,
    this.customDayBuilder,
    this.showWeekDays = true,
    this.weekFormat = false,
    this.showHeader = true,
    this.showHeaderButton = true,
    this.leftButtonIcon,
    this.rightButtonIcon,
    this.customGridViewPhysics,
    this.onCalendarChanged,
    this.locale = "en",
    this.firstDayOfWeek,
    this.minSelectedDate,
    this.maxSelectedDate,
    this.inactiveDaysTextStyle,
    this.inactiveWeekendTextStyle,
    this.headerTitleTouchable = false,
    this.onHeaderTitlePressed,
    this.weekDayFormat = WeekdayFormat.narrow,
    this.staticSixWeekFormat = false,
    this.isScrollable = true,
    this.scrollDirection = Axis.horizontal,
    this.showOnlyCurrentMonthDate = false,
    this.pageSnapping = false,
    this.onDayLongPressed,
    this.dayCrossAxisAlignment = CrossAxisAlignment.center,
    this.dayMainAxisAlignment = MainAxisAlignment.center,
    this.showIconBehindDayText = false,
    this.pageScrollPhysics = const ScrollPhysics(),
  }) : super(key: key);

  @override
  _CalendarState<T> createState() => _CalendarState<T>();
}

class _CalendarState<T extends EventInterface>
    extends State<CalendarCarousel<T>> {
  late PageController _controller;
  late List<DateTime> _dates;
  late List<List<DateTime>> _weeks;
  DateTime _selectedDate = DateTime.now();
  late DateTime _targetDate;
  int _startWeekday = 0;
  int _endWeekday = 0;
  late DateFormat _localeDate;
  int _pageNum = 0;
  late DateTime minDate;
  late DateTime maxDate;

  int firstDayOfWeek = 0;

  /// If the setState called from this class, don't reload the selectedDate, but it should reload selected date if called from external class

  @override
  initState() {
    super.initState();
    initializeDateFormatting();

    minDate = widget.minSelectedDate ?? DateTime(2018);
    maxDate = widget.maxSelectedDate ??
        DateTime(
            DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

    if (widget.selectedDateTime != null)
      _selectedDate = widget.selectedDateTime!;

    if (widget.targetDateTime != null) {
      if (widget.targetDateTime!.difference(minDate).inDays < 0) {
        _targetDate = minDate;
      } else if (widget.targetDateTime!.difference(maxDate).inDays > 0) {
        _targetDate = maxDate;
      } else {
        _targetDate = widget.targetDateTime!;
      }
    } else {
      _targetDate = _selectedDate;
    }

    if (widget.weekFormat) {
      _targetDate = _firstDayOfWeek(_targetDate);
      for (int _cnt = 0;
          0 >
              minDate
                  .add(Duration(days: 7 * _cnt))
                  .difference(_targetDate)
                  .inDays;
          _cnt++) {
        this._pageNum = _cnt + 1;
      }
    } else {
      _targetDate = _selectedDate;
      for (int _cnt = 0;
          0 >
              DateTime(
                minDate.year,
                minDate.month + _cnt,
              )
                  .difference(DateTime(_targetDate.year, _targetDate.month))
                  .inDays;
          _cnt++) {
        this._pageNum = _cnt + 1;
      }
    }

    /// setup pageController
    _controller = PageController(
      initialPage: this._pageNum,
      keepPage: true,
      viewportFraction: widget.viewportFraction,

      /// width percentage
    );

    _localeDate = DateFormat.yMMM(widget.locale);

    if (widget.firstDayOfWeek == null)
      firstDayOfWeek = (_localeDate.dateSymbols.FIRSTDAYOFWEEK + 1) % 7;
    else
      firstDayOfWeek = widget.firstDayOfWeek!;

    _setDate();
  }

  @override
  void didUpdateWidget(CalendarCarousel<T> oldWidget) {
    if (widget.targetDateTime != null && widget.targetDateTime != _targetDate) {
      DateTime targetDate = widget.targetDateTime!;
      if (widget.targetDateTime!.difference(minDate).inDays < 0) {
        targetDate = minDate;
      } else if (widget.targetDateTime!.difference(maxDate).inDays > 0) {
        targetDate = maxDate;
      }
      int _page = this._pageNum;
      if (widget.weekFormat) {
        targetDate = _firstDayOfWeek(targetDate);
        for (int _cnt = 0;
            0 >
                widget.minSelectedDate!
                    .add(Duration(days: 7 * _cnt))
                    .difference(targetDate)
                    .inDays;
            _cnt++) {
          _page = _cnt + 1;
        }
      } else {
        for (int _cnt = 0;
            0 >
                DateTime(
                  widget.minSelectedDate!.year,
                  widget.minSelectedDate!.month + _cnt,
                )
                    .difference(DateTime(targetDate.year, targetDate.month))
                    .inDays;
            _cnt++) {
          _page = _cnt + 1;
        }
      }

      _setDate(_page);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: <Widget>[
          CalendarHeader(
            showHeader: widget.showHeader,
            headerMargin: widget.headerMargin,
            headerTitle: widget.headerText ??
                (widget.weekFormat
                    ? '${_localeDate.format(this._weeks[this._pageNum].first)}'
                    : toBeginningOfSentenceCase(
                        '${DateFormat.yMMMM('pt').format(this._dates[this._pageNum])}',
                      )!),
            headerTextStyle: widget.headerTextStyle,
            showHeaderButtons: widget.showHeaderButton,
            headerIconColor: widget.iconColor,
            leftButtonIcon: widget.leftButtonIcon,
            rightButtonIcon: widget.rightButtonIcon,
            onLeftButtonPressed: () =>
                this._pageNum > 0 ? _setDate(this._pageNum - 1) : null,
            onRightButtonPressed: () => widget.weekFormat
                ? (this._weeks.length - 1 > this._pageNum
                    ? _setDate(this._pageNum + 1)
                    : null)
                : (this._dates.length - 1 > this._pageNum
                    ? _setDate(this._pageNum + 1)
                    : null),
            onHeaderTitlePressed:
                widget.onHeaderTitlePressed ?? () => _selectDateFromPicker(),
          ),
          WeekdayRow(
            firstDayOfWeek,
            widget.customWeekDayBuilder,
            showWeekdays: widget.showWeekDays,
            weekdayFormat: widget.weekDayFormat,
            weekdayMargin: widget.weekDayMargin,
            weekdayPadding: widget.weekDayPadding,
            weekdayBackgroundColor: widget.weekDayBackgroundColor,
            weekdayTextStyle: widget.weekdayTextStyle,
            localeDate: _localeDate,
          ),
          Expanded(
            child: PageView.builder(
              itemCount:
                  widget.weekFormat ? this._weeks.length : this._dates.length,
              physics: widget.isScrollable
                  ? widget.pageScrollPhysics
                  : NeverScrollableScrollPhysics(),
              scrollDirection: widget.scrollDirection,
              onPageChanged: (index) {
                this._setDate(index);
              },
              controller: _controller,
              itemBuilder: (context, index) {
                return widget.weekFormat ? weekBuilder(index) : builder(index);
              },
              pageSnapping: widget.pageSnapping,
            ),
          ),
        ],
      ),
    );
  }

  Widget getDefaultDayContainer(
    bool isSelectable,
    int index,
    bool isSelectedDay,
    bool isToday,
    bool isPrevMonthDay,
    TextStyle? textStyle,
    TextStyle defaultTextStyle,
    bool isNextMonthDay,
    bool isThisMonthDay,
    DateTime now,
  ) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        crossAxisAlignment: widget.dayCrossAxisAlignment,
        mainAxisAlignment: widget.dayMainAxisAlignment,
        children: <Widget>[
          DefaultTextStyle(
            style: getDefaultDayStyle(
              isSelectable,
              index,
              isSelectedDay,
              isToday,
              isPrevMonthDay,
              textStyle,
              defaultTextStyle,
              isNextMonthDay,
              isThisMonthDay,
            ),
            child: Text(
              '${now.day}',
              semanticsLabel: now.day.toString(),
              style: getDayStyle(
                isSelectable,
                index,
                isSelectedDay,
                isToday,
                isPrevMonthDay,
                textStyle,
                defaultTextStyle,
                isNextMonthDay,
                isThisMonthDay,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget renderDay(
    bool isSelectable,
    int index,
    bool isSelectedDay,
    bool isToday,
    bool isPrevMonthDay,
    TextStyle? textStyle,
    TextStyle defaultTextStyle,
    bool isNextMonthDay,
    bool isThisMonthDay,
    DateTime now,
  ) {
    return Container(
      margin: EdgeInsets.all(widget.dayPadding),
      child: GestureDetector(
        onLongPress: () => _onDayLongPressed(now),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: isSelectedDay
                ? widget.selectedDayButtonColor
                : isToday
                    ? widget.todayButtonColor
                    : widget.dayButtonColor,
            padding: EdgeInsets.all(widget.dayPadding),
            shape: widget.markedDateCustomShapeBorder != null &&
                    widget.markedDatesMap != null &&
                    widget.markedDatesMap!.getEvents(now).isNotEmpty
                ? widget.markedDateCustomShapeBorder as OutlinedBorder
                : (widget.daysHaveCircularBorder ?? false)
                    ? CircleBorder(
                        side: BorderSide(
                          color: isSelectedDay
                              ? widget.selectedDayBorderColor
                              : isToday
                                  ? widget.todayBorderColor
                                  : isPrevMonthDay
                                      ? widget.prevMonthDayBorderColor
                                      : isNextMonthDay
                                          ? widget.nextMonthDayBorderColor
                                          : widget.thisMonthDayBorderColor,
                        ),
                      )
                    : RoundedRectangleBorder(
                        side: BorderSide(
                          color: isSelectedDay
                              ? widget.selectedDayBorderColor
                              : isToday
                                  ? widget.todayBorderColor
                                  : isPrevMonthDay
                                      ? widget.prevMonthDayBorderColor
                                      : isNextMonthDay
                                          ? widget.nextMonthDayBorderColor
                                          : widget.thisMonthDayBorderColor,
                        ),
                      ),
          ),
          onPressed: () => _onDayPressed(now),
          child: Stack(
            children: widget.showIconBehindDayText
                ? <Widget>[
                    if (widget.markedDatesMap != null)
                      _renderMarkedMapContainer(now),
                    getDayContainer(
                      isSelectable,
                      index,
                      isSelectedDay,
                      isToday,
                      isPrevMonthDay,
                      textStyle,
                      defaultTextStyle,
                      isNextMonthDay,
                      isThisMonthDay,
                      now,
                    ),
                  ]
                : <Widget>[
                    getDayContainer(
                      isSelectable,
                      index,
                      isSelectedDay,
                      isToday,
                      isPrevMonthDay,
                      textStyle,
                      defaultTextStyle,
                      isNextMonthDay,
                      isThisMonthDay,
                      now,
                    ),
                    if (widget.markedDatesMap != null)
                      _renderMarkedMapContainer(now),
                  ],
          ),
        ),
      ),
    );
  }

  AnimatedBuilder builder(int slideIndex) {
    _startWeekday = _dates[slideIndex].weekday - firstDayOfWeek;
    if (_startWeekday == 7) {
      _startWeekday = 0;
    }
    _endWeekday =
        DateTime(_dates[slideIndex].year, _dates[slideIndex].month + 1, 1)
                .weekday -
            firstDayOfWeek;
    double screenWidth = MediaQuery.of(context).size.width;
    int totalItemCount = widget.staticSixWeekFormat
        ? 42
        : DateTime(
              _dates[slideIndex].year,
              _dates[slideIndex].month + 1,
              0,
            ).day +
            _startWeekday +
            (7 - _endWeekday);
    int year = _dates[slideIndex].year;
    int month = _dates[slideIndex].month;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = 1.0;
        if (_controller.position.haveDimensions) {
          value = _controller.page! - slideIndex;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * widget.height,
            width: Curves.easeOut.transform(value) * screenWidth,
            child: child,
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: GridView.count(
                physics: widget.customGridViewPhysics,
                crossAxisCount: 7,
                childAspectRatio: widget.childAspectRatio,
                padding: EdgeInsets.zero,
                children: List.generate(totalItemCount,

                    /// last day of month + weekday
                    (index) {
                  bool isToday =
                      DateTime.now().day == index + 1 - _startWeekday &&
                          DateTime.now().month == month &&
                          DateTime.now().year == year;

                  bool isSelectedDay = widget.selectedDateTime != null &&
                      widget.selectedDateTime!.year == year &&
                      widget.selectedDateTime!.month == month &&
                      widget.selectedDateTime!.day == index + 1 - _startWeekday;

                  bool isPrevMonthDay = index < _startWeekday;

                  bool isNextMonthDay = index >=
                      (DateTime(year, month + 1, 0).day) + _startWeekday;

                  bool isThisMonthDay = !isPrevMonthDay && !isNextMonthDay;

                  DateTime now = DateTime(year, month, 1);
                  TextStyle? textStyle;
                  TextStyle defaultTextStyle;
                  if (isPrevMonthDay && !widget.showOnlyCurrentMonthDate) {
                    now = now.subtract(Duration(days: _startWeekday - index));
                    textStyle = widget.prevDaysTextStyle;
                    defaultTextStyle = defaultPrevDaysTextStyle;
                  } else if (isThisMonthDay) {
                    now = DateTime(year, month, index + 1 - _startWeekday);
                    textStyle = isSelectedDay
                        ? widget.selectedDayTextStyle
                        : isToday
                            ? widget.todayTextStyle
                            : widget.daysTextStyle;
                    defaultTextStyle = isSelectedDay
                        ? defaultSelectedDayTextStyle
                        : isToday
                            ? defaultTodayTextStyle
                            : defaultDaysTextStyle;
                  } else if (!widget.showOnlyCurrentMonthDate) {
                    now = DateTime(year, month, index + 1 - _startWeekday);
                    textStyle = widget.nextDaysTextStyle;
                    defaultTextStyle = defaultNextDaysTextStyle;
                  } else {
                    return Container();
                  }
                  if (widget.markedDateCustomTextStyle != null &&
                      widget.markedDatesMap != null &&
                      widget.markedDatesMap!.getEvents(now).isNotEmpty) {
                    textStyle = widget.markedDateCustomTextStyle;
                  }
                  bool isSelectable = true;
                  if (minDate.millisecondsSinceEpoch >
                      now.millisecondsSinceEpoch)
                    isSelectable = false;
                  else if (maxDate.millisecondsSinceEpoch <
                      now.millisecondsSinceEpoch) isSelectable = false;
                  return renderDay(
                      isSelectable,
                      index,
                      isSelectedDay,
                      isToday,
                      isPrevMonthDay,
                      textStyle,
                      defaultTextStyle,
                      isNextMonthDay,
                      isThisMonthDay,
                      now);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedBuilder weekBuilder(int slideIndex) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<DateTime> weekDays = _weeks[slideIndex];

    weekDays = weekDays
        .map((weekDay) => weekDay.add(Duration(days: firstDayOfWeek)))
        .toList();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = 1.0;
        if (_controller.position.haveDimensions) {
          value = _controller.page! - slideIndex;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * widget.height,
            width: Curves.easeOut.transform(value) * screenWidth,
            child: child,
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: GridView.count(
                physics: widget.customGridViewPhysics,
                crossAxisCount: 7,
                childAspectRatio: widget.childAspectRatio,
                padding: EdgeInsets.zero,
                children: List.generate(weekDays.length, (index) {
                  /// last day of month + weekday
                  bool isToday = weekDays[index].day == DateTime.now().day &&
                      weekDays[index].month == DateTime.now().month &&
                      weekDays[index].year == DateTime.now().year;
                  bool isSelectedDay =
                      this._selectedDate.year == weekDays[index].year &&
                          this._selectedDate.month == weekDays[index].month &&
                          this._selectedDate.day == weekDays[index].day;
                  bool isPrevMonthDay =
                      weekDays[index].month < this._targetDate.month;
                  bool isNextMonthDay =
                      weekDays[index].month > this._targetDate.month;
                  bool isThisMonthDay = !isPrevMonthDay && !isNextMonthDay;

                  DateTime now = DateTime(weekDays[index].year,
                      weekDays[index].month, weekDays[index].day);
                  TextStyle? textStyle;
                  TextStyle defaultTextStyle;
                  if (isPrevMonthDay && !widget.showOnlyCurrentMonthDate) {
                    textStyle = widget.prevDaysTextStyle;
                    defaultTextStyle = defaultPrevDaysTextStyle;
                  } else if (isThisMonthDay) {
                    textStyle = isSelectedDay
                        ? widget.selectedDayTextStyle
                        : isToday
                            ? widget.todayTextStyle
                            : widget.daysTextStyle;
                    defaultTextStyle = isSelectedDay
                        ? defaultSelectedDayTextStyle
                        : isToday
                            ? defaultTodayTextStyle
                            : defaultDaysTextStyle;
                  } else if (!widget.showOnlyCurrentMonthDate) {
                    textStyle = widget.nextDaysTextStyle;
                    defaultTextStyle = defaultNextDaysTextStyle;
                  } else {
                    return Container();
                  }
                  bool isSelectable = true;
                  if (minDate.millisecondsSinceEpoch >
                      now.millisecondsSinceEpoch)
                    isSelectable = false;
                  else if (maxDate.millisecondsSinceEpoch <
                      now.millisecondsSinceEpoch) isSelectable = false;
                  return renderDay(
                      isSelectable,
                      index,
                      isSelectedDay,
                      isToday,
                      isPrevMonthDay,
                      textStyle,
                      defaultTextStyle,
                      isNextMonthDay,
                      isThisMonthDay,
                      now);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DateTime> _getDaysInWeek([DateTime? selectedDate]) {
    selectedDate ??= DateTime.now();

    var firstDayOfCurrentWeek = _firstDayOfWeek(selectedDate);
    var lastDayOfCurrentWeek = _lastDayOfWeek(selectedDate);

    return _daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek).toList();
  }

  DateTime _firstDayOfWeek(DateTime date) {
    var day = _createUTCMiddayDateTime(date);
    return day.subtract(Duration(days: date.weekday % 7));
  }

  DateTime _lastDayOfWeek(DateTime date) {
    var day = _createUTCMiddayDateTime(date);
    return day.add(Duration(days: 7 - day.weekday % 7));
  }

  DateTime _createUTCMiddayDateTime(DateTime date) {
    // Magic const: 12 is to maintain compatibility with date_utils
    return DateTime.utc(date.year, date.month, date.day, 12, 0, 0);
  }

  Iterable<DateTime> _daysInRange(DateTime start, DateTime end) {
    var offset = start.timeZoneOffset;

    return List<int>.generate(end.difference(start).inDays, (i) => i + 1)
        .map((int i) {
      var d = start.add(Duration(days: i - 1));

      var timeZoneDiff = d.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = d.timeZoneOffset;
        d = d.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
      return d;
    });
  }

  void _onDayLongPressed(DateTime picked) {
    widget.onDayLongPressed!(picked);
  }

  void _onDayPressed(DateTime picked) {
    if (picked == null) return;
    if (minDate.millisecondsSinceEpoch > picked.millisecondsSinceEpoch) return;
    if (maxDate.millisecondsSinceEpoch < picked.millisecondsSinceEpoch) return;

    setState(() {
      _selectedDate = picked;
    });
    widget.onDayPressed!(
      picked,
      widget.markedDatesMap != null
          ? widget.markedDatesMap!.getEvents(picked)
          : [],
    );
  }

  Future<void> _selectDateFromPicker() async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: minDate,
      lastDate: maxDate,
    );

    if (selected != null) {
      // updating selected date range based on selected week
      setState(() {
        _selectedDate = selected;
      });
      widget.onDayPressed!(
        selected,
        widget.markedDatesMap != null
            ? widget.markedDatesMap!.getEvents(selected)
            : [],
      );
    }
  }

  void _setDatesAndWeeks() {
    /// Setup default calendar format
    List<DateTime> date = [];
    int currentDateIndex = 0;
    for (int _cnt = 0;
        0 >=
            DateTime(minDate.year, minDate.month + _cnt)
                .difference(DateTime(maxDate.year, maxDate.month))
                .inDays;
        _cnt++) {
      date.add(DateTime(minDate.year, minDate.month + _cnt, 1));
      if (0 ==
          date.last
              .difference(
                  DateTime(this._targetDate.year, this._targetDate.month))
              .inDays) {
        currentDateIndex = _cnt;
      }
    }

    /// Setup week-only format
    List<List<DateTime>> week = [];
    for (int _cnt = 0;
        0 >=
            minDate
                .add(Duration(days: 7 * _cnt))
                .difference(maxDate.add(Duration(days: 7)))
                .inDays;
        _cnt++) {
      week.add(_getDaysInWeek(minDate.add(Duration(days: 7 * _cnt))));
    }

    _startWeekday = date[currentDateIndex].weekday - firstDayOfWeek;
    /*if (widget.showOnlyCurrentMonthDate) {
    _startWeekday--;
  }*/
    if (/*widget.showOnlyCurrentMonthDate && */ _startWeekday == 7) {
      _startWeekday = 0;
    }
    _endWeekday = DateTime(date[currentDateIndex].year,
                date[currentDateIndex].month + 1, 1)
            .weekday -
        firstDayOfWeek;
    this._dates = date;
    this._weeks = week;
//        this._selectedDate = widget.selectedDateTime != null
//            ? widget.selectedDateTime
//            : DateTime.now();
  }

  void _setDate([int page = -1]) {
    if (page == -1) {
      setState(() {
        _setDatesAndWeeks();
      });
    } else {
      if (widget.weekFormat) {
        setState(() {
          this._pageNum = page;
          this._targetDate = this._weeks[page].first;
        });

        _controller.animateToPage(page,
            duration: Duration(milliseconds: 1), curve: Threshold(0.0));
      } else {
        setState(() {
          this._pageNum = page;
          this._targetDate = this._dates[page];
          _startWeekday = _dates[page].weekday - firstDayOfWeek;
          _endWeekday = _lastDayOfWeek(_dates[page]).weekday - firstDayOfWeek;
        });
        _controller.animateToPage(page,
            duration: Duration(milliseconds: 1), curve: Threshold(0.0));
      }

      //call callback
      if (widget.onCalendarChanged != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onCalendarChanged!(
            !widget.weekFormat
                ? this._dates[page]
                : this._weeks[page][firstDayOfWeek],
          );
        });
      }
    }
  }

  Widget _renderMarkedMapContainer(DateTime now) {
    if (widget.markedDateShowIcon) {
      return Stack(
        children: _renderMarkedMap(now),
      );
    } else {
      return Container(
        height: double.infinity,
        padding: EdgeInsets.only(bottom: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _renderMarkedMap(now),
        ),
      );
    }
  }

  List<Widget> _renderMarkedMap(DateTime now) {
    if (widget.markedDatesMap != null &&
        widget.markedDatesMap!.getEvents(now).isNotEmpty) {
      List<Widget> tmp = [];
      int count = 0;
      int eventIndex = 0;
      double offset = 0.0;
      double padding = widget.markedDateIconMargin;
      widget.markedDatesMap!.getEvents(now).forEach((T event) {
        if (widget.markedDateShowIcon) {
          if (tmp.isNotEmpty && tmp.length < widget.markedDateIconMaxShown) {
            offset += widget.markedDateIconOffset;
          }
          if (tmp.length < widget.markedDateIconMaxShown &&
              widget.markedDateIconBuilder != null) {
            tmp.add(Center(
                child: Container(
              padding: EdgeInsets.only(
                top: padding + offset,
                left: padding + offset,
                right: padding - offset,
                bottom: padding - offset,
              ),
              width: double.infinity,
              height: double.infinity,
              child: widget.markedDateIconBuilder!(event),
            )));
          } else {
            count++;
          }
          if (count > 0 && widget.markedDateMoreShowTotal != null) {
            tmp.add(
              Positioned(
                top: 0.0,
                right: 0.0,
                child: Container(
                  width: widget.markedDateMoreShowTotal! ? 16 : null,
                  height: widget.markedDateMoreShowTotal! ? 16 : null,
                  decoration: widget.markedDateMoreCustomDecoration ??
                      BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(1000.0)),
                      ),
                  child: Center(
                    child: Text(
                      widget.markedDateMoreShowTotal!
                          ? (count + widget.markedDateIconMaxShown).toString()
                          : (count.toString() + '+'),
                      semanticsLabel: widget.markedDateMoreShowTotal!
                          ? (count + widget.markedDateIconMaxShown).toString()
                          : (count.toString() + '+'),
                      style: widget.markedDateMoreCustomTextStyle ??
                          TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ),
            );
          }
        } else {
          //max 5 dots
          if (eventIndex < 5) {
            if (widget.markedDateIconBuilder != null) {
              tmp.add(widget.markedDateIconBuilder!(event));
            } else {
              if (event.getDot() != null) {
                tmp.add(event.getDot()!);
              } else if (widget.markedDateWidget != null) {
                tmp.add(widget.markedDateWidget!);
              } else {
                tmp.add(defaultMarkedDateWidget);
              }
            }
          }
        }

        eventIndex++;
      });
      return tmp;
    }
    return [];
  }

  TextStyle getDefaultDayStyle(
    bool isSelectable,
    int index,
    bool isSelectedDay,
    bool isToday,
    bool isPrevMonthDay,
    TextStyle? textStyle,
    TextStyle defaultTextStyle,
    bool isNextMonthDay,
    bool isThisMonthDay,
  ) {
    return !isSelectable
        ? defaultInactiveDaysTextStyle
        : (_localeDate.dateSymbols.WEEKENDRANGE
                    .contains((index - 1 + firstDayOfWeek) % 7)) &&
                !isSelectedDay &&
                !isToday
            ? (isPrevMonthDay
                ? defaultPrevDaysTextStyle
                : isNextMonthDay
                    ? defaultNextDaysTextStyle
                    : isSelectable
                        ? defaultWeekendTextStyle
                        : defaultInactiveWeekendTextStyle)
            : isToday
                ? defaultTodayTextStyle
                : isSelectable && textStyle != null
                    ? textStyle
                    : defaultTextStyle;
  }

  TextStyle? getDayStyle(
    bool isSelectable,
    int index,
    bool isSelectedDay,
    bool isToday,
    bool isPrevMonthDay,
    TextStyle? textStyle,
    TextStyle defaultTextStyle,
    bool isNextMonthDay,
    bool isThisMonthDay,
  ) {
    return isSelectedDay && widget.selectedDayTextStyle != null
        ? widget.selectedDayTextStyle
        : (_localeDate.dateSymbols.WEEKENDRANGE
                    .contains((index - 1 + firstDayOfWeek) % 7)) &&
                !isSelectedDay &&
                isThisMonthDay &&
                !isToday
            ? (isSelectable
                ? widget.weekendTextStyle
                : widget.inactiveWeekendTextStyle)
            : !isSelectable
                ? widget.inactiveDaysTextStyle
                : isPrevMonthDay
                    ? widget.prevDaysTextStyle
                    : isNextMonthDay
                        ? widget.nextDaysTextStyle
                        : isToday
                            ? widget.todayTextStyle
                            : widget.daysTextStyle;
  }

  Widget getDayContainer(
      bool isSelectable,
      int index,
      bool isSelectedDay,
      bool isToday,
      bool isPrevMonthDay,
      TextStyle? textStyle,
      TextStyle defaultTextStyle,
      bool isNextMonthDay,
      bool isThisMonthDay,
      DateTime now) {
    if (widget.customDayBuilder != null) {
      final TextStyle appTextStyle = DefaultTextStyle.of(context).style;
      TextStyle styleForBuilder = appTextStyle.merge(getDayStyle(
          isSelectable,
          index,
          isSelectedDay,
          isToday,
          isPrevMonthDay,
          textStyle,
          defaultTextStyle,
          isNextMonthDay,
          isThisMonthDay));

      return widget.customDayBuilder!(
              isSelectable,
              index,
              isSelectedDay,
              isToday,
              isPrevMonthDay,
              styleForBuilder,
              isNextMonthDay,
              isThisMonthDay,
              now) ??
          getDefaultDayContainer(
              isSelectable,
              index,
              isSelectedDay,
              isToday,
              isPrevMonthDay,
              textStyle,
              defaultTextStyle,
              isNextMonthDay,
              isThisMonthDay,
              now);
    } else {
      return getDefaultDayContainer(
          isSelectable,
          index,
          isSelectedDay,
          isToday,
          isPrevMonthDay,
          textStyle,
          defaultTextStyle,
          isNextMonthDay,
          isThisMonthDay,
          now);
    }
  }
}
