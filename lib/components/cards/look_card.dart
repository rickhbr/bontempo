import 'package:bontempo/models/look_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LookCard extends StatelessWidget {
  final LookModel look;
  final double paddingBottom;
  final Widget? buttons;

  const LookCard({
    Key? key,
    required this.look,
    this.paddingBottom = 0,
    this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total = look.clothing!.length;
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.only(bottom: ScreenUtil().setWidth(this.paddingBottom)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.09),
            blurRadius: 24.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(16),
              right: ScreenUtil().setWidth(16),
              top: ScreenUtil().setWidth(16),
              bottom: ScreenUtil().setWidth(8),
            ),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: ScreenUtil().setWidth(8),
              crossAxisSpacing: ScreenUtil().setWidth(8),
              children: List.generate(
                total,
                (int index) {
                  return StaggeredGridTile.count(
                    crossAxisCellCount:
                        total.isOdd && index == look.clothing!.length - 1
                            ? 2
                            : 1,
                    mainAxisCellCount: 1.32,
                    child: Container(
                      child: Center(
                        child: Stack(
                          children: <Widget>[
                            Image.network(
                              look.clothing![index].picture,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              loadingBuilder: (BuildContext ctx, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: SizedBox(
                                    height: ScreenUtil().setWidth(14),
                                    width: ScreenUtil().setWidth(14),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        black,
                                      ),
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (buttons != null)
            Positioned(
              right: ScreenUtil().setWidth(12),
              top: ScreenUtil().setWidth(12),
              child: buttons!,
            ),
        ],
      ),
    );
  }
}
