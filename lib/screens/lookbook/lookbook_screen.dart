import 'package:bontempo/components/buttons/button_group.dart';
import 'package:bontempo/components/buttons/lookbook_button.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LookBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return SafeArea(
      child: CustomScrollView(
        physics: new ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: CommonHeader(
              kToolbarHeight: ScreenUtil().setWidth(72),
              expandedHeight: ScreenUtil().setWidth(120),
              title: 'LookBook',
              description:
                  'Monte, agende e cadastre looks para o seu dia-a-dia.',
              descriptionPadding: 78.0,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    ScreenUtil().setWidth(150) -
                    ScreenUtil().setHeight(84),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30),
                  bottom: ScreenUtil().setHeight(36),
                  top: ScreenUtil().setWidth(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ButtonGroup(
                      buttons: <Widget>[
                        LookBookButton(
                          coloredIcon: false,
                          title: 'MEUS LOOKS',
                          icon: 'assets/svg/lookbook.svg',
                          route: MyLooksViewRoute,
                        ),
                        // LookBookButton(
                        //   coloredIcon: false,
                        //   title: 'ADICIONAR LOOK',
                        //   icon: 'assets/svg/lookbook-add.svg',
                        //   route: LookBookInstructionsViewRoute,
                        // ),
                      ],
                    ),
                    ButtonGroup(
                      buttons: <Widget>[
                        LookBookButton(
                          coloredIcon: false,
                          title: 'AGENDA DE LOOKS',
                          icon: 'assets/svg/calendar.svg',
                          route: LookBookScheduleViewRoute,
                        ),
                      ],
                    ),
                    ButtonGroup(
                      buttons: <Widget>[
                        LookBookButton(
                          coloredIcon: false,
                          title: 'MEU CLOSET',
                          icon: 'assets/svg/closet.svg',
                          route: ClosetViewRoute,
                        ),
                        LookBookButton(
                          coloredIcon: false,
                          title: 'ADICIONAR PEÇA',
                          icon: 'assets/svg/clothes-add.svg',
                          route: ClothesAddViewRoute,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
