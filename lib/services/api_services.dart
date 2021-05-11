import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:triviaapp/error/app_error.dart';

class ApiService {
  static const baseURL = "https://opentdb.com";

  Future<ParsedResponse> get(String path, {Map headers, Map params, bool needAuthentication = false}) async {
    var url;
    url = baseURL + path;
    url += _paramString(params);

    return http.get(url, headers: headers).timeout(
    Duration(seconds: 30),
    onTimeout: () {
      throw AppError.noInternet;

    },
    ).then((http.Response response) {
      final String res = response.body;
      final int code = response.statusCode;
      debugPrint("Status code for " + url + "::: " + code.toString());
      debugPrint("Response ::: " + res);

      if (res == null || res.isEmpty) {
        throw AppError.serverError;
      } else {
        return ParsedResponse(code, res);
      }
    }).catchError((Object e) {
      throw AppError.noInternet;
    });
  }

  String _paramString(Map<String, dynamic> parameters) {
    if (parameters == null || parameters.length == 0) {
      return "";
    }
    String paramsString = "";
    bool first = true;

    for (String key in parameters.keys) {
      if (first) {
        first = false;
        paramsString += "?";
      } else {
        paramsString += "&";
      }
      paramsString += key + "=" + parameters[key].toString();
    }
    return paramsString;
  }
}

class ParsedResponse {
  int code;
  String response;

  ParsedResponse(this.code, this.response);

  bool isOk() {
    return code == 200;
  }

  @override
  String toString() {
    return 'ParsedResponse{code : $code, response : " $response "}';
  }
}
