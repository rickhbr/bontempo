import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColumnTitle extends StatelessWidget {
  final String? lightTitle;
  final String? boldTitle;
  final CustomTheme theme;

  const ColumnTitle({
    Key? key,
    this.lightTitle,
    this.boldTitle,
    theme,
  })  : this.theme = theme ?? CustomTheme.black,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().setWidth(45),
        bottom: ScreenUtil().setWidth(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (this.lightTitle != null)
            Text(
              lightTitle ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: theme == CustomTheme.white ? white : black,
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.w300),
            ),
          if (this.boldTitle != null)
            Text(
              this.boldTitle ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: theme == CustomTheme.white ? white : black,
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.w700),
            ),
        ],
      ),
    );
  }
}
