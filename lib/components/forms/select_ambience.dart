import 'package:bontempo/models/environment_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectAmbience extends StatefulWidget {
  final Function(String) onSelected;
  final List<EnvironmentModel>? environments;

  const SelectAmbience({
    Key? key,
    required this.onSelected,
    this.environments,
  }) : super(key: key);

  @override
  _SelectAmbienceState createState() => _SelectAmbienceState();
}

class _SelectAmbienceState extends State<SelectAmbience> {
  bool _loaded = true;
  String? _selected;

  Widget loader() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: ScreenUtil().setWidth(18),
        height: ScreenUtil().setWidth(18),
        child: CircularProgressIndicator(
          strokeWidth: 1,
          valueColor: AlwaysStoppedAnimation<Color>(
            black[200]!,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(18)),
      child: Container(
        height: ScreenUtil().setWidth(50),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: black[50]!,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selected,
            isExpanded: true,
            icon: _loaded
                ? Icon(
                    Icons.keyboard_arrow_down,
                    color: black[200],
                    size: ScreenUtil().setSp(18),
                  )
                : loader(),
            hint: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              child: Text(
                "Ambiente",
                style: TextStyle(
                  color: black[200],
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            items: widget.environments!.map((EnvironmentModel environment) {
              return DropdownMenuItem<String>(
                value: environment.name,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  child: Text(
                    environment.name,
                    style: TextStyle(
                      color: black[200],
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selected = newValue;
              });
              widget.onSelected(newValue!);
            },
          ),
        ),
      ),
    );
  }
}
