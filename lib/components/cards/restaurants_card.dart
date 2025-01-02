import 'package:bontempo/components/cards/restaurant_item.dart';
import 'package:bontempo/models/restaurants_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantsCard extends StatelessWidget {
  final RestaurantsCardModel restaurantsCard;

  const RestaurantsCard({Key? key, required this.restaurantsCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
      width: ScreenUtil().setWidth(354),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: ScreenUtil()
                .setHeight(restaurantsCard.photo != null ? 120 : 60),
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  restaurantsCard.photo != null ? Colors.black : Colors.white,
              image: restaurantsCard.photo != null
                  ? DecorationImage(
                      colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.dstATop,
                      ),
                      fit: BoxFit.cover,
                      image: NetworkImage(restaurantsCard.photo),
                    )
                  : null,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                child: Text(
                  restaurantsCard.title,
                  textAlign: restaurantsCard.photo != null
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(
                    color: restaurantsCard.photo != null
                        ? Colors.white
                        : Colors.black,
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: restaurantsCard.restaurants.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return RestaurantItem(
                restaurant: restaurantsCard.restaurants[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
