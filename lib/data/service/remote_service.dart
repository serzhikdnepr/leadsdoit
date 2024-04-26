abstract class RemoteService {
  Future<dynamic> searchRepositories(String text, int page, int perPage);
}
