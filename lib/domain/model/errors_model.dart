


class ErrorsModel {
    String? devMessage;
    String? errorMessage;

    ErrorsModel({this.devMessage, this.errorMessage});

    factory ErrorsModel.fromJson(Map<String, dynamic> json) =>
        ErrorsModel(
            devMessage: json['devMessage'] as String,
            errorMessage: json['errorMessage'] as String,
        );

    Map<String, dynamic> toJson() => <String, dynamic>{
        'devMessage': devMessage,
        'errorMessage': errorMessage,
    };
}
