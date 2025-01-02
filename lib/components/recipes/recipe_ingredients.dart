import 'package:bontempo/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeIngredients extends StatelessWidget {
  final List<IngredientModel> ingredients;

  const RecipeIngredients({
    Key? key,
    required this.ingredients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(20),
            top: ScreenUtil().setHeight(40),
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(20),
              ),
              children: [
                TextSpan(text: 'Lista de '),
                TextSpan(
                  text: 'Ingredientes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        ...ingredients
            .map(
              (IngredientModel ingredient) => Container(
                padding: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right: ScreenUtil().setWidth(5),
                        top: ScreenUtil().setHeight(5),
                      ),
                      child:
                          Icon(Icons.brightness_1, size: ScreenUtil().setSp(6)),
                    ),
                    Expanded(
                      child: Text(
                        ingredient.title,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList()
      ],
    );
  }
}
