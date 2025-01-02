import 'package:bontempo/models/architects_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectArchitect extends StatefulWidget {
  final Function(String) onSelected;
  final List<ArchitectsModel>? architects;

  const SelectArchitect({
    Key? key,
    this.architects,
    required this.onSelected,
  }) : super(key: key);

  @override
  _SelectArchitectState createState() => _SelectArchitectState();
}

class _SelectArchitectState extends State<SelectArchitect> {
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
                "Arquiteto",
                style: TextStyle(
                  color: black[200],
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            items: widget.architects!.map((ArchitectsModel architect) {
              return DropdownMenuItem<String>(
                value: architect.name,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  child: Text(
                    architect.name,
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
