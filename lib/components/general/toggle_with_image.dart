import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bontempo/theme/theme.dart';

class ToggleWithImage extends StatelessWidget {
  final int id;
  final String title;
  final String? thumbnail;
  final bool lock;
  final bool selected;
  final Function(int) callback;

  ToggleWithImage({
    Key? key,
    required this.id,
    required this.title,
    required this.callback,
    this.thumbnail,
    bool? lock,
    bool? selected,
  })  : this.lock = lock ?? false,
        this.selected = selected ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: ScreenUtil().setWidth(172),
      height: ScreenUtil().setWidth(64),
      decoration: BoxDecoration(
        border: Border.all(
          width: selected ? 5 : 1,
          color: selected ? Colors.green : Colors.transparent,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: ButtonTheme(
          minWidth: double.infinity,
          height: ScreenUtil().setWidth(64),
          child: TextButton(
            onPressed: () {
              if (!lock) {
                callback(id);
              }
            },
            child: Stack(
              children: [
                if (thumbnail != null)
                  Image.network(
                    thumbnail!,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(172),
                    height: ScreenUtil().setWidth(64),
                    loadingBuilder: (BuildContext ctx, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.restaurant_menu,
                        size: ScreenUtil().setWidth(24),
                        color: Colors.white,
                      );
                    },
                  )
                else
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: black[50],
                    child: Icon(
                      Icons.restaurant_menu,
                      size: ScreenUtil().setWidth(64),
                      color: Colors.white,
                    ),
                  ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0, 1],
                      colors: [
                        Colors.black.withOpacity(.7),
                        Colors.black.withOpacity(.2),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(15),
                    ),
                    width: double.infinity,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(13),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
