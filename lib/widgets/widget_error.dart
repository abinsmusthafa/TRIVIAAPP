import 'package:flutter/material.dart';
import 'package:triviaapp/design_helper/size_config.dart';

class WidgetError extends StatelessWidget {
  final String errorMessage;
  final String errorImageUrl;
  final Function onClick;

  const WidgetError({Key key, this.errorMessage, this.onClick, this.errorImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1,
          colors: [
            Colors.transparent, // blue sky
            Colors.black12, // yellow sun
          ],
          stops: [0.4, 1.0],
        ),
      ),
      padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            errorImageUrl,
            width: SizeConfig.widthMultiplier * 25,
            height: SizeConfig.widthMultiplier * 25,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            errorMessage,
            style: TextStyle(
              fontSize: SizeConfig.widthMultiplier * 4,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 13),
            color: Colors.yellow.withOpacity(.9),
            textColor: Colors.white,
            child: Text(
              "Retry",
              style: TextStyle(
                fontSize: SizeConfig.widthMultiplier * 5,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              onClick();
            },
          ),
        ],
      ),
    );
  }
}
