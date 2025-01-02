import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LookActionButton extends StatelessWidget {
  final IconData icon;
  final Function callback;
  final bool hasDialog;
  final String? dialogTitle;
  final String? dialogText;
  final String? dialogButton;

  const LookActionButton({
    Key? key,
    required this.icon,
    required this.callback,
    hasDialog,
    this.dialogTitle,
    this.dialogText,
    this.dialogButton,
  })  : this.hasDialog = hasDialog ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().setWidth(34),
      height: ScreenUtil().setWidth(34),
      child: Material(
        color: Colors.transparent,
        child: ButtonTheme(
          minWidth: ScreenUtil().setWidth(34),
          height: ScreenUtil().setWidth(34),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(34),
              ),
            ),
            onPressed: () {
              if (this.hasDialog) {
                showScaleDialog(
                  context: context,
                  child: CustomDialog(
                    title: dialogTitle ?? '',
                    description: dialogText ?? '',
                    buttonText: dialogButton ?? '',
                    cancelText: "Cancelar",
                    callback: () {
                      this.callback();
                    },
                  ),
                );
              } else {
                this.callback();
              }
            },
            child: Center(
              child: Container(
                height: ScreenUtil().setWidth(22),
                width: ScreenUtil().setWidth(22),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: black[100]!.withOpacity(.05),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 1.0),
                    ),
                  ],
                ),
                child: Icon(
                  this.icon,
                  color: black[100]!.withOpacity(.8),
                  size: ScreenUtil().setSp(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
