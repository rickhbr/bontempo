import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthButton extends StatelessWidget {
  final Function() onTap;
  final bool loading;

  const AppleAuthButton({
    Key? key,
    required this.onTap,
    loading,
    blockUI,
  })  : this.loading = loading ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.loading) {
      return Material(
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
      );
    } else {
      return SignInWithAppleButton(
        onPressed: onTap,
        style: SignInWithAppleButtonStyle.black,
      );
    }
  }
}
