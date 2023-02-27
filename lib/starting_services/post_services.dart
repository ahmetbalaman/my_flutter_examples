import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_derslerim/starting_services/comment_model.dart';
import 'package:flutter_derslerim/starting_services/post_model.dart';

abstract class IOPostModelServices {
  Future<List<PostModel>?> fetchPostItems();
  Future<List<CommentModel>?> fetchCommentItems(int postId);
  Future<bool> addItem(PostModel model);
  Future<bool> putItem(PostModel model, int id);
  Future<bool> deleteItem(int id);
}

class PostModelServices implements IOPostModelServices {
  late final Dio _dioManager;
  bool? isComplete;
  PostModelServices()
      : _dioManager =
            Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));

  @override
  Future<List<PostModel>?> fetchPostItems() async {
    try {
      final response = await _dioManager.get(PostServices.posts.name);
      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;
        if (datas is List) {
          return datas.map((e) => PostModel.fromJson(e)).toList();
        }
      }
    } on DioError catch (error) {
      _ShowDebug.showDioError(error, this);
    }
    return null;
  }

  @override
  Future<bool> addItem(PostModel model) async {
    try {
      final response =
          await _dioManager.post(PostServices.posts.name, data: model);
      return response.statusCode == HttpStatus.created;
    } on DioError catch (error) {
      _ShowDebug.showDioError(error, this);
    }
    return false;
  }

  @override
  Future<bool> putItem(PostModel model, int id) async {
    try {
      final response =
          await _dioManager.put("${PostServices.posts.name}/$id", data: model);
      return response.statusCode == HttpStatus.ok;
    } on DioError catch (error) {
      _ShowDebug.showDioError(error, this);
    }
    return false;
  }

  @override
  Future<bool> deleteItem(int id) async {
    try {
      final response = await _dioManager.put(
        "${PostServices.posts.name}/$id",
      );
      return response.statusCode == HttpStatus.ok;
    } on DioError catch (error) {
      _ShowDebug.showDioError(error, this);
    }
    return false;
  }

  @override
  Future<List<CommentModel>?> fetchCommentItems(int postId) async {
    try {
      final response = await _dioManager.get(PostServices.comments.name,
          queryParameters: {PostQueryPath.postId.name: postId});
      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;
        if (datas is List) {
          return datas.map((e) => CommentModel.fromJson(e)).toList();
        }
      }
    } on DioError catch (error) {
      _ShowDebug.showDioError(error, this);
    }
    return null;
  }
}

class _ShowDebug {
  static void showDioError<T>(DioError error, T type) {
    if (kDebugMode) {
      print(error);
      print(type);
      print("------");
    }
  }
}

enum PostServices { posts, comments }

enum PostQueryPath { postId }
