import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeText extends StatelessWidget {
  final String title;
  final String boldTitle;
  final String text;

  const RecipeText({
    Key? key,
    required this.title,
    required this.boldTitle,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(10),
            top: ScreenUtil().setHeight(30),
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(20),
              ),
              children: [
                TextSpan(text: title),
                TextSpan(
                  text: boldTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Html(
          style: {
            "html": Style.fromTextStyle(
              TextStyle(
                fontSize: ScreenUtil().setSp(15),
              ),
            ),
          },
          data: text,
        )
      ],
    );
  }
}
