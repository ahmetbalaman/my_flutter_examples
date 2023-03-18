import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_derslerim/my_services_belong/post_model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import '../starting_services/post_model.dart';

class HttpParseSiteMethod extends StatefulWidget {
  const HttpParseSiteMethod({super.key});

  @override
  State<HttpParseSiteMethod> createState() => _HttpParseSiteMethodState();
}

class _HttpParseSiteMethodState extends State<HttpParseSiteMethod> {
  Future<String?> getirBaslik() async {
    final response = await http.Client()
        .get(Uri.parse("https://www.elele.com.tr/astroloji/burclar/koc"));
    if (response.statusCode == HttpStatus.ok) {
      dynamic document = parse(response.body);
      return document.getElementsByTagName("p")[0].text;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: getirBaslik(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(snapshot.data.toString()),
                  ElevatedButton(
                      onPressed: () {
                        getirBaslik();
                        setState(() {});
                      },
                      child: Text("Bas"))
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text("hata"),
              );
            }
          },
        ));
  }
}
