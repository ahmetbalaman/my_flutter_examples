import 'package:flutter/material.dart';
import 'package:flutter_derslerim/starting_services/comment_model.dart';
import 'package:flutter_derslerim/starting_services/post_services.dart';

class CommentViewLearn extends StatefulWidget {
  final int? postId;

  const CommentViewLearn({super.key, this.postId});
  @override
  State<CommentViewLearn> createState() => _CommentViewLearnState();
}

class _CommentViewLearnState extends State<CommentViewLearn> {
  late final IOPostModelServices servis;
  List<CommentModel>? commentItems;
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
    servis = PostModelServices();
    fetchItemsWithId(widget.postId ?? 0);
  }

  Future<void> fetchItemsWithId(int postId) async {
    changeLoading();
    commentItems = await servis.fetchCommentItems(postId);
    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          isLoading ? CircularProgressIndicator.adaptive() : SizedBox.shrink()
        ],
      ),
      body: ListView.builder(
        itemCount: commentItems?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          if (commentItems?[index] != null) {
            CommentModel item = commentItems![index];
            return Card(
              child: ListTile(title: Text(item.email.toString())),
            );
          } else {
            return Card();
          }
        },
      ),
    );
  }
}
