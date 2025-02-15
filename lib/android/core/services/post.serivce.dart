import 'package:contact_app/android/core/interfaces/post.interface.dart';
import 'package:contact_app/android/models/post.model.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import '../utils/exceptions.dart';
import 'service.dart';

class PostService extends BaseService implements IPostInterface {
  PostService() : super('https://gorest.co.in/public/v2');

  @override
  AsyncResult<List<Post>> getPosts() async {
    try {
      final response = await get('/posts');
      final List<dynamic> data = response.data;
      final contacts = data.map((json) => Post.fromMap(json)).toList();
      return Success(contacts);
    } on DioException catch (e) {
      return Failure(
        GeneralException(e.message ?? 'Erro ao carregar contatos'),
      );
    }
  }
}
