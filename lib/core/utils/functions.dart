import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';




void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
      (route) {return false;},
);

enum ToastState { success, error, warning }

extension ToastStateExtension on ToastState {
  Color get color {
    switch (this) {
      case ToastState.success:
        return Colors.green;
      case ToastState.error:
        return Colors.red;
      case ToastState.warning:
        return Colors.amber;
    }
  }
}

void showToast({
  required String message,
  required ToastState state,
  ToastGravity gravity = ToastGravity.BOTTOM,
  int durationInSeconds = 3,
}) {
  Fluttertoast.cancel(); // يمنع تكدس التوستات
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gravity,
    timeInSecForIosWeb: durationInSeconds,
    backgroundColor: state.color.withOpacity(0.95),
    textColor: Colors.white,
    fontSize: 14.0,
  );
}