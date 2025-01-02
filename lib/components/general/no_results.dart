import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoResults extends StatelessWidget {
  final String text;

  const NoResults({Key? key, text})
      : this.text = text ?? 'Nenhum resultado encontrado.',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(30),
      ),
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(14),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
