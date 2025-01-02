import 'package:bontempo/blocs/clothing/clothing_bloc.dart';
import 'package:bontempo/blocs/clothing_categories/index.dart';
import 'package:bontempo/blocs/clothing_colors/index.dart';
import 'package:bontempo/blocs/clothing_select/clothing_select_bloc.dart';
import 'package:bontempo/blocs/look_manage/look_manage_bloc.dart';
import 'package:bontempo/components/layout/layout_pushed.dart';
import 'package:bontempo/models/look_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:bontempo/screens/lookbook_manage/lookbook_manage_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LookBookManagePage extends StatelessWidget {
  final LookModel look;
  final String routeName;

  LookBookManagePage({
    Key? key,
    LookModel? look,
  })  : this.look = look ?? LookModel(0, '', []),
        this.routeName = look != null ? "/lookbook-edit/" : "/lookbook-add",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': '$routeName${(this.look != null ? this.look.id : '')}',
        'screen_class': 'UpdateProfilePage',
      },
    );

    return LayoutPushed(
      child: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ClothingBloc>(
              create: (BuildContext context) => ClothingBloc(),
            ),
            BlocProvider<ClothingSelectBloc>(
              create: (BuildContext context) => ClothingSelectBloc(),
            ),
            BlocProvider<ClothingCategoriesBloc>(
              create: (BuildContext context) => ClothingCategoriesBloc(),
            ),
            BlocProvider<ClothingColorsBloc>(
              create: (BuildContext context) => ClothingColorsBloc(),
            ),
            BlocProvider<LookManageBloc>(
              create: (BuildContext context) => LookManageBloc(),
            ),
          ],
          child: LookBookManageScreen(look: this.look),
        ),
      ),
    );
  }
}
