import 'package:bontempo/components/cards/common_card.dart';
import 'package:bontempo/components/typography/column_title.dart';
import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:device_apps/device_apps.dart';

class HomeFoodAppCard extends StatefulWidget {
  final HomeModel home;

  const HomeFoodAppCard({Key? key, required this.home}) : super(key: key);

  @override
  _HomeFoodAppCardState createState() => _HomeFoodAppCardState();
}

class _HomeFoodAppCardState extends State<HomeFoodAppCard> {
  ApplicationWithIcon? foodApp;
  String? foodIcon;

  @override
  void initState() {
    super.initState();
    getApps();
  }

  Future<void> getApps() async {
    List<String> packages = [
      'br.com.brainweb.ifood',
      'com.ubercab.eats',
      'br.com.deliverymuch.gastro',
      'com.xiaojukeji.didi.brazil.customer',
      'com.grability.rappi',
    ];
    List<double> weights = [5, 4, 3, 2, 1];
    while (packages.isNotEmpty && foodApp == null) {
      String package = randomChoice<String>(packages, weights);

      bool available = await DeviceApps.isAppInstalled(package);
      if (available) {
        ApplicationWithIcon app =
            await DeviceApps.getApp(package, true) as ApplicationWithIcon;
        String? icon;
        switch (package) {
          case 'br.com.brainweb.ifood':
            icon = 'assets/images/ifood.png';
            break;
          case 'com.ubercab.eats':
            icon = 'assets/images/ubereats.png';
            break;
          case 'br.com.deliverymuch.gastro':
            icon = 'assets/images/deliverymuch.png';
            break;
          case 'com.xiaojukeji.didi.brazil.customer':
            icon = 'assets/images/99food.png';
            break;
          case 'com.grability.rappi':
            icon = 'assets/images/rappi.png';
            break;
        }
        setState(() {
          foodApp = app;
          foodIcon = icon;
        });
      } else {
        packages.removeWhere((String item) => item == package);
        weights.removeLast();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return foodApp != null
        ? Column(
            children: <Widget>[
              ColumnTitle(
                theme: widget.home.mode == HomeMode.day
                    ? CustomTheme.black
                    : CustomTheme.white,
                lightTitle: 'Não está afim de cozinhar?',
                boldTitle: 'Peça uma tele-entrega:',
              ),
              CommonCard(
                buttonTitle: 'IR PARA O APP',
                imageAsset: foodIcon,
                imageMemory: foodIcon == null ? foodApp?.icon : null,
                title: 'Faça seu pedido pelo ${foodApp?.appName}',
                onTap: () {
                  DeviceApps.openApp(foodApp?.packageName ?? '');
                },
              ),
            ],
          )
        : Container();
  }
}
