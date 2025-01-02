import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowTitle extends StatelessWidget {
  final String? lightTitle;
  final String? boldTitle;
  final CustomTheme theme;
  final double fontSize;
  final TextAlign textAlign;

  const RowTitle({
    Key? key,
    this.lightTitle,
    this.boldTitle,
    fontSize,
    textAlign,
    theme,
  })  : this.theme = theme ?? CustomTheme.black,
        this.fontSize = fontSize ?? 20,
        this.textAlign = textAlign ?? TextAlign.center,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: ScreenUtil().setWidth(45),
        bottom: ScreenUtil().setWidth(16),
      ),
      child: RichText(
        textAlign: this.textAlign,
        text: new TextSpan(
          style: TextStyle(
            color: theme == CustomTheme.white ? white : black,
            fontSize: ScreenUtil().setSp(this.fontSize),
            fontWeight: FontWeight.w300,
          ),
          children: <TextSpan>[
            if (this.lightTitle != null)
              TextSpan(
                text: this.lightTitle!.trim(),
              ),
            if (this.boldTitle != null)
              TextSpan(
                text:
                    '${this.lightTitle != null ? ' ' : ''}${this.boldTitle!.trim()}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
