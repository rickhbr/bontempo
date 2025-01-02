import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CommonCardLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
      width: ScreenUtil().setWidth(354.0),
      height: ScreenUtil().setWidth(130.0),
      color: Colors.white.withOpacity(.3),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(.1),
        highlightColor: Colors.grey.withOpacity(.35),
        enabled: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.grey,
              width: ScreenUtil().setWidth(148),
              height: ScreenUtil().setWidth(130),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setWidth(20),
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
                        Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: ScreenUtil().setWidth(20),
                        ),
                        Container(
                          color: Colors.grey,
                          margin: EdgeInsets.only(
                            top: ScreenUtil().setWidth(4),
                          ),
                          width: ScreenUtil().setWidth(100),
                          height: ScreenUtil().setWidth(20),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey,
                      width: ScreenUtil().setWidth(94),
                      height: ScreenUtil().setWidth(35),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
