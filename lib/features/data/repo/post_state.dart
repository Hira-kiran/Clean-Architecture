// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasource/postApi.dart';
import '../models/postApi_model.dart';

@immutable
abstract class PostState {}

class InitialPostState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  List<PostApiModel> posts;
  PostLoadedState({
    required this.posts,
  });
}

class PostErrorState extends PostState {
  final String message;
  PostErrorState({
    required this.message,
  });
}

class PostsNotifier extends StateNotifier<PostState> {
  PostsNotifier() : super(InitialPostState());
  ApiRequests apiRequests = ApiRequests();

  fetchPosts() async {
    try {
      state = PostLoadingState();
      List<PostApiModel> postss = await apiRequests.postApiMethod();

      state = PostLoadedState(posts: postss);
    } catch (e) {
      state = PostErrorState(message: e.toString());
    }
  }
}
