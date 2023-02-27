import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_derslerim/starting_services/comments_view.dart';
import 'package:flutter_derslerim/starting_services/post_model.dart';
import 'package:flutter_derslerim/starting_services/post_services.dart';

class ServiceLearnView extends StatefulWidget {
  const ServiceLearnView({super.key});

  @override
  State<ServiceLearnView> createState() => _ServiceLearnViewState();
}

class _ServiceLearnViewState extends State<ServiceLearnView> {
  List<PostModel>? _items;
  bool isLoading = false;
  late final Dio _dioManager;
  late final PostModelServices _service;
  final _baseUrl = 'https://jsonplaceholder.typicode.com/';
  @override
  void initState() {
    super.initState();
    _dioManager = Dio(BaseOptions(baseUrl: _baseUrl));
    fetchPostItems();
    _service = PostModelServices();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> fetchPostItems() async {
    changeLoading();
    final response = await _dioManager.get("posts");
    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data;
      if (datas is List) {
        setState(() {
          _items = datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
    changeLoading();
  }

  Future<void> fetchPostAdvancedItems() async {
    changeLoading();
    _items = await _service.fetchPostItems();
    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("working"),
        actions: [
          isLoading
              ? const CircularProgressIndicator.adaptive()
              : const SizedBox.shrink()
        ],
      ),
      body: _items == null
          ? SizedBox()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) {
                PostModel? item = _items?[index];
                return PostCard(item: item);
              },
              itemCount: _items?.length ?? 0,
            ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final PostModel? item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CommentViewLearn(postId: item?.id),
          ));
        },
        title: Text(item?.title ?? ''),
        subtitle: Text(item?.body ?? ''),
      ),
    );
  }
}
