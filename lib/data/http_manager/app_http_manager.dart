import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:leadsdoit_project/data/http_manager/http_manager.dart';

import '../../core/constants.dart';
import '../../domain/exceptions/app_exceptions.dart';

const timeout = Duration(seconds: 4);

class AppHttpManager implements HttpManager {
  @override
  Future postFormData(
      {required String url,
      required FormData body,
      required Map<String, dynamic> query,
      Map<String, String>? headers}) async {
    try {
      var _headers = await _headerBuilder(headers, isFile: true);
      debugPrint(
          'Api PostFormData request url $url, with ${body.fields} - * - ${body.files}');
      final response = await Dio().post(
        _queryBuilder(url, query),
        data: body,
        options: Options(
          headers: _headers,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return _returnResponseDio(response);
    } on DioException catch (e) {
      if (e.response != null) {
        _returnResponseDio(e.response!);
      } else {
        throw NetworkException();
      }
    }
  }

  @override
  Future get(
      {required String url,
      required Map<String, dynamic> query,
      Map<String, String>? headers}) async {
    try {
      var _headers = await _headerBuilder(headers);
      debugPrint('Api Get request url $url, with $query');
      final response = await Dio().get(
        _queryBuilder(url, query),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: _headers,
          responseType: ResponseType.json,
          sendTimeout: timeout,
          receiveTimeout: timeout,
        ),
      );
      return _returnResponseDio(response);
    } on DioException catch (e) {
      if (e.response != null) {
        _returnResponseDio(e.response!);
      } else {
        debugPrint(e.message);
        throw NetworkException();
      }
    }
  }

  @override
  Future post(
      {required String url,
      required Map body,
      Map<String, dynamic>? query,
      Map<String, String>? headers}) async {
    try {
      var _headers = await _headerBuilder(headers);
      debugPrint('Api Post request url $url, with $body');
      final response = await Dio().post(
        _queryBuilder(url, query),
        data: body,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: _headers,
          responseType: ResponseType.json,
          sendTimeout: timeout,
          receiveTimeout: timeout,
        ),
      );
      return _returnResponseDio(response);
    } on DioException catch (e) {
      if (e.response != null) {
        _returnResponseDio(e.response!);
      } else {
        debugPrint(e.message);
        throw NetworkException();
      }
    }
  }

  Future<dynamic> postAvatar(
      {required String url,
      required FormData body,
      required Map<String, dynamic> query,
      Map<String, String>? headers}) async {
    try {
      var _headers = await _headerBuilder(headers, isFile: true);
      final response = await Dio().post(
        _queryBuilder(url, query),
        data: body,
        options: Options(
          headers: _headers,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return _returnResponseDio(response);
    } on DioException catch (e) {
      if (e.response != null) {
        _returnResponseDio(e.response!);
      } else {
        debugPrint(e.message);
        throw NetworkException();
      }
    }
  }

  @override
  Future<dynamic> put(
      {required String url,
      required Map body,
      Map<String, dynamic>? query,
      Map<String, String>? headers}) async {
    try {
      var _headers = await _headerBuilder(headers);
      debugPrint('Api Put request url $url, with $body');
      final response = await Dio().put(
        _queryBuilder(url, query),
        data: body,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: _headers,
          responseType: ResponseType.json,
          sendTimeout: timeout,
          receiveTimeout: timeout,
        ),
      );
      return _returnResponseDio(response);
    } on DioException catch (e) {
      if (e.response != null) {
        _returnResponseDio(e.response!);
      } else {
        debugPrint(e.message);
        throw NetworkException();
      }
    }
  }

  @override
  Future<dynamic> delete(
      {required String url,
      required Map<String, dynamic> query,
      Map<String, String>? headers}) async {
    var _headers = await _headerBuilder(headers);
    try {
      debugPrint('Api Delete request url $url');
      final response = await Dio().delete(
        _queryBuilder(url, query),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: _headers,
          responseType: ResponseType.json,
          sendTimeout: timeout,
          receiveTimeout: timeout,
        ),
      );
      return _returnResponseDio(response);
    } on DioException catch (e) {
      if (e.response != null) {
        _returnResponseDio(e.response!);
      } else {
        print(e.message);
        throw NetworkException();
      }
    }
  }

  Future<Map<String, String>> _headerBuilder(Map<String, String>? headers,
      {bool isFile = false}) async {
    final headers = Map<String, String>();
    headers[HttpHeaders.acceptCharsetHeader] =
        !isFile ? 'application/json' : "multipart/form-data";
    headers[HttpHeaders.acceptHeader] = 'application/json';
    headers['DeviceOs'] = Platform.operatingSystem;

    if (headers.isNotEmpty) {
      headers.forEach((key, value) {
        headers[key] = value;
      });
    }
    return headers;
  }

  String _queryBuilder(String path, Map<String, dynamic>? query) {
    final buffer = StringBuffer();
    buffer.write(Constants.url + path);
    if (query != null) {
      if (query.isNotEmpty) {
        buffer.write('?');
      }
      query.forEach((key, value) {
        buffer.write('$key=$value&');
      });
    }
    return buffer.toString();
  }

  dynamic _returnResponseDio(Response response) {
    final responseJson = response.data;
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      debugPrint('Api response success with $responseJson');
      if (response.statusCode! == 204) {
        return null;
      }
      return responseJson;
    }
    debugPrint("$responseJson");
    switch (response.statusCode) {
      case 400:
        {
          String message = "$responseJson";

          throw BadRequestException(message, message, response.statusCode);
        }
      case 401:
      case 403:
        throw UnauthorisedException("Invalid token", "", response.statusCode);
      case 500:
        {
          throw FetchDataException(
              'Error occurred while communication with Server with StatusCode : ${response.statusCode}');
        }
      default:
        {
          String message = "$responseJson";
          throw FetchDataException(message);
        }
    }
  }
}
