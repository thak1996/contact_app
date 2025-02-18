import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../interfaces/service.interface.dart';

class BaseService implements IService {
  final String baseUrl;
  final Dio dio;

  BaseService(this.baseUrl)
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Authorization': 'Bearer ${dotenv.env['API_TOKEN']}',
          },
        ));

  @override
  Future<Response> get(String endpoint) async {
    final response = await dio.get(endpoint);
    return response;
  }

  @override
  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    final response = await dio.post(endpoint, data: data);
    return response;
  }

  @override
  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    final response = await dio.put(endpoint, data: data);
    return response;
  }

  @override
  Future<Response> delete(String endpoint) async {
    final response = await dio.delete(endpoint);
    return response;
  }

  @override
  Future<Response> patch(String endpoint, Map<String, dynamic> data) async {
    final response = await dio.patch(endpoint, data: data);
    return response;
  }
}
