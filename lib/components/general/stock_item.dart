import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/general/counter.dart';
import 'package:bontempo/models/stock_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StockItem extends StatelessWidget {
  final StockModel? item;
  final bool? themeLight;
  final bool isStockItem;
  final Function? onChange;
  final Function? onDelete;
  final Function? onButtonPress;
  const StockItem({
    Key? key,
    this.item,
    this.themeLight,
    this.onChange,
    this.onDelete,
    this.onButtonPress,
    isStockItem,
  })  : this.isStockItem = isStockItem ?? true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(20),
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
            child: Text(
              item!.title,
              style: TextStyle(
                color: black[200],
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Counter(
                quantity: item!.quantity,
                callback: (int quantity) {
                  this.onChange!(item!.copyWith(quantity: quantity));
                },
              ),
              SizedBox(
                width: ScreenUtil().setWidth(44),
                height: ScreenUtil().setWidth(50),
                child: CommonButton(
                  bordered: false,
                  padding: isStockItem
                      ? EdgeInsets.only(
                          bottom: ScreenUtil().setWidth(8),
                        )
                      : EdgeInsets.zero,
                  theme: CustomTheme.transparent,
                  onTap: () {
                    this.onButtonPress!(item);
                  },
                  child: Center(
                    child: isStockItem
                        ? SvgPicture.asset(
                            'assets/svg/cart.svg',
                            width: ScreenUtil().setWidth(28),
                          )
                        : Opacity(
                            opacity: .6,
                            child: SvgPicture.asset(
                              'assets/svg/complete.svg',
                              color: black[200]!,
                              width: ScreenUtil().setWidth(24),
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(44),
                height: ScreenUtil().setWidth(50),
                child: CommonButton(
                  bordered: false,
                  padding: isStockItem
                      ? EdgeInsets.only(
                          bottom: ScreenUtil().setWidth(8),
                        )
                      : EdgeInsets.zero,
                  theme: CustomTheme.transparent,
                  onTap: () {
                    this.onDelete!(item);
                  },
                  child: Center(
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.black.withOpacity(.4),
                      size: ScreenUtil().setWidth(28),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
