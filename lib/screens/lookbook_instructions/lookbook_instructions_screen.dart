import 'package:bontempo/blocs/clothing/index.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/layout/common_back_header.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/env.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LookBookInstructionsScreen extends StatefulWidget {
  @override
  _LookBookInstructionsScreenState createState() =>
      _LookBookInstructionsScreenState();
}

class _LookBookInstructionsScreenState
    extends State<LookBookInstructionsScreen> {
  bool _hasClothes = false;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClothingBloc>(context).add(LoadClothingEvent());

    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          'https://www.youtube.com/watch?v=w4mjS7n6cSw')!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<ClothingBloc, ClothingState>(
      listener: (BuildContext ctx, ClothingState state) {
        if (state is LoadedClothingState) {
          setState(() {
            _hasClothes = state.items!.isNotEmpty;
          });
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          physics: new ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CommonBackHeader(
                title: 'Organize agora mesmo seu guarda-roupas.',
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30),
                  bottom: ScreenUtil().setHeight(36),
                  top: ScreenUtil().setWidth(22),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Cadastre suas roupas, calçados e acessórios para que o App possa sugerir o melhor look para o seu evento.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: black,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(35),
                        bottom: ScreenUtil().setWidth(19),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: YoutubePlayer(
                                  controller: _youtubeController,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.amber,
                                  onReady: () {
                                    _youtubeController.play();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: ((MediaQuery.of(context).size.width -
                                      ScreenUtil().setWidth(60)) *
                                  189) /
                              355,
                          color: Colors.grey[200],
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.play_circle_outline,
                                  color: black[50],
                                  size: ScreenUtil().setSp(48),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: ScreenUtil().setWidth(15),
                                    left: ScreenUtil().setWidth(30),
                                    right: ScreenUtil().setWidth(30),
                                  ),
                                  child: Text(
                                    'Assista ao vídeo explicativo de como cadastrar as suas peças.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: black[50],
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    CommonButton(
                      theme: CustomTheme.green,
                      onTap: () {
                        Navigator.pushNamed(
                            context,
                            this._hasClothes
                                ? LookBookAddViewRoute
                                : ClothesAddViewRoute);
                      },
                      child: Text(
                        'ENTENDI, QUERO CADASTRAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
