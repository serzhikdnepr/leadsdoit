/// id : 31792824
/// node_id : "MDEwOlJlcG9zaXRvcnkzMTc5MjgyNA=="
/// name : "flutter"
/// full_name : "flutter/flutter"
/// html_url : "https://github.com/flutter/flutter"
/// description : "Flutter makes it easy and fast to build beautiful apps for mobile and beyond"

/// url : "https://api.github.com/repos/flutter/flutter"
/// forks : 26568
/// open_issues : 12506
/// watchers : 161796
/// default_branch : "master"
/// score : 1

class RepositoryItem {
  RepositoryItem({
    num? id,
    String? nodeId,
    String? name,
    String? fullName,
    String? htmlUrl,
    String? description,
    String? url,
    num? forks,
    num? openIssues,
    num? watchers,
    String? defaultBranch,
    num? score,
    this.dateAdded
  }) {
    _id = id;
    _nodeId = nodeId;
    _name = name;
    _fullName = fullName;
    _htmlUrl = htmlUrl;
    _description = description;
    _url = url;
    _forks = forks;
    _openIssues = openIssues;
    _watchers = watchers;
    _defaultBranch = defaultBranch;
    _score = score;

  }

  RepositoryItem.fromJson(dynamic json) {
    _id = json['id'];
    _nodeId = json['node_id'];
    _name = json['name'];
    _fullName = json['full_name'];
    _htmlUrl = json['html_url'];
    _description = json['description'];
    _url = json['url'];
    _forks = json['forks'];
    _openIssues = json['open_issues'];
    _watchers = json['watchers'];
    _defaultBranch = json['default_branch'];
    _score = json['score'];
  }

  num? _id;
  String? _nodeId;
  String? _name;
  String? _fullName;
  String? _htmlUrl;
  String? _description;
  String? _url;
  num? _forks;
  num? _openIssues;
  num? _watchers;
  String? _defaultBranch;
  num? _score;
  num? dateAdded;

  num? get id => _id;

  String? get nodeId => _nodeId;

  String? get name => _name;

  String? get fullName => _fullName;

  String? get htmlUrl => _htmlUrl;

  String? get description => _description;

  String? get url => _url;

  num? get forks => _forks;

  num? get openIssues => _openIssues;

  num? get watchers => _watchers;

  String? get defaultBranch => _defaultBranch;

  num? get score => _score;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['node_id'] = _nodeId;
    map['name'] = _name;
    map['full_name'] = _fullName;
    map['html_url'] = _htmlUrl;
    map['description'] = _description;
    map['url'] = _url;
    map['forks'] = _forks;
    map['open_issues'] = _openIssues;
    map['watchers'] = _watchers;
    map['default_branch'] = _defaultBranch;
    map['score'] = _score;
    return map;
  }
}
