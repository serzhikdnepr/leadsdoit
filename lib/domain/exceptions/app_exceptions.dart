
import '../../generated/l10n.dart';

class AppException implements Exception {
  final message;
  final _prefix;
  final codeError;
  AppException([this.message, this._prefix, this.codeError]);

  String toString() {
    return "$_prefix$message";
  }
}

class NetworkException extends AppException {
  NetworkException() : super(S.current.network_exception);
}

class FetchDataException extends AppException {
  FetchDataException([dynamic message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message,_prefix, codeError]) : super(message, "Something went wrong, please try again", codeError);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message,_prefix, codeError]) : super(message, "There is a problem with you authentication, please try again!",codeError);
}

class MissingParamsException extends AppException {
  MissingParamsException() : super("There is some missing params, check the widget for further information!");
}
