import 'package:bontempo/blocs/user/index.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/forms/custom_form.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  void _submit(Map<String, dynamic> data) {
    if (!this._loading) {
      BlocProvider.of<UserBloc>(context).add(
        UpdateProfileEvent(data: data),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<UserBloc, UserState>(
      listener: (BuildContext ctx, UserState state) {
        if (state is ErrorUpdateProfileState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedUpdateProfileState) {
          setState(() {
            _loading = false;
          });
          Navigator.pop(context);
        }

        setState(() {
          _loading = state is LoadingUpdateProfileState;
        });
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      ScreenUtil().setWidth(70) -
                      ScreenUtil().setHeight(98),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(30),
                        left: ScreenUtil().setWidth(36),
                        right: ScreenUtil().setWidth(36),
                      ),
                      child: Text(
                        'Preencha os campos abaixo para cadastrar-se e acessar o App Bontempo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w300,
                          letterSpacing: -.14,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(36),
                        left: ScreenUtil().setWidth(36),
                        right: ScreenUtil().setWidth(36),
                      ),
                      child: CustomForm(
                        theme: CustomTheme.green,
                        buttonTheme: CustomTheme.black,
                        fields: [
                          {
                            'capitalize': true,
                            'initialValue':
                                RepositoryProvider.of<UserRepository>(context)
                                    .getUserFastParam("computed_firstname")
                                    .toString(),
                            'name': 'name',
                            'type': 'text',
                            'isRequired': true,
                            'labelText': 'NOME',
                            'hintText': 'Digite o seu nome',
                          },
                          {
                            'name': 'email',
                            'type': 'email',
                            'initialValue':
                                RepositoryProvider.of<UserRepository>(context)
                                    .getUserFastParam("email")
                                    .toString(),
                            'isRequired': true,
                            'labelText': 'E-MAIL',
                            'hintText': 'Digite o seu e-mail',
                          },
                          {
                            'name': 'phone',
                            'type': 'phone',
                            'initialValue':
                                RepositoryProvider.of<UserRepository>(context)
                                    .getUserFastParam("phone")
                                    .toString(),
                            'isRequired': true,
                            'labelText': 'TELEFONE',
                            'hintText': 'Digite o seu telefone',
                          },
                          // {
                          //   'name': 'cpf',
                          //   'type': 'numeric',
                          //   'initialValue':
                          //       RepositoryProvider.of<UserRepository>(context)
                          //           .getUserFastParam("cpf")
                          //           .toString(),
                          //   'isRequired': false,
                          //   'labelText': 'CPF',
                          //   'hintText': 'Digite seu CPF',
                          // },
                          {
                            'name': 'has_furniture',
                            'type': 'checkbox',
                            'isRequired': false,
                            'labelText': 'Eu tenho móveis Bontempo',
                            'initialValue':
                                RepositoryProvider.of<UserRepository>(context)
                                    .getUserFastParam("computed_has_furniture"),
                          },
                        ],
                        submitText: BlocBuilder(
                          bloc: BlocProvider.of<UserBloc>(context),
                          builder: (BuildContext context, state) {
                            if (state is LoadingUpdateProfileState) {
                              return Material(
                                color: Colors.transparent,
                                child: SizedBox(
                                  width: ScreenUtil().setWidth(30),
                                  height: ScreenUtil().setWidth(30),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
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
                        onSubmit: this._submit,
                        disabled: this._loading,
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
