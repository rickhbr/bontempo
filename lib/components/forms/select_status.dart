import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectStatus extends StatefulWidget {
  final Function onSelected;

  const SelectStatus({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  _SelectStatusState createState() => _SelectStatusState();
}

class _SelectStatusState extends State<SelectStatus> {
  bool _loaded = true;
  String _selected = "Selecione o status";

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
      child: DropdownButtonFormField<String>(
        value: _selected == "Selecione o status" ? null : _selected,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setHeight(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: black[50]!),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        items: [
          DropdownMenuItem(value: "Novo", child: Text("Novo")),
          DropdownMenuItem(value: "Em andamento", child: Text("Em andamento")),
          DropdownMenuItem(value: "Completo", child: Text("Completo")),
        ],
        onChanged: _loaded
            ? (String? newValue) {
                setState(() {
                  _selected = newValue!;
                });
                widget.onSelected(newValue);
              }
            : null,
        hint: Text(
          _selected,
          style: TextStyle(
            color: black[200],
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.w400,
          ),
        ),
        icon: _loaded
            ? Icon(
                Icons.keyboard_arrow_down,
                color: black[200],
                size: ScreenUtil().setSp(18),
              )
            : loader(),
        isExpanded: true,
      ),
    );
  }
}
