import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_derslerim/my_services_belong/post_model.dart';
import 'package:http/http.dart' as http;

import '../starting_services/post_model.dart';

class HttpParseMethod extends StatefulWidget {
  const HttpParseMethod({super.key});

  @override
  State<HttpParseMethod> createState() => _HttpParseMethodState();
}

class _HttpParseMethodState extends State<HttpParseMethod> {
  Dio dioNesnesi = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com",
    ),
  );

  Future<List<PostModel>?> getMyPostWithDio() async {
    final response = await dioNesnesi.get("/posts");

    if (response.statusCode == HttpStatus.ok) {
      var data = response.data;
      if (data is List) {
        return data.map((e) => PostModel.fromJson(e)).toList();
      }
    }
  }

  Future<List<PostModel>?> getMyPost() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == HttpStatus.ok) {
      print(response.body);
      List decoder = jsonDecode(response.body);
      return decoder.map((e) => PostModel.fromJson(e)).toList();
    }
  }

  Future<void> get() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == HttpStatus.ok) {
      List decoder = jsonDecode(response.body);
      List<PostModel> a = decoder.map((e) => PostModel.fromJson(e)).toList();
      print(a[0].title.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Örnek Http parçalama"),
        ),
        body: FutureBuilder<List<PostModel>?>(
          future: getMyPostWithDio(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<PostModel> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var nesne = data[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      tileColor: Colors.grey,
                      title: Text(nesne.title.toString()),
                      subtitle: Text(nesne.body.toString()),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Center(
                child: Text("Hata Veri yok"),
              );
            }
          },
        ));
  }
}
