import 'package:bontempo/blocs/closet/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/closet_category_item.dart';
import 'package:bontempo/components/general/closet_climate_item.dart';
import 'package:bontempo/components/general/no_results.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/sized_box_loader.dart';
import 'package:bontempo/components/typography/row_title.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/closet_item_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ClosetScreen extends StatefulWidget {
  @override
  _ClosetScreenState createState() => _ClosetScreenState();
}

class _ClosetScreenState extends State<ClosetScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClosetBloc>(context).add(LoadClosetEvent());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<ClosetBloc, ClosetState>(
      listener: (BuildContext ctx, ClosetState state) {
        if (state is ErrorClosetState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(120),
                descriptionPadding: ScreenUtil().setWidth(80),
                backButton: true,
                title: 'Meu Closet',
                description: 'Veja tudo o que se encontra no seu closet.',
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
                    top: ScreenUtil().setWidth(30),
                  ),
                  child: BlocBuilder<ClosetBloc, ClosetState>(
                    builder: (BuildContext ctx, ClosetState state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if (state is LoadedClosetState &&
                              state.closet.categories.isNotEmpty)
                            Container(
                              padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(20),
                                right: ScreenUtil().setWidth(16),
                                bottom: ScreenUtil().setWidth(8),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Categoria',
                                    style: TextStyle(
                                      color: black[200],
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Qntd.',
                                    style: TextStyle(
                                      color: black[200],
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (state is LoadedClosetState &&
                              state.closet.categories.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.closet.categories.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return ClosetCategoryItem(
                                  item: state.closet.categories[index],
                                  themeLight: index % 2 == 0,
                                );
                              },
                            ),
                          if (state is LoadedClosetState &&
                              state.closet.categories.isNotEmpty)
                            RowTitle(
                              lightTitle: 'Minhas',
                              boldTitle: 'Cores',
                              fontSize: 22.0,
                              textAlign: TextAlign.left,
                            ),
                          if (state is LoadedClosetState &&
                              state.closet.categories.isNotEmpty)
                            SizedBox(
                              width: double.infinity,
                              height: ScreenUtil().setWidth(80),
                              child: Row(
                                children: <Widget>[
                                  ...state.closet.colors.map(
                                    (ClosetItemModel item) => Expanded(
                                      flex: item.percent,
                                      child: Container(
                                        color: item.color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (state is LoadedClosetState &&
                              state.closet.categories.isNotEmpty)
                            RowTitle(
                              lightTitle: 'Looks',
                              boldTitle: 'por Estação',
                              fontSize: 22.0,
                              textAlign: TextAlign.left,
                            ),
                          if (state is LoadedClosetState &&
                              state.closet.categories.isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 1,
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.closet.climates.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return ClosetClimateItem(
                                    item: state.closet.climates[index],
                                    themeLight: index % 2 == 0,
                                  );
                                },
                              ),
                            ),
                          if (state is LoadedClosetState &&
                              state.closet.categories.isEmpty)
                            NoResults(
                              text:
                                  "Você ainda não cadastrou nenhuma peça em seu closet.",
                            ),
                          if (state is LoadedClosetState)
                            CommonButton(
                              margin: EdgeInsets.only(
                                top: ScreenUtil().setWidth(20),
                              ),
                              bordered: false,
                              theme: CustomTheme.green,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ClothesAddViewRoute,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/svg/circle-plus.svg',
                                    color: Colors.white,
                                    height: ScreenUtil().setWidth(22),
                                    width: ScreenUtil().setWidth(22),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(12),
                                  ),
                                  Text(
                                    'ADICIONAR PEÇA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (state is LoadedClosetState &&
                              state.closet.categories.isNotEmpty)
                            CommonButton(
                              margin: EdgeInsets.only(
                                top: ScreenUtil().setWidth(20),
                              ),
                              bordered: false,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ClothesViewRoute,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: ScreenUtil().setSp(22),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(12),
                                  ),
                                  Text(
                                    'EDITAR MINHAS PEÇAS',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (state is! LoadedClosetState)
                            ...new List.filled(8, 1)
                                .map(
                                  (int i) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: ScreenUtil().setWidth(2),
                                    ),
                                    child: SizedBoxLoader(
                                      width: double.infinity,
                                      height: ScreenUtil().setWidth(50),
                                    ),
                                  ),
                                )
                                .toList(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
