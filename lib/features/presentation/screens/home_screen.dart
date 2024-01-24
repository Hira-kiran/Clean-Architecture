import 'package:clean_architecture/features/data/repo/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/postApi_model.dart';
import '../providers/post_api_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postProvider.notifier).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post API"),
      ),
      body: Consumer(builder: (context, ref, child) {
        PostState state = ref.watch(postProvider);
        if (state is InitialPostState) {
          return const Center(child: Text("Press FAB to fetch data"));
        }

        if (state is PostLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PostLoadedState) {
          return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                PostApiModel postData = state.posts[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(postData.id.toString()),
                  ),
                  title: Text(
                    postData.title.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    postData.body.toString(),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              });
        } else {
          return const Text("No data found");
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(postProvider.notifier).fetchPosts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
