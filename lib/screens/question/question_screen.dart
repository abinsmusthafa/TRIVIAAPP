import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triviaapp/design_helper/size_config.dart';
import 'package:triviaapp/design_helper/styling.dart';
import 'package:triviaapp/model/question_model.dart';
import 'package:triviaapp/screens/question/question_bloc.dart';
import 'package:triviaapp/util/show_toast.dart';
import 'package:triviaapp/util/vibrate_phone.dart';
import 'package:triviaapp/widgets/custom_text.dart';
import 'package:triviaapp/widgets/widget_error.dart';
import 'package:triviaapp/widgets/ronded_button.dart';
import 'package:triviaapp/widgets/shimmer_loader.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  QuestionScreenBloc _bloc = QuestionScreenBloc();
  List<Results> questions = [];
  int questionIndex = 0;
  List<String> options = [];
  String selectedRadioTile = "";
  int totalScore = 0;

  @override
  void initState() {
    // TODO: implement initState
    _bloc.add(PreformGetQuestionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appSecColor,
          centerTitle: true,
          title: CustomText(
            text: "TRIVIA APP",
            size: SizeConfig.textMultiplier * 3,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        body: BlocConsumer<QuestionScreenBloc, QuestionScreenState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state is GetQuestionSuccessState) {
                questions = state.questions.results;
                options = questions[questionIndex].incorrectAnswers..add(questions[questionIndex]?.correctAnswer);
                options.shuffle();
              }
            },
            builder: (BuildContext context, QuestionScreenState state) {
              if (state is GetQuestionSuccessState) {
                if(state?.questions?.results?.isEmpty ?? true) {
                  return WidgetError(
                    errorMessage: "No question found",
                    errorImageUrl: "assets/images/something_went.png",
                    onClick: () {
                      _bloc.add(PreformGetQuestionsEvent());
                    },
                  );
                }
                return Center(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier * 5, horizontal: SizeConfig.widthMultiplier * 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Question ${questionIndex + 1}",
                            textAlign: TextAlign.start,
                            color: AppTheme.appSecColor,
                            weight: FontWeight.w600,
                            size: SizeConfig.textMultiplier * 2.2,
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier * 2,
                          ),
                          CustomText(
                            text: questions[questionIndex]?.question ?? "",
                            textAlign: TextAlign.start,
                            weight: FontWeight.bold,
                            size: SizeConfig.textMultiplier * 2.2,
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier * 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 3),
                            child: CustomText(
                              text: "Choices",
                              textAlign: TextAlign.start,
                              color: AppTheme.appSecColor,
                              weight: FontWeight.w600,
                              size: SizeConfig.textMultiplier * 2.2,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier * 2,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List<Widget>.generate(
                              options.length,
                              (int i) => RadioListTile(
                                value: options[i],
                                groupValue: selectedRadioTile,
                                title: Text(options[i],style: TextStyle(color: AppTheme.appSecColor,fontSize: SizeConfig.textMultiplier * 2,fontWeight:  FontWeight.bold),),
                                onChanged: (String val) {
                                  setSelectedRadioTile(val);
                                },
                                activeColor: AppTheme.appSecColor,
                                selected: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier * 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: SizeConfig.widthMultiplier * 35,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
                                  child: FlatButton(
                                      color: Colors.yellow,
                                      padding: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier * 3, horizontal: SizeConfig.widthMultiplier * 3),
                                      onPressed: () {
                                        _calculateAndUpdateNewQuestion(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.transparent,
                                          ),
                                          Text(
                                            "Next",
                                            style: TextStyle(color: AppTheme.appSecColor, fontSize: SizeConfig.textMultiplier * 3),
                                          ),
                                          Icon(Icons.arrow_forward),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is QuestionScreenLoadingState || state is InitialQuestionScreenState) {
                return ShimmerLoader();
              } else if (state is GetAllQuestionLoadErrorState) {
                return WidgetError(
                  errorMessage: "Something went wrong",
                  errorImageUrl: "assets/images/something_went.png",
                  onClick: () {
                    _bloc.add(PreformGetQuestionsEvent());
                  },
                );
              } else if (state is ShowResultState) {
                return resultWidget();
              }
              return WidgetError(
                errorMessage: "Something went wrong",
                errorImageUrl: "assets/images/something_went.png",
                onClick: () {
                  _bloc.add(PreformGetQuestionsEvent());
                },
              );
            }));
  }

  Widget resultWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "Your score is",
            textAlign: TextAlign.start,
            color: Colors.black,
            weight: FontWeight.w500,
            size: SizeConfig.textMultiplier * 4,
          ),
          SizedBox(
            height: SizeConfig.widthMultiplier * 2,
          ),
          CustomText(
            text: "$totalScore/100",
            textAlign: TextAlign.start,
            weight: FontWeight.w500,
            size: SizeConfig.textMultiplier * 4,
          ),
          RoundedButton(
            text: "RETAKE TRIVIA",
            isShowArrow: false,
            textColor: Colors.lightBlue,
            buttonColor: Colors.yellow,
            function: () {
              totalScore = 0;
              _bloc.add(PreformGetQuestionsEvent());
            },
          ),
        ],
      ),
    );
  }

  setSelectedRadioTile(String val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  _calculateAndUpdateNewQuestion(BuildContext contexts) {
    if (questions[questionIndex]?.correctAnswer == selectedRadioTile) {
      totalScore += 10;
    } else {
      Vibrate().vibratePhone(200);
      ShowToast(context: contexts, colors: Colors.red, duration: 3000, toastMessage: "Answer is: ${questions[questionIndex]?.correctAnswer}").shoToast();
    }
    if (questionIndex == 9) {
      questionIndex = 0;
      options.clear();
      questions.clear();
      _bloc.add(PreformShowResultEvent());
      return;
    }
    questionIndex += 1;
    options = questions[questionIndex].incorrectAnswers..add(questions[questionIndex]?.correctAnswer);
    options.shuffle();
    setState(() {});
  }
}
