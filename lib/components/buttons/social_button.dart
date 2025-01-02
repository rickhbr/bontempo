import 'package:bontempo/components/buttons/common_button.dart';
import 'package:flutter/material.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final Function() onTap;
  final String type;
  final bool loading;

  const SocialButton({
    Key? key,
    required this.onTap,
    required this.type,
    loading,
    blockUI,
  })  : this.loading = loading ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().setWidth(50),
      height: ScreenUtil().setWidth(50),
      child: CommonButton(
        theme: CustomTheme.transparent,
        onTap: onTap,
        height: ScreenUtil().setWidth(50),
        padding: EdgeInsets.zero,
        child: this.loading
            ? Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: ScreenUtil().setWidth(22),
                  height: ScreenUtil().setWidth(22),
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              )
            : SvgPicture.asset(
                'assets/svg/social-${this.type}.svg',
                width: ScreenUtil().setWidth(22),
                height: ScreenUtil().setWidth(22),
              ),
      ),
    );
  }
}
