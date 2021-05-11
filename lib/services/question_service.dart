import 'dart:convert';

import 'package:triviaapp/error/app_error.dart';
import 'package:triviaapp/model/question_model.dart';
import 'package:triviaapp/services/api_services.dart';

class QuestionService extends ApiService {
  static final fetchQuestionsList = '/api.php';

  Future<Question> getQuestions() async {
    var headers = Map<String, String>();
    var params = Map<String, String>();
    headers['Content-Type'] = 'application/json';
    params["amount"] = "10";
    params["type"] = "multiple";
    var apiPath = fetchQuestionsList;

    Future<ParsedResponse> future = get(
      apiPath,
      params: params,
      headers: headers,
    );

    return future.then((ParsedResponse res) async {
      if (res.isOk()) {
        try {
          var responseObject = json.decode(res.response);
          ;
          print(responseObject);
          final Question question = Question.fromJson(responseObject);
          return question;
        } catch (e) {
          print(e.toString());
          throw AppError.serverError;
        }
      } else {
        throw AppError.serverError;
      }
    }).catchError((Object e) {
      throw e;
    });
  }
}
