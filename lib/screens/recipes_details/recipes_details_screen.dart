import 'package:bontempo/blocs/recipes/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/images/square_image.dart';
import 'package:bontempo/components/recipes/recipe_ingredients.dart';
import 'package:bontempo/components/recipes/recipe_text.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/recipe_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecipesDetailsScreen extends StatefulWidget {
  final RecipeModel recipe;

  const RecipesDetailsScreen({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  _RecipesDetailsScreenState createState() => _RecipesDetailsScreenState();
}

class _RecipesDetailsScreenState extends State<RecipesDetailsScreen> {
  RecipeModel? _recipe;
  YoutubePlayerController? _youtubeController;

  bool _loading = true;
  bool _loadingMarkAsDone = false;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RecipesBloc>(context).add(
      LoadRecipeDetailsEvent(
        id: widget.recipe.id,
      ),
    );
  }

  void shareRecipe() {
    String content = this._recipe!.title.toUpperCase() + '\n\n';

    if (this._recipe!.preparation.isNotEmpty) {
      content += 'MODO DE PREPARO\n' +
          this._recipe!.preparation.replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), '') +
          '\n\n';
    }

    if (this._recipe!.information.isNotEmpty) {
      content += 'OUTRAS INFORMAÇÕES\n' +
          this._recipe!.information.replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), '') +
          '\n\n';
    }

    if (this._recipe!.ingredients.length > 0) {
      content += 'INGREDIENTES\n';
      this._recipe!.ingredients.forEach((IngredientModel ingredient) {
        content += ingredient.title.replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), '') + '\n';
      });
      content += '\n';
    }

    Share.share(
      content,
      subject: this._recipe!.title,
    );
  }

  void markAsDone() {
    if (!this._loadingMarkAsDone && !this._isDone)
      BlocProvider.of<RecipesBloc>(context).add(
        RecipeDoneEvent(
          id: widget.recipe.id,
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
          Navigator.of(context).pop();
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedRecipeDetailsState) {
          setState(() {
            _recipe = state.recipe;
            _loading = false;
            if (_recipe!.video.isNotEmpty) {
              _youtubeController = YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(_recipe!.video)!,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              );
            }
          });
        }
        if (state is LoadingRecipeDoneState) {
          setState(() {
            _loadingMarkAsDone = true;
          });
        }
        if (state is LoadedRecipeDoneState) {
          setState(() {
            _loadingMarkAsDone = false;
            _isDone = true;
          });

          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Feito!',
              description:
                  'Agora, indicamos que você atualize seu estoque no app após utilizar seus ingredientes na receita.',
              buttonText: "Atualizar",
              cancelText: 'Fechar',
              callback: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(
                  context,
                  StockViewRoute,
                );
              },
              cancelCallback: () {
                Navigator.of(context).pop();
              },
            ),
          );
        }
        if (state is ErrorRecipeDoneState) {
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
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height - ScreenUtil().setWidth(70) - ScreenUtil().setHeight(98),
                ),
                child: !_loading && this._recipe != null
                    ? Column(
                        children: <Widget>[
                          SquareImage(
                            width: 180.0,
                            height: MediaQuery.of(context).size.width,
                            imageUrl: this._recipe!.thumbnail,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(30),
                              right: ScreenUtil().setWidth(30),
                              bottom: ScreenUtil().setHeight(36),
                              top: ScreenUtil().setHeight(18),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  this._recipe!.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -.5,
                                    fontSize: ScreenUtil().setSp(27),
                                  ),
                                ),
                                this._recipe!.preparation.isNotEmpty
                                    ? RecipeText(
                                        title: 'Modo de ',
                                        boldTitle: 'Preparo',
                                        text: this._recipe!.preparation,
                                      )
                                    : Container(),
                                this._recipe!.information.isNotEmpty
                                    ? RecipeText(
                                        title: 'Outras ',
                                        boldTitle: 'Informações',
                                        text: this._recipe!.information,
                                      )
                                    : Container(),
                                this._recipe!.ingredients.isNotEmpty && this._recipe!.ingredients.length > 0
                                    ? RecipeIngredients(
                                        ingredients: this._recipe!.ingredients,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          if (this._recipe!.video.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: YoutubePlayer(
                                        controller: _youtubeController!,
                                        showVideoProgressIndicator: true,
                                        progressIndicatorColor: Colors.amber,
                                        onReady: () {
                                          _youtubeController!.play();
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Stack(
                                children: <Widget>[
                                  SquareImage(
                                    width: 210.0,
                                    height: MediaQuery.of(context).size.width,
                                    imageUrl: this._recipe!.thumbnail,
                                  ),
                                  Positioned.fill(
                                    child: Icon(
                                      Icons.play_circle_outline,
                                      color: Colors.white,
                                      size: 65.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(30),
                              vertical: ScreenUtil().setHeight(20),
                            ),
                            child: Column(
                              children: <Widget>[
                                CommonButton(
                                  margin: EdgeInsets.only(
                                    bottom: ScreenUtil().setHeight(10),
                                  ),
                                  theme: CustomTheme.black,
                                  onTap: this.shareRecipe,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        'assets/svg/share.svg',
                                        color: Colors.white,
                                        height: ScreenUtil().setWidth(22),
                                        width: ScreenUtil().setWidth(22),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(12),
                                      ),
                                      Text(
                                        'COMPARTILHAR RECEITA',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(15),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CommonButton(
                                  theme: this._isDone ? CustomTheme.green : CustomTheme.white,
                                  onTap: () => this.markAsDone(),
                                  child: !this._loadingMarkAsDone
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_circle_outline,
                                              color: this._isDone ? Colors.white : Colors.black,
                                              size: 25.0,
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(12),
                                            ),
                                            Text(
                                              this._isDone ? 'SALVO!' : 'FIZ A RECEITA',
                                              style: TextStyle(
                                                color: this._isDone ? Colors.white : Colors.black,
                                                fontSize: ScreenUtil().setSp(15),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(
                                          height: ScreenUtil().setWidth(20),
                                          width: ScreenUtil().setWidth(20),
                                          child: CircularProgressIndicator(
                                            valueColor: new AlwaysStoppedAnimation<Color>(
                                              Color(0xFF000000),
                                            ),
                                            strokeWidth: 3,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: ScreenUtil().setWidth(30),
                            width: ScreenUtil().setWidth(30),
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                Color(0xFF000000),
                              ),
                              strokeWidth: 3,
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
