import 'package:flutter/material.dart';
import 'package:triviaapp/design_helper/size_config.dart';
import 'package:triviaapp/design_helper/styling.dart';
import 'package:triviaapp/screens/question/question_screen.dart';
import 'package:triviaapp/widgets/custom_text.dart';
import 'package:triviaapp/widgets/ronded_button.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:     Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

      children: [
        CustomText(
          text: "TRIVIA APP",
          color: Colors.black54,
          weight: FontWeight.bold,
          size: SizeConfig.textMultiplier * 4,
        ),
        SizedBox(height: SizeConfig.widthMultiplier *10,),
        RoundedButton(
          text: "TAKE TRIVIA",
          textColor: AppTheme.appSecColor,
          buttonColor: Colors.yellow,
          function: (){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => QuestionScreen()),
                  (Route<dynamic> route) => false,
            );
          },
        ),

      ],
      ),
    ));
  }
}
