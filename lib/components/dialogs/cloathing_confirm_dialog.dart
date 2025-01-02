import 'package:bontempo/blocs/clothing_select/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/material_dialog.dart';
import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CloathingConfirmDialog extends StatelessWidget {
  final ClothingSelectBloc bloc;
  final ClothingModel item;
  const CloathingConfirmDialog({
    Key? key,
    required this.item,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              bottom: ScreenUtil().setWidth(40),
              top: ScreenUtil().setWidth(20),
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20),
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
                Container(
                  width: ScreenUtil().setWidth(288),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // To make the card compact
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: ScreenUtil().setWidth(40),
                        width: ScreenUtil().setWidth(40),
                        child: Material(
                          color: Colors.transparent,
                          child: ButtonTheme(
                            minWidth: ScreenUtil().setWidth(40),
                            height: ScreenUtil().setWidth(40),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/svg/close.svg',
                                  color: black[50]!,
                                  height: ScreenUtil().setWidth(18),
                                  width: ScreenUtil().setWidth(18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(10),
                      ),
                      Text(
                        'Deseja utilizar esta peça?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(19),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(10),
                      ),
                      ConstrainedBox(
                        constraints: new BoxConstraints(
                          maxHeight: ScreenUtil().setHeight(450),
                          minWidth: ScreenUtil().setWidth(288),
                        ),
                        child: Image.network(
                          item.picture,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(288),
                          loadingBuilder: (BuildContext ctx, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  black,
                                ),
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: ScreenUtil().setWidth(140),
                            child: CommonButton(
                              bordered: false,
                              theme: CustomTheme.grey,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'CANCELAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(140),
                            child: CommonButton(
                              bordered: false,
                              theme: CustomTheme.green,
                              onTap: () {
                                this.bloc.add(SelectClothingEvent(this.item));
                                Navigator.pop(context);
                              },
                              child: Text(
                                'UTILIZAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
