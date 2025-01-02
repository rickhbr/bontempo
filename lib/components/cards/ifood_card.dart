import 'package:bontempo/components/cards/common_card.dart';
import 'package:flutter/material.dart';

class IfoodCard extends StatelessWidget {
  final String title;

  const IfoodCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      buttonTitle: 'PEÇA NO IFOOD',
      imageAsset: 'assets/images/ifood.png',
      title: title,
      onTap: () {},
    );
  }
}
