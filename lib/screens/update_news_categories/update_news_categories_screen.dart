import 'package:bontempo/blocs/news_categories/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/toggle_interest.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/models/news_category_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateNewsCategoriesScreen extends StatefulWidget {
  const UpdateNewsCategoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _UpdateNewsCategoriesScreenState createState() =>
      _UpdateNewsCategoriesScreenState();
}

class _UpdateNewsCategoriesScreenState
    extends State<UpdateNewsCategoriesScreen> {
  _UpdateNewsCategoriesScreenState();

  List<NewsCategoryModel>? newsCategories;
  List<int> _selected = [];
  bool _blockUI = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsCategoriesBloc>(context).add(LoadNewsCategoriesEvent());
  }

  void _save() {
    if (!this._blockUI) {
      if (this._selected.length < 1) {
        showScaleDialog(
          context: context,
          child: CustomDialog(
            title: 'Atenção!',
            description: 'Selecione no mínimo uma categoria de seu interesse.',
            buttonText: "Fechar",
          ),
        );
      } else {
        setState(() {
          this._blockUI = true;
        });
        BlocProvider.of<NewsCategoriesBloc>(context)
            .add(SaveNewsCategoriesEvent(this._selected));
      }
    }
  }

  void _checkSelected(int id) {
    if (!this._selected.contains(id)) {
      setState(() {
        this._selected.add(id);
      });
    } else {
      setState(() {
        this._selected.remove(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener(
      bloc: BlocProvider.of<NewsCategoriesBloc>(context),
      listener: (BuildContext context, state) {
        if (state is LoadedNewsCategoriesState) {
          setState(() {
            newsCategories = state.items;
          });
          BlocProvider.of<NewsCategoriesBloc>(context)
              .add(LoadClientNewsCategoriesEvent());
        }

        if (state is LoadedClientNewsCategoriesState) {
          state.items.forEach((NewsCategoryModel item) {
            setState(() {
              this._selected.add(item.id);
            });
          });
        }

        if (state is ErrorNewsCategoriesState) {
          setState(() {
            this._blockUI = false;
          });
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is SavedNewsCategoriesState) {
          setState(() {
            this._blockUI = false;
          });
          Navigator.pushNamedAndRemoveUntil(
            context,
            MyProfileViewRoute,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          physics: new ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(30),
            vertical: ScreenUtil().setHeight(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(50),
                    ),
                    child: Text(
                      "Escolha as categorias de notícias de seu interesse.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              this.newsCategories != null
                  ? ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(30),
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: this.newsCategories!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ToggleInterest(
                          id: this.newsCategories![index].id,
                          title: this.newsCategories![index].title,
                          lock: this._blockUI,
                          titleColor: Colors.black,
                          callback: this._checkSelected,
                          selected: this
                              ._selected
                              .contains(this.newsCategories![index].id),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          color: black[300],
                          width: double.infinity,
                          height: 1,
                        );
                      },
                    )
                  : Center(
                      child: Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: ScreenUtil().setWidth(30),
                          height: ScreenUtil().setWidth(30),
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
              CommonButton(
                theme: CustomTheme.black,
                onTap: this._selected.length > 0 && !this._blockUI
                    ? this._save
                    : null,
                child: BlocBuilder(
                  bloc: BlocProvider.of<NewsCategoriesBloc>(context),
                  builder: (BuildContext context, state) {
                    if (state is SavingNewsCategoriesState) {
                      return Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: ScreenUtil().setWidth(30),
                          height: ScreenUtil().setWidth(30),
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Text(
                        'SALVAR',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
