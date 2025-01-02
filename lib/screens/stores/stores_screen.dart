import 'package:bontempo/blocs/stores/index.dart';
import 'package:bontempo/components/cards/store_card.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/select_state.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/store_model.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoresScreen extends StatefulWidget {
  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  List<StoreModel> _stores = [];
  List<StoreModel> _filteredStores = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    loadStores();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void loadStores() {
    BlocProvider.of<StoreBloc>(context).add(LoadStoresEvent());
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold && !_loading) {
      setState(() {
        _loading = true;
      });
      loadStores();
    }
  }

  void _filterStoresByState(String? state) {
    setState(() {
      if (state == null || state.isEmpty) {
        // Show all stores if no state is selected
        _filteredStores = _stores;
      } else {
        // Filter stores by the selected state
        _filteredStores = _stores.where((store) {
          return store.address.contains(state);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<StoreBloc, StoreState>(
      listener: (BuildContext ctx, StoreState state) {
        if (state is ErrorStoreState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedStoreState) {
          setState(() {
            _stores = state.items;
            _filteredStores = _stores; // Initialize filtered stores
            _loading = false;
          });
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(90),
                title: 'Lojas',
                description: 'Selecione uma de nossas lojas',
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
                      SelectState(
                        onSelected: (value) {
                          _filterStoresByState(value);
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(16),
                      ),
                      _filteredStores.isEmpty && !_loading
                          ? Center(
                              child: Text(
                                'Ainda não existem lojas na região.',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(16),
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: _filteredStores.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return StoreCard(
                                  model: _filteredStores[index],
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      StoresDetailsViewRoute,
                                      arguments: _filteredStores[index],
                                    );
                                  },
                                );
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
