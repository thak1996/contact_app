import 'package:result_dart/result_dart.dart';
import '../../models/post.model.dart';

abstract class IPostInterface {
  AsyncResult<List<Post>> getPosts();
}
