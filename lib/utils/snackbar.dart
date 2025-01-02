import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String text,
}) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.hideCurrentSnackBar();
  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'FECHAR',
        textColor: Colors.white,
        onPressed: () {
          scaffoldMessenger.hideCurrentSnackBar();
        },
      ),
    ),
  );
}
