import 'package:dio/dio.dart';

abstract class HttpManager {
  Future<dynamic> get(
      {required String url,
      required Map<String, dynamic> query,
      Map<String, String> headers});

  Future<dynamic> post(
      {required String url,
      required Map body,
      Map<String, dynamic> query,
      Map<String, String> headers});

  Future<dynamic> put(
      {required String url,
      required Map body,
      Map<String, dynamic> query,
      Map<String, String> headers});

  Future<dynamic> delete(
      {required String url,
      required Map<String, dynamic> query,
      Map<String, String>? headers});

  Future<dynamic> postFormData(
      {required String url,
      required FormData body,
      required Map<String, dynamic> query,
      Map<String, String>? headers});
}
