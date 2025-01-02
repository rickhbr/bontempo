import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SizedBoxLoader extends StatelessWidget {
  final double? width;
  final double? height;

  const SizedBoxLoader({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(.1),
      highlightColor: Colors.grey.withOpacity(.35),
      enabled: true,
      child: Container(
        color: Colors.grey,
        width: this.width,
        height: this.height,
      ),
    );
  }
}
