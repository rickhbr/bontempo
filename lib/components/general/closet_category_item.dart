import 'package:bontempo/models/closet_item_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClosetCategoryItem extends StatelessWidget {
  final ClosetItemModel? item;
  final bool? themeLight;
  const ClosetCategoryItem({
    Key? key,
    this.item,
    this.themeLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(10),
        top: ScreenUtil().setWidth(20),
        bottom: ScreenUtil().setWidth(20),
      ),
      decoration: BoxDecoration(
        color: themeLight! ? Colors.white : Colors.grey[100],
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey[300]!,
          ),
          left: BorderSide(
            width: 1,
            color: Colors.grey[themeLight! ? 300 : 100]!,
          ),
          right: BorderSide(
            width: 1,
            color: Colors.grey[themeLight! ? 300 : 100]!,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    item!.title,
                    style: TextStyle(
                      color: black[200],
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(56),
            child: Center(
              child: Text(
                item!.total.toString(),
                style: TextStyle(
                  color: black[200],
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
