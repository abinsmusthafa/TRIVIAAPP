import 'package:flutter/material.dart';
import 'package:triviaapp/design_helper/size_config.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
final TextAlign textAlign ;

  CustomText({this.text, this.size, this.color, this.weight,this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.fade,
      style: (TextStyle(color: color ?? Colors.black, fontSize: size ?? SizeConfig.textMultiplier * 2, fontWeight: weight ?? FontWeight.normal,)),
    );
  }
}
