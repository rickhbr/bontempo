// import 'package:app_launcher/app_launcher.dart';
import 'package:bontempo/components/cards/common_card.dart';
import 'package:bontempo/components/typography/column_title.dart';
import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';

class HomeFoodAppCard extends StatefulWidget {
  final HomeModel home;

  const HomeFoodAppCard({Key? key, required this.home}) : super(key: key);

  @override
  _HomeFoodAppCardState createState() => _HomeFoodAppCardState();
}

class _HomeFoodAppCardState extends State<HomeFoodAppCard> {
  String? foodAppName;
  String? foodIcon;
  String? foodPackage;

  @override
  void initState() {
    super.initState();
    getApps();
  }

  Future<void> getApps() async {
    List<Map<String, String>> apps = [
      {'package': 'br.com.brainweb.ifood', 'icon': 'assets/images/ifood.png', 'name': 'iFood'},
      {'package': 'com.ubercab.eats', 'icon': 'assets/images/ubereats.png', 'name': 'Uber Eats'},
      {'package': 'br.com.deliverymuch.gastro', 'icon': 'assets/images/deliverymuch.png', 'name': 'Delivery Much'},
      {'package': 'com.xiaojukeji.didi.brazil.customer', 'icon': 'assets/images/99food.png', 'name': '99 Food'},
      {'package': 'com.grability.rappi', 'icon': 'assets/images/rappi.png', 'name': 'Rappi'},
    ];
    List<double> weights = [5, 4, 3, 2, 1];

    while (apps.isNotEmpty && foodAppName == null) {
      int index = randomChoice<int>(List.generate(apps.length, (i) => i), weights);
      String package = apps[index]['package']!;

      try {
        AppInfo? appInfo = await InstalledApps.getAppInfo(package);
        if (appInfo != null) {
          setState(() {
            foodAppName = apps[index]['name'];
            foodIcon = apps[index]['icon'];
            foodPackage = appInfo.packageName;
          });
          break;
        }
      } catch (e) {
        apps.removeAt(index);
        weights.removeAt(index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return foodAppName != null
        ? Column(
            children: <Widget>[
              ColumnTitle(
                theme: widget.home.mode == HomeMode.day ? CustomTheme.black : CustomTheme.white,
                lightTitle: 'Não está afim de cozinhar?',
                boldTitle: 'Peça uma tele-entrega:',
              ),
              CommonCard(
                buttonTitle: 'IR PARA O APP',
                imageAsset: foodIcon,
                title: 'Faça seu pedido pelo $foodAppName',
                onTap: () async {
                  if (foodPackage != null) {
                    // await AppLauncher.openApp(androidApplicationId: foodPackage!);
                  }
                },
              ),
            ],
          )
        : Container();
  }
}
