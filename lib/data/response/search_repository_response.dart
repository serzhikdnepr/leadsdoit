import 'package:leadsdoit_project/domain/model/repository_item.dart';

class SearchRepositoryResponse {
  SearchRepositoryResponse({
    num? totalCount,
    bool? incompleteResults,
    List<RepositoryItem>? repositories,
  }) {
    _totalCount = totalCount;
    _incompleteResults = incompleteResults;
    _repositories = repositories;
  }

  SearchRepositoryResponse.fromJson(dynamic json) {
    _totalCount = json['total_count'];
    _incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      _repositories = [];
      json['items'].forEach((v) {
        _repositories?.add(RepositoryItem.fromJson(v));
      });
    }
  }

  num? _totalCount;
  bool? _incompleteResults;
  List<RepositoryItem>? _repositories;

  num? get totalCount => _totalCount;

  bool? get incompleteResults => _incompleteResults;

  List<RepositoryItem>? get repositories => _repositories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_count'] = _totalCount;
    map['incomplete_results'] = _incompleteResults;
    if (_repositories != null) {
      map['items'] = _repositories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
