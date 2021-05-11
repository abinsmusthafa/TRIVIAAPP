import 'dart:async';
import 'package:flutter/material.dart';
import 'package:triviaapp/screens/initial_screen.dart';
import 'package:triviaapp/design_helper/size_config.dart';
import 'package:triviaapp/design_helper/styling.dart';
import 'package:triviaapp/widgets/custom_text.dart';


class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => InitialScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 1));
    animation = new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.only(bottom: SizeConfig.widthMultiplier * 10),
                child: CustomText(text: "TRIVIA APP",size: animation.value * 40,weight: FontWeight.w500,textAlign: TextAlign.center,color: AppTheme.appSecColor,),
              )
            ],
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/images/trivia.png',
                width: animation.value * 200,
                height: animation.value * 200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
