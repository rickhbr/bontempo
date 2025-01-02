import 'package:bontempo/blocs/cart/index.dart';
import 'package:bontempo/blocs/stocks/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/add_item.dart';
import 'package:bontempo/components/general/no_results.dart';
import 'package:bontempo/components/general/stock_item.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/sized_box_loader.dart';
import 'package:bontempo/models/stock_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:bontempo/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  List<StockModel> _stock = [];
  bool _loading = false;
  bool _adding = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<CartBloc>(context).add(LoadCartEvent());
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
      BlocProvider.of<CartBloc>(context).add(LoadCartEvent());
    }
  }

  void addItem(String title) {
    BlocProvider.of<CartBloc>(context).add(AddCartEvent(title: title));
  }

  void changeItemQuantity(StockModel item) {
    BlocProvider.of<CartBloc>(context).add(ChangeCartEvent(
      item: item,
    ));
  }

  void deleteItem(StockModel item) {
    BlocProvider.of<CartBloc>(context).add(RemoveCartEvent(
      item: item,
    ));
  }

  void addToStock(StockModel item) {
    BlocProvider.of<StocksBloc>(context).add(AddStockEvent(
      title: item.title,
      quantity: item.quantity,
    ));
    BlocProvider.of<CartBloc>(context).add(ChangeCartEvent(
      item: item.copyWith(quantity: 0),
    ));
  }

  void share() {
    String content = 'LISTA DE COMPRAS\n';

    if (this._stock.length > 0) {
      this._stock.forEach((StockModel stock) {
        content += '\n' +
            stock.quantity.toString() +
            ' ' +
            stock.title.replaceAll(
                RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), '');
      });
    }

    Share.share(
      content,
      subject: 'LISTA DE COMPRAS',
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<StocksBloc, StocksState>(
          listener: (BuildContext ctx, StocksState state) {
            if (state is AddedStocksState) {
              showSnackbar(
                context: context,
                text: 'Produto adicionado ao seu estoque.',
              );
            }
          },
        ),
        BlocListener<CartBloc, CartState>(
          listener: (BuildContext ctx, CartState state) {
            if (state is ErrorCartState) {
              showScaleDialog(
                context: context,
                child: CustomDialog(
                  title: 'Ocorreu um probleminha',
                  description: state.errorMessage,
                  buttonText: "Fechar",
                ),
              );
            } else if (state is LoadedCartState) {
              setState(() {
                _stock.addAll(state.items);
                _loading = false;
              });
            } else if (state is UninitializedCartState) {
              setState(() {
                _stock.clear();
                _loading = false;
              });
            } else if (state is AddingCartState) {
              setState(() {
                _adding = true;
              });
            } else if (state is AddedCartState) {
              setState(() {
                _stock.insert(0, state.item);
                _adding = false;
              });
            } else if (state is ChangedCartState) {
              int index = _stock
                  .indexWhere((StockModel item) => item.id == state.item.id);
              setState(() {
                _stock[index] = state.item;
              });
            } else if (state is DeletedCartState) {
              _stock.removeWhere((StockModel item) => item.id == state.item.id);
              setState(() {
                _stock = _stock;
              });
              showSnackbar(
                context: context,
                text: 'Item removido com sucesso!',
              );
            }
          },
        ),
      ],
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(120),
                title: 'Lista de Compras',
                description:
                    'Faça aqui sua lista de compras, adicione e exclua o que necessário.',
                descriptionPadding: 60.0,
                titlePadding: 68.0,
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
                    top: ScreenUtil().setWidth(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AddItem(
                        placeholder: 'Adicionar produtos',
                        callback: this.addItem,
                        loading: this._adding,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(60),
                          bottom: ScreenUtil().setWidth(8),
                          top: ScreenUtil().setWidth(28),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Produto',
                              style: TextStyle(
                                color: black[200],
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(115),
                              child: Center(
                                child: Text(
                                  'Qntd.',
                                  style: TextStyle(
                                    color: black[200],
                                    fontSize: ScreenUtil().setSp(15),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _stock.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return StockItem(
                            key: Key('cartItem${_stock[index].id}'),
                            item: _stock[index],
                            isStockItem: false,
                            themeLight: index % 2 == 0,
                            onChange: this.changeItemQuantity,
                            onDelete: this.deleteItem,
                            onButtonPress: this.addToStock,
                          );
                        },
                      ),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (BuildContext ctx, CartState state) {
                          if (state is LoadingCartState) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: new List.filled(
                                _stock.length > 0 ? 1 : 4,
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: ScreenUtil().setWidth(2),
                                  ),
                                  child: SizedBoxLoader(
                                    width: double.infinity,
                                    height: ScreenUtil().setWidth(46),
                                  ),
                                ),
                              ).toList(),
                            );
                          }
                          if (state is! LoadingCartState &&
                              _stock.length == 0) {
                            return NoResults(
                              text:
                                  'Nenhum produto adicionado a sua lista de compras.',
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                      _stock.length > 0
                          ? CommonButton(
                              margin: EdgeInsets.only(
                                top: ScreenUtil().setWidth(30),
                              ),
                              theme: CustomTheme.black,
                              onTap: this.share,
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
                                    'COMPARTILHAR LISTA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container()
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
