class TranscribeResponse {
  TranscribeResponse({
      String? text,}){
    _text = text;
}

  TranscribeResponse.fromJson(dynamic json) {
    _text = json['text'];
  }
  String? _text;

  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    return map;
  }

}