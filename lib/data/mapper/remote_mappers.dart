import 'package:leadsdoit_project/data/response/search_repository_response.dart';
import 'package:leadsdoit_project/domain/model/repository_item.dart';

List<RepositoryItem>? mapToRepositoryList(
    SearchRepositoryResponse searchRepositoryResponse) {
  return searchRepositoryResponse.repositories;
}