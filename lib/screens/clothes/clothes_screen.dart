import 'package:bontempo/blocs/clothing/index.dart';
import 'package:bontempo/components/buttons/look_action_button.dart';
import 'package:bontempo/components/cards/clothing_card.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/no_results.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/sized_box_loader.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/clothing_model.dart';
import 'package:bontempo/screens/clothes_edit/clothes_edit_arguments.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClothesScreen extends StatefulWidget {
  @override
  _ClothesScreenState createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  List<ClothingModel> _clothes = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<ClothingBloc>(context).add(LoadClothingEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold && !_loading) {
      setState(() {
        _loading = true;
      });
      BlocProvider.of<ClothingBloc>(context).add(LoadClothingEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<ClothingBloc, ClothingState>(
      listener: (BuildContext ctx, ClothingState state) {
        if (state is ErrorClothingState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedClothingState) {
          setState(() {
            _clothes.addAll(state.items!);
            _loading = false;
          });
        }
        if (state is RemovedClothingState) {
          setState(() {
            _clothes.removeWhere(
                (ClothingModel item) => item.id == state.idClothing);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Peça excluída com sucesso!"),
              action: SnackBarAction(
                label: 'FECHAR',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
        if (state is EditedClothingState) {
          int index = _clothes
              .indexWhere((ClothingModel item) => item.id == state.clothing.id);
          setState(() {
            _clothes[index] = state.clothing;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Peça editada com sucesso!"),
              action: SnackBarAction(
                label: 'FECHAR',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                backButton: true,
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(120),
                title: 'Minhas peças',
                description: 'Gerencie as suas peças cadastradas.',
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
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(20),
                    bottom: ScreenUtil().setHeight(36),
                    top: ScreenUtil().setWidth(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (_clothes.isNotEmpty)
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.all(
                            ScreenUtil().setWidth(10),
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: _clothes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ClothingCard(
                              clothing: _clothes[index],
                              leftButtons: LookActionButton(
                                icon: Icons.edit,
                                callback: () {
                                  Navigator.pushNamed(
                                    context,
                                    ClothesEditViewRoute,
                                    arguments: ClothesEditArguments(
                                      clothing: this._clothes[index],
                                      clothingBloc:
                                          BlocProvider.of<ClothingBloc>(
                                              context),
                                    ),
                                  );
                                },
                              ),
                              rightButtons: LookActionButton(
                                icon: Icons.close,
                                hasDialog: true,
                                dialogTitle: 'Remover peça?',
                                dialogText:
                                    'Você tem certeza que deseja remover esta peça?',
                                dialogButton: "Remover",
                                callback: () {
                                  BlocProvider.of<ClothingBloc>(context).add(
                                    RemoveClothingEvent(
                                      this._clothes[index].id,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      BlocBuilder<ClothingBloc, ClothingState>(
                        builder: (BuildContext ctx, ClothingState state) {
                          if (state is LoadingClothingState) {
                            return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                top: ScreenUtil()
                                    .setWidth(_clothes.isNotEmpty ? 0 : 10),
                                bottom: ScreenUtil().setWidth(10),
                                left: ScreenUtil().setWidth(10),
                                right: ScreenUtil().setWidth(10),
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: _clothes.isNotEmpty ? 2 : 4,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.all(
                                    ScreenUtil().setWidth(8),
                                  ),
                                  child: SizedBoxLoader(
                                    width: ScreenUtil().setWidth(200),
                                    height: ScreenUtil().setWidth(200),
                                  ),
                                );
                              },
                            );
                          }
                          if (state is LoadedClothingState &&
                              _clothes.length == 0) {
                            return NoResults(text: "Nenhuma peça cadastrada.");
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
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
