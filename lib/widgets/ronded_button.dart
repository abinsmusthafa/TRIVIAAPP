import 'package:flutter/material.dart';
import 'package:triviaapp/design_helper/size_config.dart';
import 'package:triviaapp/design_helper/styling.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function function;
  final Color buttonColor, textColor;
  final bool isShowArrow;
  const RoundedButton({Key key, this.text, this.function, this.buttonColor = Colors.yellow, this.textColor = Colors.white, this.isShowArrow = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier * 4),
      width: SizeConfig.widthMultiplier * 75,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
        child: FlatButton(
            color: buttonColor,
            padding: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier * 4, horizontal: SizeConfig.widthMultiplier * 10),
            onPressed: function,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isShowArrow?  Icon(Icons.arrow_forward,color: Colors.transparent,): Container(),
                Text(
                  text,
                  style: TextStyle(color: textColor,fontSize: SizeConfig.textMultiplier * 3),
                ),
                isShowArrow? Icon(Icons.arrow_forward): Container(),
              ],
            )),
      ),
    );
  }
}
