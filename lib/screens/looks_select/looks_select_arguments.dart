import 'package:bontempo/blocs/looks_schedule/index.dart';

class LooksSelectArguments {
  final DateTime date;
  final LooksScheduleBloc looksScheduleBloc;
  LooksSelectArguments({required this.date, required this.looksScheduleBloc});
}
