import 'package:bontempo/blocs/recipes/index.dart';
import 'package:bontempo/components/cards/recipe_card.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/select_gastronomy_type.dart';
import 'package:bontempo/components/general/no_results.dart';
import 'package:bontempo/components/general/toggle_checkbox.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/common_card_loader.dart';
import 'package:bontempo/models/gastronomy_type_model.dart';
import 'package:bontempo/models/recipe_model.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipesScreen extends StatefulWidget {
  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  List<RecipeModel> _recipes = [];
  bool _loading = false;
  bool _onlyInStock = false;
  int _idType = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<RecipesBloc>(context).add(
      LoadRecipesEvent(
        stockOnly: this._onlyInStock,
        idType: this._idType,
      ),
    );
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
      BlocProvider.of<RecipesBloc>(context).add(
        LoadRecipesEvent(
          stockOnly: this._onlyInStock,
          idType: this._idType,
        ),
      );
    }
  }

  void changeType(GastronomyTypeModel type) {
    setState(() {
      _idType = type.id;
    });
    BlocProvider.of<RecipesBloc>(context).add(ResetRecipesEvent());
    BlocProvider.of<RecipesBloc>(context).add(
      LoadRecipesEvent(
        stockOnly: this._onlyInStock,
        idType: this._idType,
      ),
    );
  }

  void toggleStock() {
    setState(() {
      _onlyInStock = !this._onlyInStock;
    });
    BlocProvider.of<RecipesBloc>(context).add(ResetRecipesEvent());
    BlocProvider.of<RecipesBloc>(context).add(
      LoadRecipesEvent(
        stockOnly: this._onlyInStock,
        idType: this._idType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<RecipesBloc, RecipesState>(
      listener: (BuildContext ctx, RecipesState state) {
        if (state is ErrorRecipesState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedRecipesState) {
          setState(() {
            _recipes.addAll(state.items!);
            _loading = false;
          });
        }
        if (state is UninitializedRecipesState) {
          setState(() {
            _recipes.clear();
            _loading = false;
          });
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(120),
                title: 'Receitas',
                description:
                    'Faça pratos magníficos com os alimentos que você tem em casa.',
                descriptionPadding: 66.0,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ToggleCheckbox(
                        title: 'Mostrar receitas que possuo ingredientes.',
                        selected: this._onlyInStock,
                        callback: this.toggleStock,
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(15),
                      ),
                      SelectGastronomyType(
                        onSelected: this.changeType,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _recipes.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return RecipeCard(recipe: _recipes[index]);
                        },
                      ),
                      BlocBuilder<RecipesBloc, RecipesState>(
                        builder: (BuildContext ctx, RecipesState state) {
                          if (state is LoadingRecipesState) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: new List.filled(
                                _recipes.length > 0 ? 1 : 2,
                                CommonCardLoader(),
                              ).toList(),
                            );
                          }
                          if (state is LoadedRecipesState &&
                              _recipes.length == 0) {
                            return NoResults(
                              text: _onlyInStock
                                  ? 'Nenhuma receita encontrada com os itens em seu estoque.'
                                  : 'Nenhuma receita encontrada.',
                            );
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
