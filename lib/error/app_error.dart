class AppError {
  int _code;
  String _description;

  AppError(this._code, this._description);

  int get code => _code;

  String get description => _description;

  static AppError internalError = AppError(ErrorCode.INTERNAL_ERROR, 'unexpected_error_try_agin');
  static AppError noInternet = AppError(ErrorCode.NO_INTERNET, 'check_network');
  static AppError serverError = AppError(ErrorCode.SERVER_ERROR, 'server_communication_failed');

  @override
  String toString() {
    return 'AppError{code : $_code, description : " $_description "}';
  }
}

class ErrorCode {
  static const int INTERNAL_ERROR = -1;
  static const int NO_INTERNET = 100;
  static const int SERVER_ERROR = 101;

}
