import 'package:bontempo/models/clothing_category_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlacementsIcons extends StatelessWidget {
  final List<Placement> placements;
  final bool isMain;
  const PlacementsIcons({
    Key? key,
    required this.placements,
    isMain,
  })  : this.isMain = isMain ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: ScreenUtil().setWidth(5),
      bottom: ScreenUtil().setWidth(5),
      child: Column(
        children: placements
            .map(
              (Placement place) => Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                margin: EdgeInsets.all(ScreenUtil().setWidth(1)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 1.0),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  'assets/svg/placements/${place.toString().replaceFirst('Placement.', '')}.svg',
                  width: ScreenUtil().setWidth(14),
                  height: ScreenUtil().setWidth(14),
                  color: isMain ? black : black[50]!,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
