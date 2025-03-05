import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/response.model.dart';
import '../constants/constants.dart';
import '../interfaces/service.interface.dart';

import '../utils/error.stats.dart';

class BaseService implements IApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseURL,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['API_TOKEN']}',
      },
    ),
  );

  Dio get dio => _dio;

  @override
  Future<dynamic> post({
    required String route,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      late dynamic response;
      if (body != null) {
        response = await dio.post(
          route,
          data: body,
          options: Options(headers: headers),
          queryParameters: parameters,
        );
      } else {
        response = await dio.post(
          route,
          options: Options(headers: headers),
          queryParameters: parameters,
        );
      }
      return ResponseModel(
        data: response.data,
        statusCode: response.statusCode,
      );
    } on SocketException catch (e) {
      return ResponseModel(
        data: ErrorStatus.socketException.label,
        statusCode: e.hashCode,
      );
    } on HttpException catch (e) {
      return ResponseModel(
        data: ErrorStatus.httpException.label,
        statusCode: e.hashCode,
      );
    } on FormatException catch (e) {
      return ResponseModel(
        data: ErrorStatus.formatException.label,
        statusCode: e.hashCode,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return ResponseModel(
          data: ErrorStatus.unauthorized.label,
          statusCode: e.hashCode,
        );
      }
      if (e.response?.statusCode == 404) {
        return ResponseModel(
          data: ErrorStatus.notFound.label,
          statusCode: e.hashCode,
        );
      }
      return ResponseModel(
        data: e.response?.data ?? ErrorStatus.generalException.label,
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      return ResponseModel(
        data: ErrorStatus.generalException.label,
        statusCode: 404,
      );
    }
  }

  @override
  Future get({
    required String route,
    Map<String, dynamic>? parameters,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await dio.get(
        route,
        options: Options(headers: headers),
        queryParameters: parameters,
      );
      return ResponseModel(
        data: response.data,
        statusCode: response.statusCode,
      );
    } on SocketException catch (e) {
      return ResponseModel(
        data: ErrorStatus.socketException.label,
        statusCode: e.hashCode,
      );
    } on HttpException catch (e) {
      return ResponseModel(
        data: ErrorStatus.httpException.label,
        statusCode: e.hashCode,
      );
    } on FormatException catch (e) {
      return ResponseModel(
        data: ErrorStatus.formatException.label,
        statusCode: e.hashCode,
      );
    } catch (e) {
      return ResponseModel(
        data: ErrorStatus.generalException.label,
        statusCode: 404,
      );
    }
  }

  @override
  Future patch({
    required String route,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await dio.patch(
        route,
        data: body,
        options: Options(headers: headers),
      );
      return ResponseModel(
        data: response.data,
        statusCode: response.statusCode,
      );
    } on SocketException catch (e) {
      return ResponseModel(
        data: ErrorStatus.socketException.label,
        statusCode: e.hashCode,
      );
    } on HttpException catch (e) {
      return ResponseModel(
        data: ErrorStatus.httpException.label,
        statusCode: e.hashCode,
      );
    } on FormatException catch (e) {
      return ResponseModel(
        data: ErrorStatus.formatException.label,
        statusCode: e.hashCode,
      );
    } catch (e) {
      return ResponseModel(
        data: ErrorStatus.generalException.label,
        statusCode: 404,
      );
    }
  }

  @override
  Future delete({
    required String route,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      var response = await dio.delete(
        route,
        options: Options(headers: headers),
        queryParameters: parameters,
      );
      return ResponseModel(
        data: response.data,
        statusCode: response.statusCode,
      );
    } on SocketException catch (e) {
      return ResponseModel(
        data: ErrorStatus.socketException.label,
        statusCode: e.hashCode,
      );
    } on HttpException catch (e) {
      return ResponseModel(
        data: ErrorStatus.httpException.label,
        statusCode: e.hashCode,
      );
    } on FormatException catch (e) {
      return ResponseModel(
        data: ErrorStatus.formatException.label,
        statusCode: e.hashCode,
      );
    } catch (e) {
      return ResponseModel(
        data: ErrorStatus.generalException.label,
        statusCode: 404,
      );
    }
  }

  @override
  Future put({
    required String route,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      var response = await dio.put(
        route,
        data: body,
        options: Options(headers: headers),
        queryParameters: parameters,
      );
      return ResponseModel(
        data: response.data,
        statusCode: response.statusCode,
      );
    } on SocketException catch (e) {
      return ResponseModel(
        data: ErrorStatus.socketException.label,
        statusCode: e.hashCode,
      );
    } on HttpException catch (e) {
      return ResponseModel(
        data: ErrorStatus.httpException.label,
        statusCode: e.hashCode,
      );
    } on FormatException catch (e) {
      return ResponseModel(
        data: ErrorStatus.formatException.label,
        statusCode: e.hashCode,
      );
    } catch (e) {
      return ResponseModel(
        data: ErrorStatus.generalException.label,
        statusCode: 404,
      );
    }
  }
}
