import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
class ShowToast {

  final BuildContext context;
  final String toastMessage;
  final int duration;
  final MaterialColor colors;
  ShowToast({this.context, this.toastMessage, this.duration,this.colors = Colors.red});

  void shoToast() {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: colors,
      message: toastMessage,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      duration: Duration(milliseconds: duration),
    )..show(context);
  }

}