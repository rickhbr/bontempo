import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/models/restaurant_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_launcher/map_launcher.dart';

class RestaurantItem extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantItem({Key? key, required this.restaurant}) : super(key: key);

  void openMap(BuildContext context) async {
    List<AvailableMap> availableMaps = await MapLauncher.installedMaps;
    final coords = Coords(restaurant.latitude, restaurant.longitude);

    if (availableMaps.length > 1) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          map.showMarker(
                            coords: coords,
                            title: restaurant.title,
                            description: '',
                          );
                        },
                        title: Text(map.mapName),
                        leading: Image(
                          image: AssetImage(map.icon),
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      await availableMaps.first.showMarker(
        coords: coords,
        title: restaurant.title,
        description: '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(20),
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(restaurant.title),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(94),
            height: ScreenUtil().setWidth(35),
            child: CommonButton(
              theme: CustomTheme.white,
              onTap: () => this.openMap(context),
              height: ScreenUtil().setWidth(35),
              padding: EdgeInsets.zero,
              child: Text(
                'TRAÇAR ROTA',
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
    );
  }
}
