import 'package:bontempo/components/buttons/common_button.dart';
import 'package:flutter/material.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LookBookButton extends StatelessWidget {
  final String icon;
  final String title;
  final String? route;
  final Function? onTap;
  final Function? onResult;
  final bool coloredIcon;

  const LookBookButton({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
    this.onResult,
    this.route,
    this.coloredIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(4),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(25),
      ),
      theme: CustomTheme.black,
      onTap: () async {
        if (this.route != null) {
          var result = await Navigator.pushNamed(context, this.route ?? '/');
          if (this.onResult != null) {
            this.onResult!(result);
          }
        } else if (this.onTap != null) {
          onTap!();
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SvgPicture.asset(
            this.icon,
            color: coloredIcon ? Colors.white : Colors.transparent,
            height: ScreenUtil().setWidth(18),
            width: ScreenUtil().setWidth(21),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(14),
          ),
          Text(
            this.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(12),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
