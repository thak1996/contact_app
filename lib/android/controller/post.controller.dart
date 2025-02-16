import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/services/post.serivce.dart';
import '../models/post.model.dart';

class PostController extends Cubit<PostState> {
  PostController() : super(PostInitial());

  final PostService _service = PostService();

  Future<void> fetchPosts() async {
    emit(PostLoading());
    await Future.delayed(Duration(seconds: 2));
    final result = await _service.getPosts();
    if (!isClosed) {
      result.fold(
        (posts) => emit(PostLoaded(posts)),
        (error) => emit(PostError(error.toString())),
      );
    }
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
