abstract class AppState {}

class Loading extends AppState {}

class Success<T> extends AppState {
  final T? data;

  Success([this.data]);
}

class Failure extends AppState {
  final String? message;
  final int? codeError;

  Failure([this.message, this.codeError]);

}
