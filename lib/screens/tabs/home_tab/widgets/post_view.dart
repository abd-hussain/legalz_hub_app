import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/home_posts_response.dart';

class PostsView extends StatelessWidget {
  final List<PostResponseData>? postsList;
  const PostsView({super.key, required this.postsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: postsList!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Container(
            //TODO: handle postView
            height: 10,
            color: Colors.amber,
          ),
        );
      },
    );
  }
}
