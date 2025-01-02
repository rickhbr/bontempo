import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RowTitleLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().setWidth(45),
        bottom: ScreenUtil().setWidth(16),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(.1),
        highlightColor: Colors.grey.withOpacity(.35),
        enabled: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey,
              width: ScreenUtil().setWidth(280),
              height: ScreenUtil().setWidth(22),
            ),
            Container(
              color: Colors.grey,
              margin: EdgeInsets.only(
                top: ScreenUtil().setWidth(4),
              ),
              width: ScreenUtil().setWidth(225),
              height: ScreenUtil().setWidth(22),
            ),
          ],
        ),
      ),
    );
  }
}
