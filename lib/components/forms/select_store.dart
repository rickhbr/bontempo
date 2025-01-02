import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectStore extends StatefulWidget {
  final Function onSelected;

  const SelectStore({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  _SelectStoreState createState() => _SelectStoreState();
}

class _SelectStoreState extends State<SelectStore> {
  bool _loaded = true;
  String? _selected = "Loja";

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
        value: _selected == "Loja" ? null : _selected,
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
          DropdownMenuItem(value: '@Loja1', child: Text('@Loja1')),
          DropdownMenuItem(value: '@Loja2', child: Text('@Loja2')),
          DropdownMenuItem(value: '@Loja3', child: Text('@Loja3')),
          DropdownMenuItem(value: '@Loja4', child: Text('@Loja4')),
          DropdownMenuItem(value: '@Loja5', child: Text('@Loja5')),
        ],
        onChanged: _loaded
            ? (String? newValue) {
                setState(() {
                  _selected = newValue;
                });
                widget.onSelected(newValue);
              }
            : null,
        hint: Text(
          _selected ?? "Loja",
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
