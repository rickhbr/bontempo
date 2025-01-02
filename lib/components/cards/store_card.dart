import 'package:auto_size_text/auto_size_text.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/models/store_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreCard extends StatelessWidget {
  final Function()? onTap;
  final StoreModel? model;

  const StoreCard({
    Key? key,
    this.onTap,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(32),
        right: ScreenUtil().setHeight(24),
        left: ScreenUtil().setHeight(24),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.19),
            blurRadius: 24.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ButtonTheme(
          minWidth: double.infinity,
          // height: ScreenUtil().setWidth(130.0),
          child: TextButton(
            onPressed: this.onTap,
            child: Column(
              children: [
                if (model!.image != null && model!.image != '')
                  Image.network(
                    model!.image!,
                    width: ScreenUtil().setWidth(324),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(24),
                    vertical: ScreenUtil().setWidth(24),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: new BoxConstraints(
                        // minHeight: ScreenUtil().setWidth(82),
                        // maxHeight: ScreenUtil().setWidth(130),
                        minWidth: double.infinity,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            model!.name,
                            maxLines: 1,
                            group: AutoSizeGroup(),
                            textAlign: TextAlign.start,
                            minFontSize: 11,
                            style: TextStyle(
                              color: black,
                              fontSize: ScreenUtil().setSp(15),
                              fontWeight: FontWeight.w700,
                              height: .9,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setWidth(8),
                          ),
                          AutoSizeText(
                            model!.address,
                            maxLines: 3,
                            group: AutoSizeGroup(),
                            textAlign: TextAlign.start,
                            minFontSize: 11,
                            style: TextStyle(
                              color: black,
                              fontSize: ScreenUtil().setSp(15),
                              fontWeight: FontWeight.w300,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setWidth(8),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(124),
                            height: ScreenUtil().setWidth(44),
                            child: CommonButton(
                              theme: CustomTheme.white,
                              onTap: this.onTap,
                              height: ScreenUtil().setWidth(35),
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setWidth(8)),
                              padding: EdgeInsets.zero,
                              child: Text(
                                "SELECIONAR LOJA",
                                style: TextStyle(
                                  color: black[200],
                                  fontSize: ScreenUtil().setSp(9),
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -.3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
