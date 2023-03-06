import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_derslerim/my_services_belong/post_model.dart';
import 'package:http/http.dart' as http;

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  Dio myDio = Dio();

  Future<List<MyPostModel>?> getMyPostWithDio() async {
    final response =
        await myDio.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == HttpStatus.ok) {
      var data = response.data;
      if (data is List) {
        return data.map((e) => MyPostModel.fromJson(e)).toList();
      }
    }
    return null;
  }

  Future<List<MyPostModel>?> getMyPostWithHTTP() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == HttpStatus.ok) {
      List decoder = jsonDecode(response.body);
      return decoder.map((e) => MyPostModel.fromJson(e)).toList();
    }
    return null;
  }

  Future<void> postWithDio(MyPostModel data) async {
    final response = await myDio
        .post("https://jsonplaceholder.typicode.com/posts", data: data);
    if (response.statusCode == HttpStatus.created) {
      print("Succes with dio");
    }
  }

  Future<void> postWithHTTP(MyPostModel data) async {
    final response =
        await http.post(Uri.parse("https://jsonplaceholder.typicode.com/posts"),
            body: jsonEncode(<String, String>{
              'title': data.title.toString(),
            }));
    if (response.statusCode == HttpStatus.created) {
      print("Succes with http");
    }
  }

  Future<void> DeleteWithHTTP(MyPostModel data) async {
    final response = await http.delete(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        body: data);
    if (response.statusCode == HttpStatus.created) {
      print("Succes with http");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  //  postWithHTTP(MyPostModel(    id: 11, body: "123", title: "122", userId: 12));
                },
                icon: const Icon(Icons.send))
          ],
        ),
        body: FutureBuilder<List<MyPostModel>?>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  var deger = snapshot.data![index];
                  return ListTile(
                    title: Text(deger.title.toString()),
                    subtitle: Text(deger.body.toString()),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return const Center(
                child: Text("hata"),
              );
            }
          },
          future: getMyPostWithHTTP(),
        ));
  }
}
