import 'package:bontempo/blocs/cart/index.dart';
import 'package:bontempo/blocs/stocks/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/add_item.dart';
import 'package:bontempo/components/general/no_results.dart';
import 'package:bontempo/components/general/stock_item.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/sized_box_loader.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/stock_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:bontempo/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StocksScreen extends StatefulWidget {
  @override
  _StocksScreenState createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  List<StockModel> _stock = [];
  bool _loading = false;
  bool _adding = false;
  int _totalCart = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<StocksBloc>(context).add(LoadStocksEvent());
    BlocProvider.of<CartBloc>(context).add(CheckTotalCartEvent());
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
      BlocProvider.of<StocksBloc>(context).add(LoadStocksEvent());
    }
  }

  void addItem(String title) {
    BlocProvider.of<StocksBloc>(context).add(AddStockEvent(title: title));
  }

  void changeItemQuantity(StockModel item) {
    BlocProvider.of<StocksBloc>(context).add(ChangeStockEvent(
      item: item,
    ));
  }

  void deleteItem(StockModel item) {
    BlocProvider.of<StocksBloc>(context).add(RemoveStockEvent(
      item: item,
    ));
  }

  void addToCart(StockModel item) {
    BlocProvider.of<CartBloc>(context).add(AddCartEvent(
      title: item.title,
      quantity: item.quantity,
    ));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<CartBloc, CartState>(
          listener: (BuildContext ctx, CartState state) {
            if (state is CheckedTotalCartState) {
              setState(() {
                _totalCart = state.total;
              });
            }
            if (state is AddedCartState) {
              showSnackbar(
                context: context,
                text: 'Item adicionado a lista de compras',
              );
              setState(() {
                _totalCart = _totalCart + 1;
              });
            }
          },
        ),
        BlocListener<StocksBloc, StocksState>(
          listener: (BuildContext ctx, StocksState state) {
            if (state is ErrorStocksState) {
              showScaleDialog(
                context: context,
                child: CustomDialog(
                  title: 'Ocorreu um probleminha',
                  description: state.errorMessage,
                  buttonText: "Fechar",
                ),
              );
            } else if (state is LoadedStocksState) {
              setState(() {
                _stock.addAll(state.items);
                _loading = false;
              });
            } else if (state is UninitializedStocksState) {
              setState(() {
                _stock.clear();
                _loading = false;
              });
            } else if (state is AddingStocksState) {
              setState(() {
                _adding = true;
              });
            } else if (state is AddedStocksState) {
              setState(() {
                _stock.insert(0, state.item);
                _adding = false;
              });
            } else if (state is ChangedStocksState) {
              int index = _stock
                  .indexWhere((StockModel item) => item.id == state.item.id);
              setState(() {
                _stock[index] = state.item;
              });
            } else if (state is DeletedStocksState) {
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
                title: 'Meu Estoque',
                description: 'Veja aqui o seu estoque de ingredientes.',
                descriptionPadding: 108.0,
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
                        placeholder: 'Adicionar item',
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
                            key: Key('stockItem${_stock[index].id}'),
                            item: _stock[index],
                            themeLight: index % 2 == 0,
                            onChange: this.changeItemQuantity,
                            onDelete: this.deleteItem,
                            onButtonPress: this.addToCart,
                          );
                        },
                      ),
                      BlocBuilder<StocksBloc, StocksState>(
                        builder: (BuildContext ctx, StocksState state) {
                          if (state is LoadingStocksState) {
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
                          if (state is! LoadingStocksState &&
                              _stock.length == 0) {
                            return NoResults(
                              text:
                                  'Você não possui nenhum item em seu estoque.',
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                      CommonButton(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setWidth(30),
                        ),
                        theme: CustomTheme.green,
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            ShoppingCartViewRoute,
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              height: ScreenUtil().setWidth(30),
                              width: ScreenUtil().setWidth(30),
                              margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(12),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  _totalCart != null
                                      ? _totalCart.toString()
                                      : '',
                                  style: TextStyle(
                                    color: black[200],
                                    fontSize: ScreenUtil().setSp(15),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'IR PARA A LISTA DE COMPRAS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
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
