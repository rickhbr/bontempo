import 'dart:math';
import 'package:flutter/material.dart';

void showTransformDialog({
  required BuildContext context,
  required Widget child,
}) {
  showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.6),
    transitionBuilder: (context, a1, a2, widget) {
      final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 50, 0.0),
        child: Opacity(opacity: a1.value, child: child),
      );
    },
    transitionDuration: Duration(milliseconds: 200),
    barrierDismissible: false,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return const SizedBox.shrink();
    },
  );
}

void showScaleDialog({
  required BuildContext context,
  required Widget child,
  bool dismissible = false,
}) {
  showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.6),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: max(0.7, a1.value),
        child: Opacity(
          opacity: a1.value,
          child: child,
        ),
      );
    },
    transitionDuration: Duration(milliseconds: 200),
    barrierDismissible: dismissible,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return const SizedBox.shrink();
    },
  );
}
