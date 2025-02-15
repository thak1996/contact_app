import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import '../core/services/post.serivce.dart';
import '../models/post.model.dart';

class PostController extends Cubit<PostState> {
  PostController() : super(PostInitial()) {
    fetchPosts();
  }

  final PostService _service = PostService();

  AsyncResult<List<Post>> fetchPosts() async {
    emit(PostLoading());
    final result = await _service.getPosts();
    result.fold(
      (posts) => emit(PostLoaded(posts)),
      (error) => emit(PostError(error.toString())),
    );
    return result;
  }
}

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  PostLoaded(this.posts);

  final List<Post> posts;
}

class PostError extends PostState {
  PostError(this.message);

  final String message;
}
