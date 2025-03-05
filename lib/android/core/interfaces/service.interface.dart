abstract class IApiService {
  Future<dynamic> post({
    required String route,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  });

  Future<dynamic> get({
    required String route,
    Map<String, dynamic>? parameters,
    Map<String, String>? headers,
  });

  Future<dynamic> patch({
    required String route,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  });

  Future<dynamic> delete({
    required String route,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  });

  Future<dynamic> put({
    required String route,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  });
}
