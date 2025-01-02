import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClothingCard extends StatelessWidget {
  final ClothingModel clothing;
  final Widget? leftButtons;
  final Widget? rightButtons;

  const ClothingCard({
    Key? key,
    required this.clothing,
    this.leftButtons,
    this.rightButtons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        ScreenUtil().setWidth(8),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.09),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
            child: Center(
              child: Hero(
                tag: 'image${clothing.id.toString()}',
                child: Image.network(
                  clothing.picture,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  height: ScreenUtil().setWidth(194),
                  width: ScreenUtil().setWidth(194),
                  loadingBuilder: (BuildContext ctx, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: SizedBox(
                        height: ScreenUtil().setWidth(28),
                        width: ScreenUtil().setWidth(28),
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                            black,
                          ),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if (leftButtons != null)
            Positioned(
              left: ScreenUtil().setWidth(0),
              top: ScreenUtil().setWidth(0),
              child: leftButtons!,
            ),
          if (rightButtons != null)
            Positioned(
              right: ScreenUtil().setWidth(0),
              top: ScreenUtil().setWidth(0),
              child: rightButtons!,
            ),
        ],
      ),
    );
  }
}
