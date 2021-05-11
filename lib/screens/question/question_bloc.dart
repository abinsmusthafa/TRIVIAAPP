import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:triviaapp/error/app_error.dart';
import 'package:triviaapp/model/question_model.dart';
import 'package:triviaapp/services/question_service.dart';

class QuestionScreenBloc extends Bloc<QuestionScreenEvent, QuestionScreenState> {
  @override
  QuestionScreenState get initialState => InitialQuestionScreenState();

  @override
  Stream<QuestionScreenState> mapEventToState(
      QuestionScreenEvent event,
      ) async* {
    if (event is PreformGetQuestionsEvent) {
      yield QuestionScreenLoadingState();
      try {
        Question question = await QuestionService().getQuestions();
        yield GetQuestionSuccessState(questions: question);
      } catch (error) {
        AppError _handledError;
        if (error is AppError) {
          _handledError = AppError(error.code, "Unable to communicate with the server\n at the moment.");

        }
        if (_handledError == null) {
          _handledError = AppError(error.INTERNAL_ERROR, "Unable to fetch questions now.\nPlease try again!");
        }
        yield GetAllQuestionLoadErrorState(_handledError);
      }
    } else if (event is PreformShowResultEvent) {
      yield ShowResultState();
    }
  }
}

// ---------------------------------------
// Events for this bloc
// ---------------------------------------

@immutable
abstract class QuestionScreenEvent {}

class PreformGetQuestionsEvent extends QuestionScreenEvent {}
class PreformShowResultEvent extends QuestionScreenEvent {}

// ---------------------------------------
// States for this bloc
// ---------------------------------------

@immutable
abstract class QuestionScreenState {}

class InitialQuestionScreenState extends QuestionScreenState {}

class QuestionScreenLoadingState extends QuestionScreenState {}
class ShowResultState extends QuestionScreenState {}

class GetAllQuestionLoadErrorState extends QuestionScreenState {
  final AppError error;

  GetAllQuestionLoadErrorState(this.error);
}

class GetQuestionSuccessState extends QuestionScreenState {
  final Question questions;

  GetQuestionSuccessState({this.questions});
}
