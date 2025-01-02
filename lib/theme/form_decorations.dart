import 'package:flutter/material.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

UnderlineInputBorder whiteBorder = UnderlineInputBorder(
  borderSide: BorderSide(width: 1, color: Colors.white),
);

UnderlineInputBorder darkBorder = UnderlineInputBorder(
  borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
);

UnderlineInputBorder errorColor = UnderlineInputBorder(
  borderSide: BorderSide(width: 1, color: Colors.red),
);

TextStyle whiteText({
  FontWeight weight = FontWeight.w300,
}) {
  return TextStyle(
    fontSize: ScreenUtil().setSp(15),
    color: Colors.white,
    fontWeight: weight,
  );
}

TextStyle darkText({
  FontWeight weight = FontWeight.w300,
}) {
  return TextStyle(
    fontSize: ScreenUtil().setSp(15),
    color: black[200],
    fontWeight: weight,
  );
}

TextStyle greyText({FontWeight weight = FontWeight.w500}) {
  return TextStyle(
    fontSize: 13,
    color: Colors.grey,
    fontWeight: weight,
  );
}

InputDecoration inputWhiteDecoration({
  String labelText = 'Título',
  String hintText = 'Digite o título',
}) {
  return InputDecoration(
    border: whiteBorder,
    contentPadding: new EdgeInsets.only(
      top: ScreenUtil().setHeight(10),
      bottom: ScreenUtil().setHeight(18),
      left: 0,
      right: 0,
    ),
    enabledBorder: whiteBorder,
    focusedBorder: whiteBorder,
    errorBorder: errorColor,
    focusedErrorBorder: errorColor,
    filled: true,
    fillColor: Colors.transparent,
    hintText: hintText,
    hintStyle: whiteText(),
    labelText: labelText,
    labelStyle: whiteText(),
    errorStyle: TextStyle(
      color: white,
      fontSize: ScreenUtil().setSp(12),
      fontWeight: FontWeight.w300,
    ),
  );
}

InputDecoration inputDarkDecoration({
  String labelText = 'Título',
  String hintText = 'Digite o título',
}) {
  return InputDecoration(
    border: whiteBorder,
    contentPadding: new EdgeInsets.only(
      top: ScreenUtil().setHeight(10),
      bottom: ScreenUtil().setHeight(18),
      left: ScreenUtil().setWidth(23),
      right: ScreenUtil().setWidth(23),
    ),
    enabledBorder: darkBorder,
    focusedBorder: darkBorder,
    errorBorder: errorColor,
    focusedErrorBorder: errorColor,
    filled: true,
    fillColor: Colors.transparent,
    hintText: hintText,
    hintStyle: darkText(),
    labelText: labelText,
    labelStyle: darkText(),
    errorStyle: TextStyle(
      color: black,
      fontSize: ScreenUtil().setSp(12),
      fontWeight: FontWeight.w300,
    ),
  );
}
