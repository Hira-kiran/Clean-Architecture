import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repo/post_state.dart';

final postProvider =
    StateNotifierProvider<PostsNotifier, PostState>((ref) => PostsNotifier());
