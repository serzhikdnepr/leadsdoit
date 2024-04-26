enum Status { SUCCESS, FAILURE }

class AppResult<T> {
  Status status;
  String? message;
  int? codeError;
  T? data;

  AppResult.success([this.data]) : status = Status.SUCCESS;

  AppResult.failure([this.message="",this.codeError]) : status = Status.FAILURE;
}
