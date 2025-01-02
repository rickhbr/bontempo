import 'package:bontempo/components/buttons/common_button.dart';
import 'package:flutter/material.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  final String? title, description, buttonText, cancelText;
  final Function? callback;
  final Function? cancelCallback;

  CustomDialog({
    required this.title,
    required this.description,
    this.callback,
    this.buttonText,
    this.cancelCallback,
    this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(40),
          horizontal: ScreenUtil().setWidth(40),
        ),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(19),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: ScreenUtil().setWidth(8)),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: ScreenUtil().setSp(14),
              ),
            ),
            SizedBox(height: 18.0),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (cancelText != null)
                  Expanded(
                    child: CommonButton(
                      height: ScreenUtil().setHeight(72.0),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      theme: CustomTheme.grey,
                      onTap: () {
                        Navigator.of(context).pop();
                        if (cancelCallback != null) {
                          cancelCallback!();
                        }
                      },
                      child: Text(
                        cancelText!.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                if (buttonText != null && cancelText != null)
                  SizedBox(width: ScreenUtil().setWidth(7)),
                if (buttonText != null)
                  Expanded(
                    child: CommonButton(
                      height: ScreenUtil().setHeight(72.0),
                      theme: CustomTheme.black,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      onTap: () {
                        Navigator.of(context).pop();
                        if (callback != null) {
                          callback!();
                        }
                      },
                      child: Text(
                        buttonText!.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
