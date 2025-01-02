import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeLookLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(.1),
      highlightColor: Colors.grey.withOpacity(.35),
      enabled: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(45),
            ),
            color: Colors.grey,
            width: ScreenUtil().setWidth(120),
            height: ScreenUtil().setWidth(22),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(16),
            ),
            color: Colors.grey,
            width: double.infinity,
            height: ScreenUtil().setHeight(412),
          ),
        ],
      ),
    );
  }
}
