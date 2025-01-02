import 'package:auto_size_text/auto_size_text.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/images/square_image.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonCard extends StatelessWidget {
  final String? image;
  final String? imageAsset;
  final dynamic imageMemory;
  final bool hideBrokenImage;
  final String? title;
  final String? preTitle;
  final String? afterTitle;
  final String? buttonTitle;
  final String? secondButtonTitle;
  final CustomTheme? secondButtonTheme;
  final Function()? onTap;
  final Function()? onTapSecond;
  final IconData? icon;

  const CommonCard({
    Key? key,
    this.image,
    this.imageAsset,
    this.imageMemory,
    this.title,
    this.preTitle,
    this.afterTitle,
    this.buttonTitle,
    this.secondButtonTitle,
    this.secondButtonTheme,
    this.onTap,
    this.onTapSecond,
    this.icon,
    this.hideBrokenImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myGroup = AutoSizeGroup();
    bool hasImage = ((image != null && image!.isNotEmpty) ||
        (imageAsset != null && imageAsset!.isNotEmpty) ||
        (imageMemory != null && imageMemory.toString().isNotEmpty));

    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
      width: ScreenUtil().setWidth(354),
      height: ScreenUtil().setWidth(160),
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
          height: ScreenUtil().setWidth(130.0),
          child: TextButton(
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if ((hideBrokenImage && hasImage) || !hideBrokenImage)
                  SquareImage(
                    width: 148.0,
                    height: 130.0,
                    imageUrl: image ?? '',
                    imageAsset: imageAsset ?? '',
                    imageMemory: imageMemory,
                    noImage: icon,
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(24),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: ScreenUtil().setWidth(82),
                          maxHeight: ScreenUtil().setWidth(135),
                          minWidth: double.infinity,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (preTitle != null)
                                  AutoSizeText(
                                    preTitle!,
                                    maxLines: 1,
                                    group: myGroup,
                                    minFontSize: 11,
                                    style: TextStyle(
                                      color: black,
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w300,
                                      height: .9,
                                    ),
                                  ),
                                if (title != null)
                                  AutoSizeText(
                                    title!,
                                    maxLines: preTitle != null ? 5 : 6,
                                    group: myGroup,
                                    minFontSize: 11,
                                    style: TextStyle(
                                      color: black,
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w700,
                                      height: .9,
                                    ),
                                  ),
                                if (afterTitle != null)
                                  AutoSizeText(
                                    afterTitle!,
                                    maxLines: 1,
                                    group: myGroup,
                                    minFontSize: 11,
                                    style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w300,
                                      height: .9,
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (buttonTitle != null)
                                    SizedBox(
                                      width: ScreenUtil().setWidth(94),
                                      height: ScreenUtil().setWidth(35),
                                      child: CommonButton(
                                        theme: CustomTheme.white,
                                        onTap: onTap,
                                        height: ScreenUtil().setWidth(35),
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setWidth(8)),
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                          buttonTitle!,
                                          style: TextStyle(
                                            color: black[200],
                                            fontSize: ScreenUtil().setSp(9),
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -.3,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (secondButtonTitle != null)
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: ScreenUtil().setWidth(35),
                                        child: CommonButton(
                                          theme: secondButtonTheme ??
                                              CustomTheme.green,
                                          onTap: onTapSecond,
                                          height: ScreenUtil().setWidth(35),
                                          margin: EdgeInsets.only(
                                              top: ScreenUtil().setWidth(8),
                                              left: ScreenUtil().setWidth(8)),
                                          padding: EdgeInsets.zero,
                                          child: Text(
                                            secondButtonTitle!,
                                            style: TextStyle(
                                              color: white[200],
                                              fontSize: ScreenUtil().setSp(9),
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -.3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ])
                          ],
                        ),
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
